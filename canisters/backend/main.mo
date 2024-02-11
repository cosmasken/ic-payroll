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
import { toAccount; toSubaccount; defaultSubaccount } "./utils";
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
import Nat8 "mo:base/Nat8";
import Iter "mo:base/Iter";
import SHA224 "./SHA224";
import CRC32 "./CRC32";
import Hash "mo:base/Hash";
import Hex "./Hex";

shared (actorContext) actor class Backend(_startBlock : Nat) = this {

  // #region Types
  type Account = Types.Account;
  type AccountIdentifier = Types.AccountIdentifier;
  type Transaction = Types.Transaction;
  type User = Types.User;
  type Notification = Types.Notification;
   public type TransactionId = Nat32;
// #endregion

  let addressConverter_ = Utils.addressConverter;
// The next available transaction identifier.
  private stable var latestTransactionIndex : Nat = 0;
  private stable var courierApiKey : Text = "";
  private var logData = Buffer.Buffer<Text>(0);
  // The user data store. The key is the user's principal ID.
 private stable var userStore : Trie.Trie<Text, User> = Trie.empty();


  public shared ({ caller }) func getAddress() : async Text {
    let acc : Types.Account = {
      owner = Principal.fromActor(this);
      subaccount = ?toSubaccount(caller);
    };
    let address = addressConverter_.toText(acc);
    Debug.print("address:  is  " # debug_show (address));
    return address;
  };




  /**
   * High-Level API
   */

     /**
    *  Get the merchant's information
    */
  public query (context) func getUser() : async Types.Response<User> {
    let caller : Principal = context.caller;

    switch (Trie.get(userStore, userKey(Principal.toText(caller)), Text.equal)) {
      case (?user) {
        {
          status = 200;
          status_text = "OK";
          data = ?user;
          error_text = null;
        };
      };
      case null {
        {
          status = 404;
          status_text = "Not Found";
          data = null;
          error_text = ?("User with principal ID: " # Principal.toText(caller) # " not found.");
        };
      };
    };
  };


     /**
    *  Check if user exists and return Bool
    */
  public query (context) func userExists() : async Bool {
    let caller : Principal = context.caller;

    switch (Trie.get(userStore, userKey(Principal.toText(caller)), Text.equal)) {
      case (?user) {
        return true;
      };
      case null {
        return false;
      };
    };
  };




  /**
    * Update the merchant's information
    */
  public shared (context) func updateUser(user : User) : async Types.Response<User> {

    let caller : Principal = context.caller;
    userStore := Trie.replace(
      userStore,
      userKey(Principal.toText(caller)),
      Text.equal,
      ?user,
    ).0;
    {
      status = 200;
      status_text = "OK";
      data = ?user;
      error_text = null;
    };
  };




  //no of users
  public query func userLength() : async Text {
    var size = Trie.size(userStore);
    return Nat.toText(size);
  };

  public query func getUsersList() : async [(Text, User)] {
    let usersArray : [(Text, User)] = Iter.toArray(Trie.iter(userStore));
    Debug.print(debug_show (usersArray));
    return usersArray;
  };



  public shared ({ caller }) func whoami() : async Principal {
    return caller;
  };

  public shared ({ caller }) func getInvoice() : async Types.Account {
    Debug.print(debug_show (toAccount({ caller; canister = Principal.fromActor(this) })));
    return toAccount({ caller; canister = Principal.fromActor(this) });

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
      }
    );
    return Nat.toText(balance);
  };

  public shared ({ caller }) func getCanisterBalance() : async Text {
    let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = Principal.fromActor(this);
        subaccount = null;
      },
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
          amount = 5000;
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
  public shared ({ caller }) func transferFromSubAccountToSubAccount(receiver : Text, amount : Nat) : async Types.Response<Transaction> {
   
    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      {
        owner = Principal.fromActor(this);
        subaccount = ?toSubaccount(caller);
      }
    );

    let fee = 10;
    let total = amount + fee;

    if (balance < total) {
      return {
        status = 403;
        status_text = "Forbidden";
        data = null;
        error_text = ?"Not enough funds available in the Account. You need 10 Sats for the transaction fee.";
      };
    };

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

      switch (transferResult) {
        case (#Err(transferError)) {
           return {
        status = 405;
        status_text = "Forbidden";
        data = null;
        error_text = ?"Couldn't transfer funds to account:\n";
      };

        //  return #err("Couldn't transfer funds to account:\n" # debug_show (transferError));
        };
        case (_) {};
      };
    } catch (error : Error) {
        return {
        status = 406;
        status_text = "Rejected";
        data = null;
        error_text = ?"Reject message: ";
      };
    //  return #err("Reject message: " # Error.message(error));
    };



