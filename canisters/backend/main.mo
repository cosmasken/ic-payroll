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
import HttpTypes "./http-types";
import UserTypes "./user-types";
import PaymentTypes "./payment-types";
import StorageTypes "./storage-types";
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
import Hash "mo:base/Hash";
import Random "mo:base/Random";
import Timer "mo:base/Timer";
import { abs } = "mo:base/Int";
import { now } = "mo:base/Time";
import { setTimer; recurringTimer; cancelTimer } = "mo:base/Timer";
import Taxcalculator "taxcalculator";
import BalanceUtils "balance-utils";
import UserUtils "user-utils";

shared (actorContext) actor class Backend() = this {

  // #region Types
  type Account = UserTypes.Account;
  type AccountIdentifier = UserTypes.AccountIdentifier;
  type User = UserTypes.User;

  type Emp = StorageTypes.Employee;
  type Leave = StorageTypes.Leave;
  type Department = StorageTypes.Department;
  type Organization = StorageTypes.Organization;
  type Designation = StorageTypes.Designation;
  type Notification = StorageTypes.Notification;

  type Payslip = PaymentTypes.Payslip;
  type PayrollType = PaymentTypes.PayrollType;
  type Transaction = PaymentTypes.Transaction;
  type Invoice = PaymentTypes.Invoice;
  type PayslipData = PaymentTypes.PayslipData;

  public type TransactionId = Nat32;

  // #endregion

  let addressConverter_ = Utils.addressConverter;

  // The next available transaction identifier.
  private stable var latestTransactionIndex : Nat = 0;
  private stable var courierApiKey : Text = "";
  private var logData = Buffer.Buffer<Text>(0);
  // The user data store. The key is the user's principal ID.
  private stable var userStore : Trie.Trie<Text, User> = Trie.empty();
  stable var transactionsStable : [(Nat, Transaction)] = [];
  stable var metamaskUsers : [(Text, Principal)] = [];
  stable var departmentsStable : [(Nat, Department)] = [];
  stable var organizationsStable : [(Nat, Organization)] = [];
  stable var designationsStable : [(Nat, Designation)] = [];
  stable var stableEmployees : [(Nat, Emp)] = [];
  stable var notificationsStable : [(Nat, Notification)] = [];
  stable var invoicesStable : [(Nat, Invoice)] = [];
  stable var stablePayroll : [(Nat, [PayrollType])] = [];
  stable var transactionCounter : Nat = 0;
  stable var contactsCounter : Nat = 0;
  stable var noOfEmployees : Nat = 0;
  stable var organizationsCounter : Nat = 0;
  stable var departmentsCounter : Nat = 0;
  stable var designationsCounter : Nat = 0;
  let oneMinute = 60;
  stable var notificationsCounter : Nat = 0;
  stable var invoiceCounter : Nat = 0;
  stable var payrollCounter : Nat = 0;
  stable var noofmetamaskusers : Nat = 0;
  var transactions : HashMap.HashMap<Nat, Transaction> = HashMap.fromIter(Iter.fromArray(transactionsStable), transactionsStable.size(), Nat.equal, Hash.hash);
  var employees : HashMap.HashMap<Nat, Emp> = HashMap.fromIter(Iter.fromArray(stableEmployees), stableEmployees.size(), Nat.equal, Hash.hash);
  var notifications : HashMap.HashMap<Nat, Notification> = HashMap.fromIter(Iter.fromArray(notificationsStable), notificationsStable.size(), Nat.equal, Hash.hash);
  var payrolls : HashMap.HashMap<Nat, [PayrollType]> = HashMap.fromIter(Iter.fromArray(stablePayroll), stablePayroll.size(), Nat.equal, Hash.hash);
  var organizations : HashMap.HashMap<Nat, Organization> = HashMap.fromIter(Iter.fromArray(organizationsStable), organizationsStable.size(), Nat.equal, Hash.hash);
  var departments : HashMap.HashMap<Nat, Department> = HashMap.fromIter(Iter.fromArray(departmentsStable), departmentsStable.size(), Nat.equal, Hash.hash);
  var designations : HashMap.HashMap<Nat, Designation> = HashMap.fromIter(Iter.fromArray(designationsStable), designationsStable.size(), Nat.equal, Hash.hash);
  var selfcustodyusers : HashMap.HashMap<Text, Principal> = HashMap.fromIter(Iter.fromArray(metamaskUsers), metamaskUsers.size(), Text.equal, Text.hash);

  var MAX_TRANSACTIONS = 30_000;
  let invoices : HashMap.HashMap<Nat, Invoice> = HashMap.fromIter(Iter.fromArray(invoicesStable), invoicesStable.size(), Nat.equal, Hash.hash);

  public func mapPrincipal(wallet : Text) : async Principal {

    return Principal.fromText(wallet);
  };

  public shared ({ caller }) func generatePayslip(income : Nat) : async Types.Response<Payslip> {
    let payslipInfo = await Taxcalculator.calculateTax(income);
    return payslipInfo;
  };

  public shared ({ caller }) func addToMetamaskUsers(address : Text, identity : Principal) : async Result.Result<Text, Text> {
    //check if address exists
    let addressExists = selfcustodyusers.get(address);

    Debug.print("address exists???? " # debug_show (addressExists));
    if (addressExists != null) {
      return #err("Address already exists");
    };

    selfcustodyusers.put(address, identity);

    return #ok("identity" # "address");

  };

  public shared ({ caller }) func getMetamaskUsers() : async [(Text, Principal)] {
    let allEntries = Iter.toArray(selfcustodyusers.entries());
    var users : [(Text, Principal)] = [];
    let buffer = Buffer.Buffer<(Text, Principal)>(10000);
    for ((key, value) in allEntries.vals()) {
      buffer.add(key, value);
    };
    return Buffer.toArray<(Text, Principal)>(buffer);
  };

    public shared ({ caller }) func getPrincipalByAddress(walletAddress : Text) : async Types.Response<Principal> {
    let allEntries = Iter.toArray(selfcustodyusers.entries());

    //get employee by principal and then if creator is caller return employee
    for ((key, value) in allEntries.vals()) {
      if (walletAddress == key) {
          return {
            status = 200;
            status_text = "OK";
            data = ?value;
            error_text = null;
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

  public shared ({ caller }) func getUserPayslip(identity : Text) : async Types.Response<PayslipData> {
    let employee = await getEmpByPrincipal(Principal.fromText(identity));
    Debug.print("employee is " # debug_show (employee));

    let payslipData : PayslipData = {
      name = "N/A";
      organization = "N/A";
      department = "N/A";
      designation = "N/A";
      gross_salary = 0;
      taxable_income = 0;
      net_salary = 0;
      housing = 0;
      nhif_deductions = 0;
      nssf_deductions = 0;
      personal_relief = 0;
      paye = 0;
      other_deductions = 0;
      total_tax = 0;
    };
    {
      status = 200;
      status_text = "Yes";
      data = ?payslipData;
      error_text = null;
    };

  };

  /**
   * High-Level API
   */

  var count = 0;
  let n = 120;
  let nMonth = 2629800;
  let oneMin : Int = 60_000_000_000;
  let twoMins : Int = oneMin * 2;
  let fourMins : Int = oneMin * 4;
  let fiveMins : Int = oneMin * 5;
  let oneHour : Int = oneMin * 60;
  let oneDay : Int = 86_400_000_000_000;
  let oneMonth : Int = 2_629_800_000_000_000;
  let oneYear : Int = oneMonth * 12;

  public shared ({ caller }) func checkPayroll() : async () {

    let allEntries = Iter.toArray(payrolls.entries());
    var size = 0;
    Debug.print(debug_show (allEntries));

  };

  public func setRecurringTimer(N : Nat) : async Nat {
    let timerId = recurringTimer(
      #seconds N,
      func() : async () {
        Debug.print("Here are the items that are pending");
        await checkPayroll();
      },
    );
    return timerId;
  };

  public func cancelRecurringTimer(id : Nat) : async () {
    // switch (timerId) {
    //   case (?id) { ignore cancelTimer(id); };
    //   case null {};
    // };
    ignore cancelTimer(id);
  };

  public shared ({ caller }) func save_payroll(args : PaymentTypes.SchedulePaymentsArgs) : async PaymentTypes.SchedulePaymentsResult {
    let id : Nat = payrollCounter;
    let receivers = args.receivers;
    // increment counter
    payrollCounter += 1;

    if (id > MAX_TRANSACTIONS) {
      return #err({
        message = ?"The maximum number of Transactions has been reached.";
        kind = #MaxTransactionsReached;
      });
    };

    payrolls.put(id, args.receivers);

    return #ok({ receivers });
  };

  /**
    *  Get the merchant's information
    */
  public  shared ({ caller }) func getUser() : async Types.Response<User> {
return await  UserUtils.getUser(userStore,caller);
  };

  /**
    *  Get user data by principal
    */
  public shared ({ caller }) func getUserByPrincipal(principal : Principal) : async Types.Response<User> {
    // switch (Trie.get(userStore, userKey(Principal.toText(principal)), Text.equal)) {
    //   case (?user) {
    //     {
    //       status = 200;
    //       status_text = "OK";
    //       data = ?user;
    //       error_text = null;
    //     };
    //   };
    //   case null {
    //     {
    //       status = 404;
    //       status_text = "Not Found";
    //       data = null;
    //       error_text = ?("User with principal ID: " # Principal.toText(principal) # " not found.");
    //     };
    //   };
    // };
    return await UserUtils.getUserByPrincipal(userStore,principal);
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
    * Update the user's information
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

  public shared query ({ caller }) func whoami() : async Principal {
    return caller;
  };

  public shared ({ caller }) func getFundingBalance() : async Text {
    return await BalanceUtils.getFundingBalance(caller);
  };

  public shared ({ caller }) func getTradingBalance() : async Text {
    return await BalanceUtils.getTradingBalance(Principal.fromActor(this), caller);
  };

  public shared ({ caller }) func getCanisterBalance() : async Text {
    return await BalanceUtils.getCanisterBalance(Principal.fromActor(this));
  };

  public shared ({ caller }) func getFundingAddress() : async Text {
    let acc : Account = {
      owner = caller;
      subaccount = null;
    };
    let address = addressConverter_.toText(acc);
    return address;
  };

  public shared ({ caller }) func getTradingAddress() : async Text {
    let acc : Account = {
      owner = Principal.fromActor(this);
      subaccount = ?toSubaccount(caller);
    };
    let address = addressConverter_.toText(acc);
    return address;
  };

  public shared ({ caller }) func getCanisterAddress() : async Text {
    let acc : Account = {
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
    let balance = await CkBtcLedger.icrc1_balance_of({
      owner = Principal.fromActor(this);
      subaccount = null;
    });

    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

    //Debug.print("balance:  is  " # debug_show (balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer({
        amount = 5000;
        from_subaccount = null;
        created_at_time = null;
        fee = ?10;
        memo = null;
        to = {
          owner = Principal.fromActor(this);
          subaccount = ?toSubaccount(caller);
        };
      });

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
    let balance = await CkBtcLedger.icrc1_balance_of({
      owner = Principal.fromActor(this);
      subaccount = ?toSubaccount(caller);
    });

    let fee = 10;
    let total = amount + fee;

    // if (balance < total) {
    //   return {
    //     status = 403;
    //     status_text = "Forbidden";
    //     data = null;
    //     error_text = ?"Not enough funds available in the Account. You need 10 Sats for the transaction fee.";
    //   };
    // };

    Debug.print("balance  " # debug_show (balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer({
        amount = amount;
        from_subaccount = ?toSubaccount(caller);
        created_at_time = null;
        fee = ?10;
        memo = null;
        to = {
          owner = Principal.fromActor(this);
          subaccount = ?toSubaccount(Principal.fromText(receiver));
        };
      });

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
            let notification = await send_notifications(user.first_name, user.email_address, user.phone_number, Nat.toText(amount), Principal.toText(caller));
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
  public shared ({ caller }) func sendToOwner(amount : Nat, receiver : Text) : async Types.Response<Transaction> {

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of({
      owner = caller;
      subaccount = null;
    });

    if (balance < 100) {
      return {
        status = 406;
        status_text = "Rejected";
        data = null;
        error_text = ?"Insuffcient balance ";
      };
    };

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer({
        amount = amount;
        from_subaccount = null;
        created_at_time = null;
        fee = ?10;
        memo = null;
        to = {
          owner = Principal.fromText(receiver);
          subaccount = null;
        };
      });

      Debug.print("transffer result  " # debug_show (transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
          return {
            status = 405;
            status_text = "Forbidden";
            data = null;
            error_text = ?"Couldn't transfer funds to account:\n";
          };

        };
        case (_) {};
      };
    } catch (error : Error) {
      return {
        status = 406;
        status_text = "Rejected";
        data = null;
        error_text = ?"Couldn't transfer funds to Principal account";
      };
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
            let notification = await send_notifications(user.first_name, user.email_address, user.phone_number, Nat.toText(amount), Principal.toText(caller));
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

      };
      //check if transaction is ok or error
    };
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
  // system func timer(setGlobalTimer : Nat64 -> ()) : async () {
  //    let now = Time.now();
  //   let thirtyMinutes = 1_000_000_000 * 60 * 1;
  //  // let next = Nat64.fromIntWrap(Time.now()) + 20_000_000_000; // 20 seconds
  //  let next = Nat64.fromIntWrap(Time.now()) + 1_000_000_000 * 60 * 1; // One minute
  //   setGlobalTimer(next);
  // //  Debug.print("Timer is up now");
  // // ignore recurringTimer(#seconds thirtyMinutes, ring);
  //   // await notify();
  // };

  // public shared func schedulePayment() : async () {
  //   let now = Time.now();
  //   let thirtyMinutes = 1_000_000_000 * 60 * 1;
  //   let next = Nat64.fromIntWrap(Time.now()) + 1_000_000_000 * 60 * 1; // One minute

  // };

  // ignore setTimer(#seconds (oneMinute),
  //   func () : async () {
  //     ignore recurringTimer(#seconds oneMinute, ring);
  //     await ring();
  // }
  // );

  // #region Utils

  // #endregion

  // #region Upgrade Hooks
  system func preupgrade() {
    transactionsStable := Iter.toArray(transactions.entries());
    stableEmployees := Iter.toArray(employees.entries());
    notificationsStable := Iter.toArray(notifications.entries());
    invoicesStable := Iter.toArray(invoices.entries());
    organizationsStable := Iter.toArray(organizations.entries());
    departmentsStable := Iter.toArray(departments.entries());
    designationsStable := Iter.toArray(designations.entries());
  };

  system func postupgrade() {
    // Make sure we start to montitor transactions from the block set on deployment
    //latestTransactionIndex := _startBlock;
    transactions := HashMap.fromIter(Iter.fromArray(transactionsStable), transactionsStable.size(), Nat.equal, Hash.hash);
    transactionsStable := [];
    employees := HashMap.fromIter(Iter.fromArray(stableEmployees), stableEmployees.size(), Nat.equal, Hash.hash);
    stableEmployees := [];
    notifications := HashMap.fromIter(Iter.fromArray(notificationsStable), notificationsStable.size(), Nat.equal, Hash.hash);
    notificationsStable := [];

    organizations := HashMap.fromIter(Iter.fromArray(organizationsStable), organizationsStable.size(), Nat.equal, Hash.hash);
    organizationsStable := [];

    departments := HashMap.fromIter(Iter.fromArray(departmentsStable), departmentsStable.size(), Nat.equal, Hash.hash);
    departmentsStable := [];

    designations := HashMap.fromIter(Iter.fromArray(designationsStable), designationsStable.size(), Nat.equal, Hash.hash);
    designationsStable := [];

  };

  // #endregion

  // #region Create Invoice
  public shared ({ caller }) func save_transaction(args : PaymentTypes.CreateTransactionArgs) : async PaymentTypes.CreateTransactionResult {
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
  public shared query ({ caller }) func get_transaction(args : PaymentTypes.GetTransactionArgs) : async PaymentTypes.GetTransactionResult {
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

  //create new employee
  public shared ({ caller }) func create_emp(args : StorageTypes.CreateEmpArgs) : async Types.Response<Emp> {
    let id : Nat = noOfEmployees;
    // increment counter
    noOfEmployees += 1;

    let newEmp : Emp = {
      creator = caller;
      first_name = args.first_name;
      last_name = args.last_name;
      identity = args.identity;
      email_address = args.email_address;
      phone_number = args.phone_number;
      joining_date = args.joining_date;
      gender = args.gender;
      disability = args.disability;
      organization = args.organization;
      department = args.department;
      designation = args.designation;
      employee_type = args.employee_type;
      job_group = args.job_group;
      gross_salary = args.gross_salary;
      role = args.role;

    };

    employees.put(id, newEmp);

    {
      status = 200;
      status_text = "OK";
      data = ?newEmp;
      error_text = null;
    };

  };

  // #region Create Department
  public shared ({ caller }) func create_department(args : StorageTypes.CreateDepartmentArgs) : async Types.Response<Department> {
    let id : Nat = departmentsCounter;
    // increment counter
    departmentsCounter += 1;

    let department : Department = {
      code = args.code;
      name = args.name;
      creator = caller;
    };

    departments.put(id, department);

    {
      status = 200;
      status_text = "OK";
      data = ?department;
      error_text = null;
    };

  };

  // #endregion

  // #region Create Organization
  public shared ({ caller }) func create_organization(args : StorageTypes.CreateOrganizationArgs) : async Types.Response<Organization> {
    let id : Nat = organizationsCounter;
    // increment counter
    organizationsCounter += 1;

    let organization : Organization = {
      code = args.code;
      name = args.name;
      creator = caller;
    };

    organizations.put(id, organization);

    {
      status = 200;
      status_text = "OK";
      data = ?organization;
      error_text = null;
    };

  };

  // #endregion

  //get no of my organizations
  public shared query ({ caller }) func getOrganizationsLength() : async Text {
    let allEntries = Iter.toArray(organizations.entries());
    var size = 0;
    for ((_, organization) in allEntries.vals()) {
      if (organization.creator == caller) {
        size += 1;
      };
    };
    return Nat.toText(size);
  };

  //get no of my departments
  public shared query ({ caller }) func getDepartmentsLength() : async Text {
    let allEntries = Iter.toArray(departments.entries());
    var size = 0;
    for ((_, department) in allEntries.vals()) {
      if (department.creator == caller) {
        size += 1;
      };
    };
    return Nat.toText(size);
  };

  //get no of my designations
  public shared query ({ caller }) func getDesignationsLength() : async Text {
    let allEntries = Iter.toArray(designations.entries());
    var size = 0;
    for ((_, designation) in allEntries.vals()) {
      if (designation.creator == caller) {
        size += 1;
      };
    };
    return Nat.toText(size);
  };

  // #region Create Designation
  public shared ({ caller }) func create_designation(args : StorageTypes.CreateDesignationArgs) : async Types.Response<Designation> {
    let id : Nat = designationsCounter;
    // increment counter
    designationsCounter += 1;

    let designation : Designation = {
      code = args.code;
      name = args.name;
      creator = caller;
    };

    designations.put(id, designation);

    {
      status = 200;
      status_text = "OK";
      data = ?designation;
      error_text = null;
    };

  };

  // #endregion

  //get employees added by caller
  public shared ({ caller }) func getEmployees() : async [Emp] {
    let allEntries = Iter.toArray(employees.entries());
    let my_contacts = Buffer.Buffer<Emp>(50);
    for ((_, contact) in allEntries.vals()) {
      if (contact.creator == caller) {
        my_contacts.add(contact);
      };
    };

    return Buffer.toArray<Emp>(my_contacts);
  };

  //get organizations added by caller
  public shared query ({ caller }) func getOrganizations() : async [Organization] {
    let allEntries = Iter.toArray(organizations.entries());
    let my_organizations = Buffer.Buffer<Organization>(50);
    for ((_, organization) in allEntries.vals()) {
      if (organization.creator == caller) {
        my_organizations.add(organization);
      };
    };

    return Buffer.toArray<Organization>(my_organizations);
  };

  //get departments added by caller
  public shared query ({ caller }) func getDepartments() : async [Department] {
    let allEntries = Iter.toArray(departments.entries());
    let my_departments = Buffer.Buffer<Department>(50);
    for ((_, department) in allEntries.vals()) {
      if (department.creator == caller) {
        my_departments.add(department);
      };
    };

    return Buffer.toArray<Department>(my_departments);
  };

  //get designation added by caller
  public shared query ({ caller }) func getDesignations() : async [Designation] {
    let allEntries = Iter.toArray(designations.entries());
    let my_designations = Buffer.Buffer<Designation>(50);
    for ((_, designation) in allEntries.vals()) {
      if (designation.creator == caller) {
        my_designations.add(designation);
      };
    };

    return Buffer.toArray<Designation>(my_designations);
  };

  //get employee data based on principal
  public shared ({ caller }) func getEmpByPrincipal(principal : Principal) : async Types.Response<Emp> {
    let allEntries = Iter.toArray(employees.entries());

    //get employee by principal and then if creator is caller return employee
    for ((_, employee) in allEntries.vals()) {
      if (Principal.fromText(employee.identity) == principal) {
        if (employee.creator == caller) {
          return {
            status = 200;
            status_text = "OK";
            data = ?employee;
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

  public shared ({ caller }) func save_notification(args : StorageTypes.CreateNotificationArgs) : async StorageTypes.CreateNotificationResult {
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
    let balance = await CkBtcLedger.icrc1_balance_of({
      owner = Principal.fromActor(this);
      subaccount = ?toSubaccount(caller);
    });
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
  public query func transform(raw : HttpTypes.TransformArgs) : async HttpTypes.CanisterHttpResponsePayload {
    let transformed : HttpTypes.CanisterHttpResponsePayload = {
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
    let ic : HttpTypes.IC = actor ("aaaaa-aa");
    let url = "https://icpos-notifications.xyz/.netlify/functions/notify";
    // let idempotency_key : Text = Random.byte
    let request_headers = [
      { name = "Content-Type"; value = "application/json" },
    ];
    //   let idempotencyKey : Text = Text.concat(name, Nat.toText(randomNat));
    let idempotencyKey : Text = await generateUUID();
    let requestBodyJson : Text = "{ \"idempotencyKey\": \"" # idempotencyKey # "\", \"email\": \"" # email # "\", \"phone\": \"" # phone # "\", \"amount\": \"" # amount # "\", \"payer\": \"" # sender # "\"}";
    let requestBodyAsBlob : Blob = Text.encodeUtf8(requestBodyJson);
    let requestBodyAsNat8 : [Nat8] = Blob.toArray(requestBodyAsBlob);
    // 2.2.1 Transform context
    let transform_context : HttpTypes.TransformContext = {
      function = transform;
      context = Blob.fromArray([]);
    };

    // 2.3 The HTTP request
    let http_request : HttpTypes.HttpRequestArgs = {
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
    let http_response : HttpTypes.HttpResponsePayload = await ic.http_request(http_request);

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
  public func generateUUID() : async Text {
    let random = Random.Finite(await Random.blob());
    let randomNat = random.range(32);
    switch (randomNat) {
      case (?nat) { return "UUID-" # Nat.toText(nat) };
      case null { throw Error.reject("Entropy exhausted") };
    };
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
