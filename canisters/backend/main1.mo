import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Error "mo:base/Error";
import HashMap "mo:base/HashMap";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Map "mo:map/Map";
import ICRC1 "./icrc1-types";
import { toAccount; toSubaccount; } "./utils";
import CkBtcLedger "canister:icrc1_ledger";

import Types "./types";
import Utils "./utils";
shared ({ caller = installer_ }) actor class PaymentProcessor() = this {

  let { phash; thash } = Map;
    public type Account = ICRC1.Account;

  let addressConverter_ = Utils.addressConverter;
  public type Subaccount = Blob;
  var icrc1Actor_ : Types.ICRC1TokenCanisterActorInterface = actor ("mxzaz-hqaaa-aaaar-qaada-cai");
  var icrc1TokenCanisterId_ : Text = Types.INVALID_CANISTER_ID;
  var icrc1TokenCanisterDecimals_ : Nat8 = 8;


 public shared ({ caller }) func whoami() : async Principal {
return caller;
 };

  /** Get's this canister's id.  */
  func getCanisterId_() : Principal { Principal.fromActor(this) };
  func whoiscanister() : Principal { Principal.fromActor(this) };
  


  public shared ({ caller }) func set_icrc1_token_canister(tokenCanisterId : Text) : async Result.Result<(), { msg : Text }> {
    if (Principal.isAnonymous(caller) or caller != installer_) return #err({
      msg = "Not authorized.";
    });
    let icrc1Canister : Result.Result<Types.ICRC1TokenCanisterActorInterface, Error> = try {
      #ok(await testCreateICRC1ActorInstance_(tokenCanisterId));
    } catch e #err(e);
    switch (icrc1Canister) {
      case (#ok(icrc1Actor)) {
        icrc1Actor_ := icrc1Actor;
        icrc1TokenCanisterId_ := tokenCanisterId;
        icrc1TokenCanisterDecimals_ := await icrc1Actor.icrc1_decimals();
        #ok;
      };
      case (#err(e)) {
        icrc1TokenCanisterId_ := Types.INVALID_CANISTER_ID;
        #err({
          msg = "Failed to instantiate icrc1 token canister from given id(" # tokenCanisterId # ") for reason " # Error.message(e);
        });
      };
    };
  };

  // Force the instantiation to be async so error can be caught if invalid id.
  func testCreateICRC1ActorInstance_(id : Text) : async Types.ICRC1TokenCanisterActorInterface {
    actor (id);
  };


  public shared query ({ caller }) func get_account_address() : async Types.GetAccountAddress {
    {
      accountAddress = addressConverter_.toText(
        Utils.getAccountUserSubaccount(
          { canisterId = getCanisterId_(); user = caller }
          )
          );
    };
  };

 
    public shared query ({ caller }) func canisterAccount() : async Blob {
  
  return toSubaccount(caller);

  };



    public shared ({ caller }) func getSubAccountBalance() : async Text {

    // check ckBTC balance of the callers dedicated account
    let balance = await icrc1Actor_.icrc1_balance_of(
      toAccount(
        { caller;
         canister = Principal.fromActor(this) }
        )
    );

    return Nat.toText(balance);

        };
        public shared ({ caller }) func getMyAccountBalance() : async Text {

          // check ckBTC balance of the callers dedicated account
          let balance = await icrc1Actor_.icrc1_balance_of(
          toAccount(
        { caller;
         canister = Principal.fromActor(this) }
        )
          );

          return Nat.toText(balance);

        };


    public shared ({ caller }) func transfer(text:Text) : async Result.Result<Text, Text> {

      // check ckBTC balance of the callers dedicated account
    let balance = await icrc1Actor_.icrc1_balance_of(
        toAccount({ caller; canister = Principal.fromActor(this) })
    );

      Debug.print("balance:  is  " # debug_show(balance));
   
       let address = addressConverter_.toText(
        Utils.getAccountUserSubaccount(
          { canisterId = getCanisterId_(); user = caller }
          )
          );
              Debug.print("address: caller is  " # debug_show(address));
                Debug.print("caller: caller is  " # debug_show(caller));
                Debug.print("canister: canister is  " # debug_show(Principal.fromActor(this)));

    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };



    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await icrc1Actor_.icrc1_transfer(
        {
          amount = 1;
          from_subaccount = ?toSubaccount(caller);
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromActor(this);
            subaccount = null
          };
        }
      );

      //Principal.fromText("mhtqk-553ib-2cd6n-gjmks-3gauf-pmrxr-ws2o2-vsbit-e4cxo-evqud-cae")

      Debug.print("transferResult: " # debug_show(transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to default account:\n" # debug_show (transferError));
        };
        case (_) {};
      };
    } catch (error : Error) {
      return #err("Reject message: " # Error.message(error));
    };

    return #ok("🥠: " # "success");
  };


};
