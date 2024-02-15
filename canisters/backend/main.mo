import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import CkBtcLedger "canister:ckbtc_ledger";
//import CkBtcIndex "canister:icrc1_index";
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
import Random "mo:base/Random";
import Hex "./Hex";
import Timer "mo:base/Timer";

shared (actorContext) actor class Backend(_startBlock : Nat) = this {

  // #region Types
  type Account = Types.Account;
  type AccountIdentifier = Types.AccountIdentifier;
  type Transaction = Types.Transaction;
  type User = Types.User;
  type Notification = Types.Notification;
  type PayrollType = Types.PayrollType;
  type Employee = Types.Employee;
  type Invoice = Types.Invoice;
  public type TransactionId = Nat32;
  let r = Random.Finite("username");
  
  // #endregion

  let addressConverter_ = Utils.addressConverter;
  // The next available transaction identifier.
  private stable var latestTransactionIndex : Nat = 0;
  private stable var courierApiKey : Text = "";
  private var logData = Buffer.Buffer<Text>(0);
  // The user data store. The key is the user's principal ID.
  private stable var userStore : Trie.Trie<Text, User> = Trie.empty();
  stable var transactionsStable : [(Nat, Transaction)] = [];
  stable var contactsStable : [(Nat, Employee)] = [];
  stable var notificationsSable : [(Nat, Notification)] = [];
  stable var invo : [(Nat, Invoice)] = [];
  stable var transactionCounter : Nat = 0;
  stable var contactsCounter : Nat = 0;
  stable var notificationsCounter : Nat = 0;
  stable var invoiceCounter : Nat = 0;
  var transactions : HashMap.HashMap<Nat, Transaction> = HashMap.fromIter(Iter.fromArray(transactionsStable), transactionsStable.size(), Nat.equal, Hash.hash);
  var contacts : HashMap.HashMap<Nat, Employee> = HashMap.fromIter(Iter.fromArray(contactsStable), contactsStable.size(), Nat.equal, Hash.hash);
  var notifications : HashMap.HashMap<Nat, Notification> = HashMap.fromIter(Iter.fromArray(notificationsSable), notificationsSable.size(), Nat.equal, Hash.hash);
  var MAX_TRANSACTIONS = 30_000;
  let invoices : HashMap.HashMap<Nat, Invoice> = HashMap.fromIter(Iter.fromArray(invo), invo.size(), Nat.equal, Hash.hash);

  public shared ({ caller }) func getAddress() : async Text {
    let acc : Types.Account = {
      owner = Principal.fromActor(this);
      subaccount = ?toSubaccount(caller);
    };
    let address = addressConverter_.toText(acc);
    return address;
  };

  func checkAndWaterPlants() : async () {
    Debug.print("chceking flowers");
  };
  let daily = Timer.recurringTimer(#seconds(1 * 60 * 1), checkAndWaterPlants);

  public func testRandom() : async ?Bool {
    return r.coin();
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
  public query (context) func isRegistered() : async Bool {
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
    return usersArray;
  };

  public shared ({ caller }) func whoami() : async Principal {
    return caller;
  };

  public shared ({ caller }) func getInvoice() : async Types.Account {
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

    //Debug.print("balance:  is  " # debug_show (balance));

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

      //Debug.print("transferresult:  is  " # debug_show (transferResult));

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

    let transaction = await save_transaction({
      amount = amount;
      creator = caller;
      destination = Principal.fromText(receiver);
      successful = true;
    });

    switch (transaction) {
      case (#ok(transaction)) {
        //  Debug.print("Created new transaction: " # debug_show(transaction)) ;
        let notification = save_notification({
          amount = amount;
          sender = Principal.toText(caller);
          receiver = receiver;
          isRead = false;
        });

        return {
          status = 200;
          status_text = "Transfer to " # receiver # " is successful";
          data = null;
          error_text = ?"";
        };
      };

      case (#err(message)) {
        //  Debug.print("Transaction failed: " # debug_show(transaction)) ;

        return {
          status = 403;
          status_text = "Transfer to " # receiver # " is failed";
          data = null;
          error_text = ?"";
        };

        // Debug.print("Failed to create user with the error: " # message) };
      };
      //check if transaction is ok or error
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

  //transfer to multiple users
  // public shared ({ caller }) func runPayroll(amount : Nat, payroll: [Transaction]) :async Types.Response<[Transaction]>{

  // };

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
  public query func get_account_identifier(args : Types.GetAccountIdentifierArgs) : async Types.GetAccountIdentifierResult {
    let principal = args.principal;
    let canisterId = Principal.fromActor(this);

    let subaccount = Utils.getDefaultAccount({ principal; canisterId });
    let hexEncoded = Hex.encode(
      Blob.toArray(subaccount)
    );
    let result : AccountIdentifier = #text(hexEncoded);
    #ok({ accountIdentifier = result });

  };
  // #endregion

  // #region Utils
  public func accountIdentifierToBlob(accountIdentifier : Types.AccountIdentifier) : async Types.AccountIdentifierToBlobResult {
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
      length = 100;
    });

    let transactions = response.transactions;
    let size = Array.size(transactions);
    // Debug.print("transactions are " # debug_show(transactions));

    if (Array.size(response.transactions) > 0) {

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
      //https://bitpochi-notifications.netlify.app/
      url = "https://bitpochi-notifications.netlify/functions/notify";
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

  private func sendEmailorText(user : User, transaction : Transaction) : async () {
    // Managment canister
    let ic : HttpTypes.IC = actor ("aaaaa-aa");

    // Create request body
    var amount = "0";
    var from = "";
    amount := Nat.toText(transaction.amount);
    from := Principal.toText(transaction.creator);
    // switch (transaction.transfer) {
    //   case (?transfer) {
    //     amount := Nat.toText(transfer.amount);
    //     from := Principal.toText(transfer.from.owner);
    //   };
    //   case null {};
    // };
    let idempotencyKey : Text = Text.concat(user.name, Nat.toText(transaction.id));
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

   // #region Upgrade Hooks
  system func preupgrade() {
    transactionsStable := Iter.toArray(transactions.entries());
    contactsStable := Iter.toArray(contacts.entries());
    notificationsSable := Iter.toArray(notifications.entries());
  };

 
  system func postupgrade() {
     // Make sure we start to montitor transactions from the block set on deployment
      latestTransactionIndex := _startBlock;
      transactions := HashMap.fromIter(Iter.fromArray(transactionsStable), transactionsStable.size(), Nat.equal, Hash.hash);
     // transactions := HashMap.fromIter(Iter.fromArray(transactionsStable), contactsStable.size(), Nat.equal, Hash.hash);
      transactionsStable := [];
      contacts := HashMap.fromIter(Iter.fromArray(contactsStable), contactsStable.size(), Nat.equal, Hash.hash);
      contactsStable := [];
      notifications := HashMap.fromIter(Iter.fromArray(notificationsSable), notificationsSable.size(), Nat.equal, Hash.hash);
      notificationsSable := [];
      
  };

 
  // #endregion

  // #region Create Invoice
  public shared ({ caller }) func save_transaction(args : Types.CreateTransactionArgs) : async Types.CreateTransactionResult {
    let id : Nat = transactionCounter;
    // increment counter
    transactionCounter += 1;

    if (id > MAX_TRANSACTIONS) {
      return #err({
        message = ?"The maximum number of Transactions has been reached.";
        kind = #MaxTransactionsReached;
      });
    };

    let transaction : Transaction = {
      id;
      created_at = Time.now();
      creator = args.creator;
      destination = args.destination;
      amount = args.amount;
      successful = args.successful;
    };

    transactions.put(id, transaction);

    return #ok({ transaction });
  };

  // #region Get Transaction
  public shared query ({ caller }) func get_transaction(args : Types.GetTransactionArgs) : async Types.GetTransactionResult {
    let transaction = transactions.get(args.id);
    switch (transaction) {
      case (null) {
        return #err({
          message = ?"Transaction not found";
          kind = #NotFound;
        });
      };
      case (?i) {
        if (i.creator == caller) {
          return #ok({ transaction = i });
        };

        #ok({ transaction = i });
      };
    };
  };
  // #endregion

  // #region Get All Transactions for a given caller
  public shared query ({ caller }) func get_transactions() : async [Transaction] {
    let allEntries = Iter.toArray(transactions.entries());
    let my_transactions = Buffer.Buffer<Transaction>(50);
    // let outputArray : [Transaction] = [];
    for ((_, transaction) in allEntries.vals()) {
      if (transaction.creator == caller) {
        my_transactions.add(transaction);
        Debug.print("Sent Transaction: " # debug_show (transaction));
      };

      if (transaction.destination == caller) {
        my_transactions.add(transaction);
        Debug.print("Received Transaction: " # debug_show (transaction));
      };

    };

    return Buffer.toArray<Transaction>(my_transactions);
  };

  // #endregion

  // region get no of transactions
  public query func getTransactionLength() : async Text {
    var size = transactions.size();
    return Nat.toText(size);
  };

  //get no of my transactions
  public shared ({ caller }) func getMyTransactionLength() : async Text {
    let allEntries = Iter.toArray(transactions.entries());
    var size = 0;
    for ((_, transaction) in allEntries.vals()) {
      if (transaction.creator == caller) {
        size += 1;
      };
    };
    return Nat.toText(size);
  };

  // #region Create User
  public shared ({ caller }) func create_employee(args : Types.CreateEmployeeArgs) : async Types.Response<Employee> {
    let id : Nat = contactsCounter;
    // increment counter
    contactsCounter += 1;

    //get user via args.wallet
    switch (Trie.get(userStore, userKey(args.wallet), Text.equal)) {
      case (?user) {
        let employee : Employee = {
          id;
          creator = caller;
          name = user.name;
          email_address = user.email_address;
          phone_number = user.phone_number;
          created_at = Time.now();
          modified_at = Time.now();
          wallet = args.wallet;
        };

        contacts.put(id, employee);

        {
          status = 200;
          status_text = "OK";
          data = ?employee;
          error_text = null;
        };

      };
      case null {
        {
          status = 404;
          status_text = "Not Found";
          data = null;
          error_text = ?"User with principal ID:  not found.";
        };
      };
    };
  };

  //get no of employees added by caller
  public shared ({ caller }) func getMyContactsLength() : async Text {
    let allEntries = Iter.toArray(contacts.entries());
    var size = 0;
    for ((_, contact) in allEntries.vals()) {
      if (contact.creator == caller) {
        size += 1;
      };
    };
    return Nat.toText(size);
  };

  //get employees added by caller
  public shared ({ caller }) func getMyContacts() : async [Employee] {
    let allEntries = Iter.toArray(contacts.entries());
    let my_contacts = Buffer.Buffer<Employee>(50);
    for ((_, contact) in allEntries.vals()) {
      if (contact.creator == caller) {
        my_contacts.add(contact);
      };
    };

    return Buffer.toArray<Employee>(my_contacts);
  };

  public shared ({ caller }) func save_notification(args : Types.CreateNotificationArgs) : async Types.CreateNotificationResult {
    let id : Nat = notificationsCounter;
    // increment counter
    notificationsCounter += 1;

    let notification : Notification = {
      id;
      sender = args.sender;
      receiver = args.receiver;
      amount = args.amount;
      isRead = args.isRead;
    };

    notifications.put(id, notification);

    return #ok({ notification });
  };

  //get notifications added by caller
  public shared ({ caller }) func getNotifications() : async [Notification] {
    let allEntries = Iter.toArray(notifications.entries());
    let my_notifications = Buffer.Buffer<Notification>(50);
    // let outputArray : [Transaction] = [];
    for ((_, notification) in allEntries.vals()) {
      if (notification.sender == Principal.toText(caller)) {
        my_notifications.add(notification);
      };
    };

    return Buffer.toArray<Notification>(my_notifications);
  };

  //get notifications added by caller and not read
  public shared ({ caller }) func getUnreadNotifications() : async [Notification] {
    let allEntries = Iter.toArray(notifications.entries());
    let my_notifications = Buffer.Buffer<Notification>(50);
    // let outputArray : [Transaction] = [];
    for ((_, notification) in allEntries.vals()) {
      if (notification.receiver == Principal.toText(caller)) {

        if (notification.isRead == false) {
          my_notifications.add(notification);
        };

      };
    };

    return Buffer.toArray<Notification>(my_notifications);
  };

  //get no of notifications added by caller and not read
  public shared ({ caller }) func getUnreadNotificationsLength() : async Text {
    let allEntries = Iter.toArray(notifications.entries());
    var size = 0;
    for ((_, notification) in allEntries.vals()) {
      if (notification.receiver == Principal.toText(caller)) {
        if (notification.isRead == false) {
          size += 1;
        };

      };
    };
    return Nat.toText(size);
  };

  public shared ({ caller }) func runpayroll(receivers : [PayrollType]) : async Types.Response<[PayrollType]> {
    var total : Nat = 0;
    let fee : Nat = 10;
    let payroll = Buffer.Buffer<PayrollType>(50);
    for (receiver in receivers.vals()) {
      total += receiver.amount + fee;
    };
    Debug.print("total: " # debug_show (total));

    //check balance
    let balance = await CkBtcLedger.icrc1_balance_of(
      {
        owner = Principal.fromActor(this);
        subaccount = ?toSubaccount(caller);
      }
    );
    Debug.print("balance: " # debug_show (balance));

    if (balance < total) {
      let data : [PayrollType] = Buffer.toArray<PayrollType>(payroll);
      return {
        status = 403;
        status_text = "Insufficient Balance";
        data = null;
        error_text = null;
      };
    } else {

      for (receiver in receivers.vals()) {
        Debug.print("receiver: " # debug_show (receiver));

        try {
          let transferResult = await CkBtcLedger.icrc1_transfer(
            {
              amount = receiver.amount;
              from_subaccount = ?toSubaccount(caller);
              created_at_time = null;
              fee = ?10;
              memo = null;
              to = {
                owner = Principal.fromActor(this);
                subaccount = ?toSubaccount(Principal.fromText(receiver.destination));
              };
            }
          );
          switch (transferResult) {
            case (#Ok(index)) {
              //  payroll.add(receiver);
              // return {
              //   status = 200;
              //   status_text = "Accepted";
              //   data = ?Buffer.toArray<PayrollType>(payroll);
              //   error_text = ?"Funds Transferred:\n";
              // };
            };

            case (#Err(transferError)) {
              // return {
              //   status = 405;
              //   status_text = "Forbidden";
              //   data = ?Buffer.toArray<PayrollType>(payroll);
              //   error_text = ?"Couldn't transfer funds to account:\n";
              // };

            };
            case (_) {
              //    return {
              //   status = 500;
              //   status_text = "Internal Server Error";
              //   data = null;
              //   error_text = ?"Unexpected error occurred";
              // };
            };
          };
        } catch (error : Error) {
          // return {
          //   status = 406;
          //   status_text = "Rejected";
          //   data = ?Buffer.toArray<PayrollType>(payroll);
          //   error_text = ?"Payroll failed";
          // };
        };
      };

    };

    {
      status = 200;
      status_text = "Transfer Successful";
      data = null;
      error_text = null;
    };

  };

};
