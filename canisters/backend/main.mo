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
import { toAccount; toSubaccount;createSubAccount; } "./utils";

import Types "./types";
import Utils "./utils";
shared ({ caller = installer_ }) actor class PaymentProcessor() = this {

  let { phash; thash } = Map;

  let usersPaymentsCreatedCountMap_ = Map.new<Principal, Nat>(phash);
  let usersPaymentsMap_ = Map.new<Principal, [Types.Payment]>(phash);

  let addressConverter_ = Utils.addressConverter;

  var icrc1Actor_ : Types.ICRC1TokenCanisterActorInterface = actor ("mxzaz-hqaaa-aaaar-qaada-cai");
  var icrc1TokenCanisterId_ : Text = Types.INVALID_CANISTER_ID;
  var icrc1TokenCanisterDecimals_ : Nat8 = 8;


 public shared ({ caller }) func whoami() : async Principal {
return caller;
 };

  /** Get's this canister's id.  */
  func getCanisterId_() : Principal { Principal.fromActor(this) };

  func getUsersPaymentsCreationCount_(p : Principal) : Nat {
    switch (Map.get(usersPaymentsCreatedCountMap_, phash, p)) {
      case (null) return 0;
      case (?count) return count;
    };
  };

  func incrementGetUsersPaymentsCount_(p : Principal) : Nat {
    var c = getUsersPaymentsCreationCount_(p);
    c += 1;
    ignore Map.put(usersPaymentsCreatedCountMap_, phash, p, c);
    return c;
  };

  func getUsersPayments_(p : Principal) : [Types.Payment] {
    switch (Map.get(usersPaymentsMap_, phash, p)) {
      case (null) return [];
      case (?ps) return ps;
    };
  };

  func createPutPayment_({
    caller : Principal;
    account : Types.Account;
    clientPaymentId : Text;
    amount : Nat;
    description : ?Text;
    recipientAddress : Text;
    status : Types.PaymentStatus;
  }) : Types.Payment {
    let paymentCountNumber = incrementGetUsersPaymentsCount_(caller);
    let id = "cn" # Nat.toText(paymentCountNumber) # "-ci" # clientPaymentId;
    var payments : [Types.Payment] = getUsersPayments_(caller);
    let p : Types.Payment = {
      id;
      number = paymentCountNumber;
      clientPaymentId;
      createdAtNs = Time.now();
      amount;
      description;
      sourceAddress = addressConverter_.toText(account);
      recipientAddress;
      status;
    };
    payments := Array.flatten<Types.Payment>([[p], payments]);
    ignore Map.put(usersPaymentsMap_, phash, caller, payments);
    return p;
  };

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

  public func get_icrc1_token_canister_metadata() : async Types.GetTokenCanisterMetadataResult {
    // Reject if the icrc1 token canister id has not been set valid.
    //assert (not (icrc1TokenCanisterId_ == Types.INVALID_CANISTER_ID));
    // Anonymous calls valid so landing page can show data.
    var metadata : Types.Metadatas = [];
    try {
      metadata := await icrc1Actor_.icrc1_metadata();
    } catch e {
      return #err({
        msg = "Intercanister icrc1 metadata query caught error: " # Error.message(e);
      });
    };
    #ok({ metadata; canisterId = icrc1TokenCanisterId_ });
  };

  public shared query ({ caller }) func get_account_address() : async Types.GetAccountAddress {
    {
      accountAddress = addressConverter_.toText(Utils.getAccountUserSubaccount({ canisterId = getCanisterId_(); user = caller }));
    };
  };

  public shared ({ caller }) func get_account_balance() : async Types.GetAccountBalanceResult {
    if (Principal.isAnonymous(caller)) return #err({
      msg = "Anonymous callers are not authorized. ";
    });
    let account = Utils.getAccountUserSubaccount({
      canisterId = getCanisterId_();
      user = caller;
    });
    var currentBalance : Nat = 0;
    try {
      currentBalance := await icrc1Actor_.icrc1_balance_of(account);
    } catch e {
      return #err({
        msg = "Intercanister balance query caught error: " # Error.message(e);
      });
    };
    #ok({
      timestampNs = Time.now();
      accountAddress = addressConverter_.toText(account);
      currentBalance;
    });
  };

  public shared query ({ caller }) func get_account_payments() : async Types.GetAccountPayments {
    // Reject if anonymous:
    assert (not Principal.isAnonymous(caller));
    {
      timestampNs = Time.now();
      payments = getUsersPayments_(caller);
      createdCount = getUsersPaymentsCreationCount_(caller);
    };
  };

  public shared ({ caller }) func send_payment({
    clientPaymentId : Text;
    amount : Nat;
    description : ?Text;
    recipientAddress : Text;
  }) : async Types.SendPayment {
    // Reject if anonymous:
    assert (not Principal.isAnonymous(caller));
    // Reject if the icrc1 token canister id has not been set valid.
    //assert (not (icrc1TokenCanisterId_ == Types.INVALID_CANISTER_ID));
    // Attempt to create sender's subaccount so initial payment can be created:
    let account = Utils.getAccountUserSubaccount({
      canisterId = getCanisterId_();
      user = caller;
    });
    // Resolve the account creation attempt:
    switch (addressConverter_.fromText(recipientAddress)) {
      // Recipient address wasn't valid  icrc1 account encoded text:
      case (#err _) {
        // Payment attempt still saved and result returned to caller:
        let payment = createPutPayment_({
          clientPaymentId;
          caller;
          account;
          amount;
          description;
          recipientAddress;
          status = #Failed({
            timestampNs = Time.now();
            kind = #InvalidRecipientAddress({});
          });
        });
        return {
          payment;
          result = #err({
            msg = "The intended recipient address text was not valid ICRC1 account encoding.";
          });
        };
      };
      // Valid recipient address, continue to process payment:
      case (#ok(to)) {
        let p = createPutPayment_({
          clientPaymentId;
          caller;
          account;
          amount;
          description;
          recipientAddress;
          status = #Pending({});
        });
        // Make the icrc1 intercanister transfer call, catching if error'd:
        let response : Result.Result<Types.TransferResult, Types.PaymentError> = try {
          #ok(await icrc1Actor_.icrc1_transfer({ from_subaccount = account.subaccount; amount; fee = null; memo = null; created_at_time = null; to }));
        } catch (e) {
          #err(#InterCanisterCallCaughtError(Error.message(e)));
        };
        // Parse the results of the icrc1 intercansiter transfer call:
        let result : Result.Result<(Text, Types.PaymentStatus), (Text, Types.PaymentStatus)> = switch (response) {
          case (#ok(transferResult)) {
            switch (transferResult) {
              case (#Ok txIndex) #ok("", #Completed({ timestampNs = Time.now(); txIndex }));
              case (#Err transferErr) #err(
                "The icrc1 transfer call could not be completed as requested.",
                #Failed({
                  timestampNs = Time.now();
                  kind = #ICRC1TokenCanisterTransferErr(transferErr);
                }),
              );
            };
          };
          case (#err(kind)) #err(
            "The intercanister icrc1 transfer call caught an error and did not finish processing.",
            #Failed({ timestampNs = Time.now(); kind }),
          );
        };
        // Resolve the status to update the payment and return msg if err'd:
        let (msg, status) = switch (result) {
          case (#ok(t, s))(t, s);
          case (#err(t, s))(t, s);
        };
        let payment : Types.Payment = {
          id = p.id;
          number = p.number;
          clientPaymentId = p.clientPaymentId;
          createdAtNs = p.createdAtNs;
          amount = p.amount;
          description = p.description;
          sourceAddress = p.sourceAddress;
          recipientAddress = p.recipientAddress;
          status;
        };
        // Update the user's stored payments.
        let payments = Array.map<Types.Payment, Types.Payment>(
          getUsersPayments_(caller),
          func(p : Types.Payment) : Types.Payment {
            if (p.id == payment.id) { return payment } else {
              return p;
            };
          },
        );
        ignore Map.put(usersPaymentsMap_, phash, caller, payments);
        // Finally return the result:
        switch (result) {
          case (#ok _) {
            return { payment; result = #ok() };
          };
          case (#err _) {
            return { payment; result = #err({ msg }) };
          };
        };
      };
    };
  };

public shared ({ caller }) func getSubAccountBalance() : async Text {

    // check ckBTC balance of the callers dedicated account
    let balance = await icrc1Actor_.icrc1_balance_of(
      createSubAccount(
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
        { caller;}
        )
    );

    return Nat.toText(balance);

  };



};
