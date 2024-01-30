import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import CkBtcLedger "canister:ckbtc_ledger";
import Types "./types";
import { toAccount; toSubaccount;defaultSubaccount } "./utils";
import Error "mo:base/Error";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Utils "utils";
import HashMap "mo:base/HashMap";
import TrieMap "mo:base/TrieMap";
import List "mo:base/List";
import Nat64 "mo:base/Nat64";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";
import HttpTypes "http/http.types";
import Cycles "mo:base/ExperimentalCycles";
import Buffer "mo:base/Buffer";



shared (actorContext) actor class Backend(_startBlock : Nat) = this {

  let addressConverter_ = Utils.addressConverter;
 // The type of a user identifier.
  public type UserId = Nat32;
  public type TransactionId = Nat32;
  private stable var latestTransactionIndex : Nat = 0;
  private stable var courierApiKey : Text = "";
  private var logData = Buffer.Buffer<Text>(0);
  private stable var next : UserId = 0;
  

  //create a list of users in motoko
  //each employer has a list of freelancers
let map = HashMap.HashMap<Principal, Types.User>(1, Principal.equal, Principal.hash);

public shared ({ caller }) func addemployer(employer : Types.User) : async Principal {
  map.put(Principal.fromText(employer.wallet), employer);

return Principal.fromText(employer.wallet);
};

public shared ({ caller }) func register(
     id : Nat,
    name : Text,
    email : Text,
    email_notifications : Bool,
    phone : Text,
    phone_notifications : Bool,
    wallet : Text,
    created_at : Int,
  ) : async () {
    if(Principal.isAnonymous(caller)){
        // Dont register if caller is anonymous
        return;
    };

    let user : Types.User = {
        id = id;
        name;
        email;
        email_notifications;
        phone;
        phone_notifications;
        wallet;
        created_at;
        
    };
    
    map.put(Principal.fromText(wallet), user);
};

//get single user
public query func getUser(p : Principal) : async ?Types.User {
map.get(p);
};

// get all users .using .vals()
public query func getUsers() : async [Types.User] {
  let buffer = Buffer.Buffer<Types.User>(100);
// let users : [Types.User] = [];
  for (value in map.vals()) {
  buffer.add(value);
};
return buffer.toArray();
};

  // The user data store.
  private stable var users : Trie.Trie<UserId, Types.User> = Trie.empty();
  private stable var transactions : Trie.Trie<TransactionId, Types.Transaction> = Trie.empty();


  /**
   * High-Level API
   */



  // Create a user.
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

    return toAccount({ caller; canister = Principal.fromActor(this) });
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
        owner = Principal.fromActor(this);
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
        owner = Principal.fromActor(this);
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
      owner = Principal.fromActor(this);
      subaccount = ?toSubaccount(caller);
    };
    let address = addressConverter_.toText(acc);
    return address;
  };

  public shared ({ caller }) func getCanisterAddress() : async Text {
    let acc : Types.Account = {
      owner = Principal.fromActor(this);
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
        owner = Principal.fromActor(this);
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
            owner = Principal.fromActor(this);
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
        owner = Principal.fromActor(this);
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
            owner = Principal.fromActor(this);
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


  //transfer from account to canister subaccount
  //works
  public shared ({ caller }) func transferFromSubAccountToCanister(amount : Nat) : async Result.Result<Text, Text> {

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      {
        owner = caller;
        subaccount = null;
      }
    );

    if (balance < 100) {
      return #err("Not enough funds available in Personal  Account. Make sure you send at least 100 ckSats.");
    };

    Debug.print("Personal Account Balance:  is  " # debug_show (balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = balance -10;
          from_subaccount = ?toSubaccount(caller);
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromActor(this);
            subaccount = ?toSubaccount(caller);
          };
        }
      );

      Debug.print("fom personal account to trading account balance is :  " # debug_show (transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to trading account:\n" # debug_show (transferError));
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


 private func toledger() : Blob {
      let principal = Principal.fromText("un4fu-tqaaa-aaaab-qadjq-cai");
let subAccount : Blob = "\4A\8D\3F\2B\6E\01\C8\7D\9E\03\B4\56\7C\F8\9A\01\D2\34\56\78\9A\BC\DE\F0\12\34\56\78\9A\BC\DE\F0";
let account = Principal.toBlob(principal); 
// => \8C\5C\20\C6\15\3F\7F\51\E2\0D\0F\0F\B5\08\51\5B\47\65\63\A9\62\B4\A9\91\5F\4F\02\70\8A\ED\4F\82
return account;
  };

  // Test two superhero identifiers for equality.
  private func eq(x : UserId, y : UserId) : Bool {
    return x == y;
  };

  // Create a trie key from a superhero identifier.
  private func key(x : UserId) : Trie.Key<UserId> {
    return { hash = x; key = x };
  };

  /**
    * Set the courier API key. Only the owner can set the courier API key.
    */
  public shared (context) func setCourierApiKey(apiKey : Text) : async Types.Response<Text> {
    if (not Principal.equal(context.caller, actorContext.caller)) {
      return {
        status = 403;
        status_text = "Forbidden";
        data = null;
        error_text = ?"Only the owner can set the courier API key.";
      };
    };
    courierApiKey := apiKey;
    {
      status = 200;
      status_text = "OK";
      data = ?courierApiKey;
      error_text = null;
    };
  };

  /**
  * Get latest log items. Log output is capped at 100 items.
  */
  public query func getLogs() : async [Text] {
    Buffer.toArray(logData);
  };

  /**
    * Log a message. Log output is capped at 100 items.
    */
  private func log(text : Text) {
    Debug.print(text);
    logData.reserve(logData.size() + 1);
    logData.insert(0, text);
    // Cap the log at 100 items
    if (logData.size() == 100) {
      let x = logData.removeLast();
    };
    return;
  };

  /**
    * Check for new transactions and notify the merchant if a new transaction is found.
    * This function is called by the global timer.
    */
  // system func timer(setGlobalTimer : Nat64 -> ()) : async () {
  //   let next = Nat64.fromIntWrap(Time.now()) + 20_000_000_000; // 20 seconds
  //   setGlobalTimer(next);
  //   await notify();
  // };

  /**
    * Notify the merchant if a new transaction is found.
    */
  // private func notify() : async () {
  //   var start : Nat = _startBlock;
  //   if (latestTransactionIndex > 0) {
  //     start := latestTransactionIndex + 1;
  //   };

  //   var response = await CkBtcLedger.get_transactions({
  //     start = start;
  //     length = 1;
  //   });

  //   if (Array.size(response.transactions) > 0) {
  //     latestTransactionIndex := start;

  //     if (response.transactions[0].kind == "transfer") {
  //       let t = response.transactions[0];
  //       switch (t.transfer) {
  //         case (?transfer) {
  //           let to = transfer.to.owner;
  //           switch (Trie.get(users, key(Principal.toText(to)), Text.equal)) {
  //             case (?user) {
  //               if (user.email_notifications or merchant.phone_notifications) {
  //                 log("Sending notification to: " # debug_show (merchant.email_address));
  //                 await sendNotification(user, t);
  //               };
  //             };
  //             case null {
  //               // No action required if merchant not found
  //             };
  //           };
  //         };
  //         case null {
  //           // No action required if transfer is null
  //         };
  //       };
  //     };
  //   };
  // };

  /**
    * Send a notification to a merchant about a received payment
    */
  // private func sendNotification(merchant : Types.User, transaction : CkBtcLedger.Transaction) : async () {
  //   // Managment canister
  //   let ic : HttpTypes.IC = actor ("aaaaa-aa");

  //   // Create request body
  //   var amount = "0";
  //   var from = "";
  //   switch (transaction.transfer) {
  //     case (?transfer) {
  //       amount := Nat.toText(transfer.amount);
  //       from := Principal.toText(transfer.from.owner);
  //     };
  //     case null {};
  //   };
  //   let idempotencyKey : Text = Text.concat(user.name, Nat64.toText(transaction.timestamp));
  //   let requestBodyJson : Text = "{ \"idempotencyKey\": \"" # idempotencyKey # "\", \"email\": \"" # user.email_address # "\", \"phone\": \"" # user.phone_number # "\", \"amount\": \"" # amount # "\", \"payer\": \"" # from # "\"}";
  //   let requestBodyAsBlob : Blob = Text.encodeUtf8(requestBodyJson);
  //   let requestBodyAsNat8 : [Nat8] = Blob.toArray(requestBodyAsBlob);

  //   // Setup request
  //   let httpRequest : HttpTypes.HttpRequestArgs = {
  //     // The notification service is hosted on Netlify and the URL is hardcoded
  //     // in this example. In a real application, the URL would be configurable.
  //     url = "https://icpos-notifications.xyz/.netlify/functions/notify";
  //     max_response_bytes = ?Nat64.fromNat(1000);
  //     headers = [
  //       { name = "Content-Type"; value = "application/json" },
  //     ];
  //     body = ?requestBodyAsNat8;
  //     method = #post;
  //     transform = null;
  //   };

  //   // Cycle cost of sending a notification
  //   // 49.14M + 5200 * request_size + 10400 * max_response_bytes
  //   // 49.14M + (5200 * 1000) + (10400 * 1000) = 64.74M
  //   Cycles.add(70_000_000);

  //   // Send the request
  //   let httpResponse : HttpTypes.HttpResponsePayload = await ic.http_request(httpRequest);

  //   // Check the response
  //   if (httpResponse.status > 299) {
  //     let response_body : Blob = Blob.fromArray(httpResponse.body);
  //     let decoded_text : Text = switch (Text.decodeUtf8(response_body)) {
  //       case (null) { "No value returned" };
  //       case (?y) { y };
  //     };
  //     log("Error sending notification: " # decoded_text);
  //   } else {
  //     log("Notification sent");
  //   };
  // };

  system func postupgrade() {
    // Make sure we start to montitor transactions from the block set on deployment
    latestTransactionIndex := _startBlock;
  };

 //get list of users to json format



};