let transaction : Transaction = {
      from = Principal.toText(caller);
      to= receiver;
      amount= Nat.toText(amount);
    };

    //  let data = await  saveTransaction(transaction);

    //  if (data.status == 200) {
    //       Debug.print("transaction:  is successful ");
    //    return {
    //     status = 200;
    //     status_text = "Transfer to " # receiver # " is successful";
    //     data = ?transaction;
    //     error_text = ?"";
    //   };
    //  }else{
    //   Debug.print("transaction:  is successful ");
    //    return {
    //     status = 405;
    //     status_text = "Forbidden";
    //     data = null;
    //     error_text = ?"Couldn't transfer funds to account:\n";
    //   };
    //  };

           return {
        status = 200;
        status_text = "Transfer to " # receiver # " is successful";
        data = ?transaction;
        error_text = ?"";
      };

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

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to trading account:\n" # debug_show (transferError));
        };
        case (_) {};
      };
    } catch (error : Error) {
      return #err("Reject message: " # Error.message(error));
    };

    return #ok("Transfer to trading account is " # "successful");
  };

  /**
   * Utilities
   */

  // Test two user identifiers for equality.
  private func eq(x : Nat32, y : Nat32) : Bool {
    return x == y;
  };

  /**
    * Generate a Trie key based on a merchant's principal ID
    */
  private func userKey(x : Text) : Trie.Key<Text> {
    return { hash = Text.hash(x); key = x };
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
  system func timer(setGlobalTimer : Nat64 -> ()) : async () {
    let next = Nat64.fromIntWrap(Time.now()) + 20_000_000_000; // 20 seconds
    setGlobalTimer(next);
    await notify();
  };

  // #region get_account_identifier
  /*
    * Get Caller Identifier
    * Allows a caller to the accountIdentifier for a given principal
    * for a specific token.
    */
  public query func get_account_identifier (args : Types.GetAccountIdentifierArgs) : async Types.GetAccountIdentifierResult {
    let principal = args.principal;
    let canisterId = Principal.fromActor(this);
   
        let subaccount = Utils.getDefaultAccount({principal; canisterId;});
        let hexEncoded = Hex.encode(
          Blob.toArray(subaccount)
        );
        let result : AccountIdentifier = #text(hexEncoded);
        #ok({accountIdentifier = result});
   
  };
// #endregion

// #region Utils
  public func accountIdentifierToBlob (accountIdentifier : Types.AccountIdentifier) : async Types.AccountIdentifierToBlobResult {
    Utils.accountIdentifierToBlob({
      accountIdentifier;
      canisterId = ?Principal.fromActor(this);
    });
  };
// #endregion

 /**
    * Notify the merchant if a new transaction is found.
    */
  private func notify() : async () {
    var start : Nat = _startBlock;
    if (latestTransactionIndex > 0) {
      start := latestTransactionIndex + 1;
    };

    var response = await CkBtcLedger.get_transactions({
      start = start;
      length = 1;
    });

    if (Array.size(response.transactions) > 0) {
      latestTransactionIndex := start;

      if (response.transactions[0].kind == "transfer") {
        let t = response.transactions[0];
        switch (t.transfer) {
          case (?transfer) {
            let to = transfer.to.owner;
            switch (Trie.get(userStore, userKey(Principal.toText(to)), Text.equal)) {
              case (?user) {
                if (user.email_notifications or user.phone_notifications) {
                  log("Sending notification to: " # debug_show (user.email_address));
                  await sendNotification(user, t);
                };
              };
              case null {
                // No action required if merchant not found
              };
            };
          };
          case null {
            // No action required if transfer is null
          };
        };
      };
    };
  };

  /**
    * Send a notification to a merchant about a received payment
    */
  private func sendNotification(user : User, transaction : CkBtcLedger.Transaction) : async () {
    // Managment canister
    let ic : HttpTypes.IC = actor ("aaaaa-aa");

    // Create request body
    var amount = "0";
    var from = "";
    switch (transaction.transfer) {
      case (?transfer) {
        amount := Nat.toText(transfer.amount);
        from := Principal.toText(transfer.from.owner);
      };
      case null {};
    };
    let idempotencyKey : Text = Text.concat(user.name, Nat64.toText(transaction.timestamp));
    let requestBodyJson : Text = "{ \"idempotencyKey\": \"" # idempotencyKey # "\", \"email\": \"" # user.email_address # "\", \"phone\": \"" # user.phone_number # "\", \"amount\": \"" # amount # "\", \"payer\": \"" # from # "\"}";
    let requestBodyAsBlob : Blob = Text.encodeUtf8(requestBodyJson);
    let requestBodyAsNat8 : [Nat8] = Blob.toArray(requestBodyAsBlob);

    // Setup request
    let httpRequest : HttpTypes.HttpRequestArgs = {
      // The notification service is hosted on Netlify and the URL is hardcoded
      // in this example. In a real application, the URL would be configurable.
     // url = "https://icpos-notifications.xyz/.netlify/functions/notify";
      url = "https://icpos-notifications.xyz/.netlify/functions/notify";
      max_response_bytes = ?Nat64.fromNat(1000);
      headers = [
        { name = "Content-Type"; value = "application/json" },
      ];
      body = ?requestBodyAsNat8;
      method = #post;
      transform = null;
    };

    // Cycle cost of sending a notification
    // 49.14M + 5200 * request_size + 10400 * max_response_bytes
    // 49.14M + (5200 * 1000) + (10400 * 1000) = 64.74M
    Cycles.add(70_000_000);

    // Send the request
    let httpResponse : HttpTypes.HttpResponsePayload = await ic.http_request(httpRequest);

    // Check the response
    if (httpResponse.status > 299) {
      let response_body : Blob = Blob.fromArray(httpResponse.body);
      let decoded_text : Text = switch (Text.decodeUtf8(response_body)) {
        case (null) { "No value returned" };
        case (?y) { y };
      };
      log("Error sending notification: " # decoded_text);
    } else {
      log("Notification sent");
    };
  };

  system func postupgrade() {
    // Make sure we start to montitor transactions from the block set on deployment
    latestTransactionIndex := _startBlock;
  };

};
