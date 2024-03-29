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
import { abs } = "mo:base/Int";
import { now } = "mo:base/Time";
import { setTimer; recurringTimer } = "mo:base/Timer";

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
  stable var notificationsStable : [(Nat, Notification)] = [];
  stable var invoicesStable : [(Nat, Invoice)] = [];
  stable var stablePayroll : [(Nat, [PayrollType])] = [];
  stable var transactionCounter : Nat = 0;
  stable var contactsCounter : Nat = 0;
  let oneMinute = 60;
  stable var notificationsCounter : Nat = 0;
  stable var invoiceCounter : Nat = 0;
  stable var payrollCounter : Nat = 0;
  var transactions : HashMap.HashMap<Nat, Transaction> = HashMap.fromIter(Iter.fromArray(transactionsStable), transactionsStable.size(), Nat.equal, Hash.hash);
  var contacts : HashMap.HashMap<Nat, Employee> = HashMap.fromIter(Iter.fromArray(contactsStable), contactsStable.size(), Nat.equal, Hash.hash);
  var notifications : HashMap.HashMap<Nat, Notification> = HashMap.fromIter(Iter.fromArray(notificationsStable), notificationsStable.size(), Nat.equal, Hash.hash);
  var payrolls : HashMap.HashMap<Nat, [PayrollType]> = HashMap.fromIter(Iter.fromArray(stablePayroll), stablePayroll.size(), Nat.equal, Hash.hash); 
  var MAX_TRANSACTIONS = 30_000;
  let invoices : HashMap.HashMap<Nat, Invoice> = HashMap.fromIter(Iter.fromArray(invoicesStable), invoicesStable.size(), Nat.equal, Hash.hash);

  public shared ({ caller }) func getAddress() : async Text {
    let acc : Types.Account = {
      owner = Principal.fromActor(this);
      subaccount = ?toSubaccount(caller);
    };
    let address = addressConverter_.toText(acc);
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
    *  Get user data by principal
    */
  public query (context) func getUserByPrincipal(principal : Principal) : async Types.Response<User> {
    switch (Trie.get(userStore, userKey(Principal.toText(principal)), Text.equal)) {
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
          error_text = ?("User with principal ID: " # Principal.toText(principal) # " not found.");
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

        switch (Trie.get(userStore, userKey(receiver), Text.equal)) {
          case (?user) {
            let notification = await send_notifications(user.name, user.email_address, user.phone_number, Nat.toText(amount), Principal.toText(caller));
            Debug.print("notification sent to : " # debug_show (user.email_address));
          };
          case null {
            Debug.print("User to send notification to not found");
          };
        };

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

  //transfer from your account to other
  //works
  public shared ({ caller }) func sendToOwner(amount : Nat,receiver :Text) : async Result.Result<Text, Text> {

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      {
        owner = caller;
        subaccount = null;
      }
    );

    Debug.print("balance of main account is  " # debug_show (balance));

    if (balance < 100) {
      return #err("Not enough funds available in Personal  Account. Make sure you send at least 100 ckSats.");
    };

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = amount;
          from_subaccount = null;
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromText(receiver);
            subaccount = null;
          };
        }
      );

       Debug.print("transffer result  " # debug_show (transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to Principal account:\n" # debug_show (transferError));
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
 private func ring() : async () {
    Debug.print("Motoko Timer Ring!");
  };

  /**
    * Check for new transactions and notify the merchant if a new transaction is found.
    * This function is called by the global timer.
    */
  system func timer(setGlobalTimer : Nat64 -> ()) : async () {
     let now = Time.now();
    let thirtyMinutes = 1_000_000_000 * 60 * 1;
   // let next = Nat64.fromIntWrap(Time.now()) + 20_000_000_000; // 20 seconds
   let next = Nat64.fromIntWrap(Time.now()) + 1_000_000_000 * 60 * 1; // One minute
    setGlobalTimer(next);
  //  Debug.print("Timer is up now");  
  // ignore recurringTimer(#seconds thirtyMinutes, ring);
    // await notify();
  };

 

  // public shared func schedulePayment() : async () {
  //   let now = Time.now();
  //   let thirtyMinutes = 1_000_000_000 * 60 * 1;
  //   let next = Nat64.fromIntWrap(Time.now()) + 1_000_000_000 * 60 * 1; // One minute
    
  // };


  ignore setTimer(#seconds (oneMinute),
    func () : async () {
      ignore recurringTimer(#seconds oneMinute, ring);
      await ring();
  }
  );

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

  // #region Upgrade Hooks
  system func preupgrade() {
    transactionsStable := Iter.toArray(transactions.entries());
    contactsStable := Iter.toArray(contacts.entries());
    notificationsStable := Iter.toArray(notifications.entries());
    invoicesStable := Iter.toArray(invoices.entries());
  };

  system func postupgrade() {
    // Make sure we start to montitor transactions from the block set on deployment
    latestTransactionIndex := _startBlock;
    transactions := HashMap.fromIter(Iter.fromArray(transactionsStable), transactionsStable.size(), Nat.equal, Hash.hash);
    // transactions := HashMap.fromIter(Iter.fromArray(transactionsStable), contactsStable.size(), Nat.equal, Hash.hash);
    transactionsStable := [];
    contacts := HashMap.fromIter(Iter.fromArray(contactsStable), contactsStable.size(), Nat.equal, Hash.hash);
    contactsStable := [];
    notifications := HashMap.fromIter(Iter.fromArray(notificationsStable), notificationsStable.size(), Nat.equal, Hash.hash);
    notificationsStable := [];
    // invoices := HashMap.fromIter(Iter.fromArray(invoicesStable), invoicesStable.size(), Nat.equal, Hash.hash);
    // invoicesStable := [];

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

  //get employee data based on principal
  public shared ({ caller }) func getEmployeeByPrincipal(principal : Principal) : async Types.Response<Employee> {
    let allEntries = Iter.toArray(contacts.entries());

    //get employee by principal and then if creator is caller return employee
    for ((_, contact) in allEntries.vals()) {
      if (Principal.fromText(contact.wallet) == principal) {
        if (contact.creator == caller) {
          return {
            status = 200;
            status_text = "OK";
            data = ?contact;
            error_text = null;
          };
        };
      };
    };

    return {
      status = 404;
      status_text = "Not Found";
      data = null;
      error_text = null;
    };
  };

  //transfer funds from owner  caller to oter owner caller

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

        let transaction = await transferFromSubAccountToSubAccount(receiver.destination, receiver.amount);
        Debug.print("transaction: " # debug_show (transaction));
      };

    };

    {
      status = 200;
      status_text = "Transfer Successful";
      data = null;
      error_text = null;
    };

  };

  //function to transform the response
  public query func transform(raw : Types.TransformArgs) : async Types.CanisterHttpResponsePayload {
    let transformed : Types.CanisterHttpResponsePayload = {
      status = raw.response.status;
      body = raw.response.body;
      headers = [
        {
          name = "Content-Security-Policy";
          value = "default-src 'self'";
        },
        {
          name = "Referrer-Policy";
          value = "strict-origin";
        },
        {
          name = "Permissions-Policy";
          value = "geolocation=(self)";
        },
        {
          name = "Strict-Transport-Security";
          value = "max-age=63072000";
        },
        {
          name = "X-Frame-Options";
          value = "DENY";
        },
        {
          name = "X-Content-Type-Options";
          value = "nosniff";
        },
      ];
    };
    transformed;
  };

  //PULIC METHOD
  //This method sends a POST request to a URL with a free API we can test.
  public func send_notifications(name : Text, email : Text, phone : Text, amount : Text, sender : Text) : async () {
    let ic : Types.IC = actor ("aaaaa-aa");
    let url = "https://icpos-notifications.xyz/.netlify/functions/notify";
    let idempotency_key : Text = generateUUID();
    let request_headers = [
      { name = "Content-Type"; value = "application/json" },
    ];
    let idempotencyKey : Text = Text.concat(name, Nat.toText(10));
    let requestBodyJson : Text = "{ \"idempotencyKey\": \"" # idempotencyKey # "\", \"email\": \"" # email # "\", \"phone\": \"" # phone # "\", \"amount\": \"" # amount # "\", \"payer\": \"" # sender # "\"}";
    let requestBodyAsBlob : Blob = Text.encodeUtf8(requestBodyJson);
    let requestBodyAsNat8 : [Nat8] = Blob.toArray(requestBodyAsBlob);
    // 2.2.1 Transform context
    let transform_context : Types.TransformContext = {
      function = transform;
      context = Blob.fromArray([]);
    };

    // 2.3 The HTTP request
    let http_request : Types.HttpRequestArgs = {
      url = url;
      max_response_bytes = ?Nat64.fromNat(1000); //optional for request
      headers = request_headers;
      //note: type of `body` is ?[Nat8] so we pass it here as "?request_body_as_nat8" instead of "request_body_as_nat8"
      body = ?requestBodyAsNat8;
      method = #post;
      transform = ?transform_context;
      //transform = null;
    };
    Cycles.add(70_000_000);
    let http_response : Types.HttpResponsePayload = await ic.http_request(http_request);

    Debug.print("http_response: " # debug_show (http_response));

    if (http_response.status > 299) {
      let response_body : Blob = Blob.fromArray(http_response.body);
      let decoded_text : Text = switch (Text.decodeUtf8(response_body)) {
        case (null) { "No value returned" };
        case (?y) { y };
      };
      log("Error sending notification: " # decoded_text);
    } else {
      log("Notification sent");
    };
  };

  //PRIVATE HELPER FUNCTION
  //Helper method that generates a Universally Unique Identifier
  //this method is used for the Idempotency Key used in the request headers of the POST request.
  //For the purposes of this exercise, it returns a constant, but in practice it should return unique identifiers
  func generateUUID() : Text {
    "UUID-1234567435345";
  };

  //check if email exists
  public query func emailExists(email : Text) : async Bool {
    let usersArray : [(Text, User)] = Iter.toArray(Trie.iter(userStore));
  //  let allEntries = Iter.toArray(userStore.entries());
    for ((_, user) in usersArray.vals()) {
      if (user.email_address == email) {
        return true;
      };
    };
    return false;
  };

};
