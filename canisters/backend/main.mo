import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Int "mo:base/Int";
import Time "mo:base/Time";
import CkBtcLedger "canister:ckbtc_ledger";
import Types "./types";
import { toAccount; toSubaccount; } "./utils";
import Error "mo:base/Error";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Utils "utils";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Nat64 "mo:base/Nat64";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor Backend {

  
  let addressConverter_ = Utils.addressConverter;
  public type Payments = List.List<Types.Transaction>;
  public type Users = List.List<Types.User>;
  public type Posts = List.List<Types.Invoice>;
    // The type of a user identifier.
  public type UserId = Nat32;
    public type TransactionId = Nat32;

  // The next available user identifier.
  private stable var next : UserId = 0;

   private stable var nextTransaction : TransactionId = 0;

  // The superhero data store.
  private stable var users : Trie.Trie<UserId, Types.User> = Trie.empty();
  private stable var transactions : Trie.Trie<TransactionId, Types.Transaction> = Trie.empty();

/**
   * High-Level API
   */

  // Create a superhero.
  public func create(user : Types.User) : async UserId {
    let userId = next;
    next += 1;
    users := Trie.replace(
      users,
      key(userId),
      eq,
      ?user,
    ).0;
    return userId;
  };

  //create a transaction
  public func saveTransaction(transaction : Types.Transaction) : async TransactionId {
    let transactionId = nextTransaction;
    nextTransaction += 1;
    transactions := Trie.replace(
      transactions,
      key(transactionId),
      eq,
      ?transaction,
    ).0;
    return transactionId;
  };


  // Read a superhero.
  public query func read(userId : UserId) : async ?Types.User {
    let result = Trie.find(users, key(userId), eq);
    return result;
  };

  // Update a superhero.
  public func update(userId : UserId, user : Types.User) : async Bool {
    let result = Trie.find(users, key(userId), eq);
    let exists = Option.isSome(result);
    if (exists) {
      users := Trie.replace(
        users,
        key(userId),
        eq,
        ?user,
      ).0;
    };
    return exists;
  };

  // Delete a superhero.
  public func delete(userId : UserId) : async Bool {
    let result = Trie.find(users, key(userId), eq);
    let exists = Option.isSome(result);
    if (exists) {
      users := Trie.replace(
        users,
        key(userId),
        eq,
        null,
      ).0;
    };
    return exists;
  };

  //get all heroes
  public query func getAllUsers() : async Trie.Trie<UserId, Types.User> {
   
    return users;
  };

  //no of users
  public query func userLength() : async Text {
   var size = Trie.size(users); 
    return Nat.toText(size);
  };

  //no of transactions
  public query func transactionsLength() : async Text {
   var size = Trie.size(transactions); 
    return Nat.toText(size);
  };

  public shared ({ caller }) func whoami() : async Principal {
    return caller;
  };

  public shared ({ caller }) func getInvoice() : async Types.Account {

    return toAccount({ caller; canister = Principal.fromActor(Backend) });
    // Debug.print(Debug_show(toAccount({ caller; canister = Principal.fromActor(Backend) })));
  };

 

  public shared ({ caller }) func getFundingBalance() : async Text {
    let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = caller;
        subaccount = null;
      },
      //  toAccount({ caller; canister = Principal.fromActor(Backend) })
    );
    return Nat.toText(balance);
  };

  public shared ({ caller }) func getTradingBalance() : async Text {
    let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = Principal.fromActor(Backend);
        subaccount = ?toSubaccount(caller);
      },
      //  toAccount({ caller; canister = Principal.fromActor(Backend) })
      // owner = Principal.fromActor(Backend) ;
      //  subaccount = ?toSubaccount(caller);
    );
    return Nat.toText(balance);
  };

  public shared ({ caller }) func getCanisterBalance() : async Text {
    let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = Principal.fromActor(Backend);
        subaccount = null;
      },
      //  toAccount({ caller; canister = Principal.fromActor(Backend) })
      // owner = Principal.fromActor(Backend) ;
      //  subaccount = ?toSubaccount(caller);
    );
    return Nat.toText(balance);
  };

  public shared ({ caller }) func getFundingAddress() : async Text {
    let acc : Types.Account = {
      owner = caller;
      subaccount = null;
    };
    let address = addressConverter_.toText(acc);
    return address;
  };

  public shared ({ caller }) func getTradingAddress() : async Text {
    let acc : Types.Account = {
      owner = Principal.fromActor(Backend);
      subaccount = ?toSubaccount(caller);
    };
    let address = addressConverter_.toText(acc);
    return address;
  };

  public shared ({ caller }) func getCanisterAddress() : async Text {
    let acc : Types.Account = {
      owner = Principal.fromActor(Backend);
      subaccount = null;
    };
    let address = addressConverter_.toText(acc);
    return address;
  };

  //transfer funds from the default canister subaccount to the user subaccount
  //Works
  public shared ({ caller }) func transferFromCanistertoSubAccount() : async Result.Result<Text, Text> {

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      {
        owner = Principal.fromActor(Backend);
        subaccount = null;
      }
    );

    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

    Debug.print("balance:  is  " # debug_show (balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = balance -10;
          from_subaccount = null;
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromActor(Backend);
            subaccount = ?toSubaccount(caller);
          };
        }
      );

      Debug.print("transferresult:  is  " # debug_show (transferResult));

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

  //transfer from one subaccount to another
  //works
  public shared ({ caller }) func transferFromSubAccountToSubAccount(receiver : Text, amount : Nat) : async Result.Result<Text, Text> {

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      {
        owner = Principal.fromActor(Backend);
        subaccount = ?toSubaccount(caller);
      }
    );

    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

    Debug.print(" su acc balance:  is  " # debug_show (balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = amount;
          from_subaccount = ?toSubaccount(caller);
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromActor(Backend);
            subaccount = ?toSubaccount(Principal.fromText(receiver));
          };
        }
      );

      Debug.print("fom subaccount transferresult:  is  " # debug_show (transferResult));

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

/**
   * Utilities
   */

  // Test two superhero identifiers for equality.
  private func eq(x : UserId, y : UserId) : Bool {
    return x == y;
  };

  // Create a trie key from a superhero identifier.
  private func key(x : UserId) : Trie.Key<UserId> {
    return { hash = x; key = x };
  };


};
