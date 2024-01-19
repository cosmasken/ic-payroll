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
import CkBtcLedger "canister:icrc1_ledger";

import Types "./types";
import Utils "./utils";
import ICRC1 "./icrc1-types";

actor Backend {
    

  var icrc1Actor_ : Types.ICRC1TokenCanisterActorInterface = actor ("mxzaz-hqaaa-aaaar-qaada-cai");
  var icrc1TokenCanisterId_ : Text = Types.INVALID_CANISTER_ID;
  var icrc1TokenCanisterDecimals_ : Nat8 = 8;

   let addressConverter_ = Utils.addressConverter;
   let toAccount = Utils.toAccount;
   let computeUserSubaccountAccount  = Utils.computeUserSubaccountAccount;

  /** Get's this canister's id.  */
  func getCanisterId_() : Principal { Principal.fromActor(Backend) };

  public func getCanister() : async Text {  
 return  Principal.toText(Principal.fromActor(Backend))
   };

     public shared (message) func whoami() : async Text {

    return Principal.toText(message.caller);
  };

  public shared ({caller}) func getMyBalance() : async Text  {
// check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      { owner = caller;
      subaccount = null;}
    );

    let formattedBalance = balance / 100000000;

    return Nat.toText(formattedBalance);
  };


  public shared({caller}) func transfer() : async Result.Result<Text, Text>  {
 let balance = await CkBtcLedger.icrc1_balance_of(
      { owner = caller;
      subaccount = null;}
    );


if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = 500;
          from_subaccount = null;
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromText("ingbq-lkoqj-qpaw2-erpne-uxyji-fumuf-xxm5s-6quwy-bpi6a-u4szd-nae");
            subaccount = null;
          };
        }
      );

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

  }


}