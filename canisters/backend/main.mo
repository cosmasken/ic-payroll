import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Prim = "mo:prim";
import CkBtcLedger "canister:ckbtc_ledger";

//import CkBtcIndex "canister:icrc1_index";
import Types "./types";
import HttpTypes "./http-types";
import UserTypes "./user-types";
import PaymentTypes "./payment-types";
import StorageTypes "./storage-types";
import { toSubaccount } "./utils";
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
import Deque "mo:base/Deque";
import Taxcalculator "taxcalculator";
import BalanceUtils "balance-utils";
import UserUtils "user-utils";
import EmailUtils "email-utils";

import ImgTypes "img-types";

import Memory "mo:base/ExperimentalStableMemory";

shared (actorContext) actor class Backend() = this {

  // #region Types
  type Account = UserTypes.Account;
  type AccountIdentifier = UserTypes.AccountIdentifier;
  type User = UserTypes.User;

  type Emp = StorageTypes.Employee;
  type Leave = StorageTypes.Leave;
  type Department = StorageTypes.Department;
  type Organization = StorageTypes.Organization;
  type Organogram = StorageTypes.Organogram;
  type Designation = StorageTypes.Designation;
  type Notification = StorageTypes.Notification;

  type Payslip = PaymentTypes.Payslip;
  type PayrollType = PaymentTypes.PayrollType;
  type Payment = PaymentTypes.Payment;
  type Transaction = PaymentTypes.Transaction;
  type Invoice = PaymentTypes.Invoice;
  type PayslipData = PaymentTypes.PayslipData;
  type Autom8Payment = PaymentTypes.Autom8Payment;
  type BulkPayment = PaymentTypes.BulkPayment;
  type Autom8PaymentArgs = PaymentTypes.Autom8PaymentArgs;

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
  stable var departmentsStable : [(Nat, Department)] = [];
  stable var organizationsStable : [(Nat, Organization)] = [];
  stable var organogramsStable : [(Nat, Organogram)] = [];
  stable var designationsStable : [(Nat, Designation)] = [];
  stable var stableEmployees : [(Nat, Emp)] = [];
  stable var notificationsStable : [(Nat, Notification)] = [];
  stable var invoicesStable : [(Nat, Invoice)] = [];
  stable var stablePayroll : [(Nat, [PayrollType])] = [];

  stable var stableAutom8Payments : [(Nat, Autom8Payment)] = [];
    stable var scheduledTransactions : [(Nat, [Autom8Payment])] = [];
  stable  var stableBulkPayments : [(Nat, Payment)] = [];
  stable var transactionCounter : Nat = 0;
  stable var contactsCounter : Nat = 0;
  stable var noOfEmployees : Nat = 0;
  stable var organizationsCounter : Nat = 0;
  stable var organogramsCounter : Nat = 0;
  stable var departmentsCounter : Nat = 0;
  stable var designationsCounter : Nat = 0;
  let oneMinute = 60;
  stable var notificationsCounter : Nat = 0;
  stable var invoiceCounter : Nat = 0;
  stable var payrollCounter : Nat = 0;
  stable var autom8PaymentCounter : Nat = 0;
  stable var bulkPaymentCounter : Nat = 0;
  var transactions : HashMap.HashMap<Nat, Transaction> = HashMap.fromIter(Iter.fromArray(transactionsStable), transactionsStable.size(), Nat.equal, Hash.hash);
  var employees : HashMap.HashMap<Nat, Emp> = HashMap.fromIter(Iter.fromArray(stableEmployees), stableEmployees.size(), Nat.equal, Hash.hash);
  var notifications : HashMap.HashMap<Nat, Notification> = HashMap.fromIter(Iter.fromArray(notificationsStable), notificationsStable.size(), Nat.equal, Hash.hash);
  var payrolls : HashMap.HashMap<Nat, [PayrollType]> = HashMap.fromIter(Iter.fromArray(stablePayroll), stablePayroll.size(), Nat.equal, Hash.hash);
  var organizations : HashMap.HashMap<Nat, Organization> = HashMap.fromIter(Iter.fromArray(organizationsStable), organizationsStable.size(), Nat.equal, Hash.hash);
  var organograms : HashMap.HashMap<Nat, Organogram> = HashMap.fromIter(Iter.fromArray(organogramsStable), organogramsStable.size(), Nat.equal, Hash.hash);
  var departments : HashMap.HashMap<Nat, Department> = HashMap.fromIter(Iter.fromArray(departmentsStable), departmentsStable.size(), Nat.equal, Hash.hash);
  var designations : HashMap.HashMap<Nat, Designation> = HashMap.fromIter(Iter.fromArray(designationsStable), designationsStable.size(), Nat.equal, Hash.hash);
  var autom8payments : HashMap.HashMap<Nat, Autom8Payment> = HashMap.fromIter(Iter.fromArray(stableAutom8Payments), stableAutom8Payments.size(), Nat.equal, Hash.hash);
  var bulkPayments : HashMap.HashMap<Nat, Payment> = HashMap.fromIter(Iter.fromArray(stableBulkPayments), stableBulkPayments.size(), Nat.equal, Hash.hash);
  
  let invoices : HashMap.HashMap<Nat, Invoice> = HashMap.fromIter(Iter.fromArray(invoicesStable), invoicesStable.size(), Nat.equal, Hash.hash);

  var MAX_TRANSACTIONS = 30_000;
  var MAX_AUTOM8_PAYMENTS = 30_000;

  //img utils
  type ImgId = Text;
  private stable var _currentMemoryOffset : Nat64 = 2;
  private stable var _imgOffset : [(ImgId, Nat64)] = [];
  private var imgOffset : HashMap.HashMap<ImgId, Nat64> = HashMap.fromIter(_imgOffset.vals(), 0, Text.equal, Text.hash);
  private stable var _imgSize : [(ImgId, Nat)] = [];
  private var imgSize : HashMap.HashMap<ImgId, Nat> = HashMap.fromIter(_imgSize.vals(), 0, Text.equal, Text.hash);

  // thumbnail handling
  private stable var _thumbs : [(ImgId, Blob)] = [];
  private var thumbs = HashMap.HashMap<ImgId, Blob>(0, Text.equal, Text.hash);

  public shared ({ caller }) func generatePayslip(name:Text ,organization :Text,
  department:Text,designation:Text,  income : Nat) : async PayslipData {
    let payslipInfo = await Taxcalculator.calculateTax(income);

let code = await generateCode("pid");
    let payslipData : PayslipData = {
      code = code;
      name = name;
      organization = organization;
      department = department;
      designation = designation;
      gross_salary = payslipInfo.gross_salary;
      taxable_income = payslipInfo.taxable_income;
      net_salary = payslipInfo.net_salary;
      housing = payslipInfo.housing;
      nhif_deductions = payslipInfo.nhif_deductions;
      nssf_deductions = payslipInfo.nssf_deductions;
      personal_relief = payslipInfo.personal_relief;
      paye = payslipInfo.paye;
      other_deductions = payslipInfo.other_deductions;
      total_tax = payslipInfo.total_tax;
    };

    return payslipData;


  };

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

  public func schedulePayment(when : Nat) : async Nat {
    let now = Time.now();
    let timerId = recurringTimer(
      #seconds when,
      func() : async () {
        // Debug.print("Here are the items that are pending");
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
  public shared ({ caller }) func getUser() : async Types.Response<User> {
    return await UserUtils.getUser(userStore, caller);
  };

  /**
    *  Get user data by principal
    */
  public shared ({ caller }) func getUserByPrincipal(identity : Principal) : async Types.Response<User> {

    //let principal: Principal = Principal.fromText(identity);
    return await UserUtils.getUserByPrincipal(userStore, identity);
  };

  /**
    *  Check if user exists and return Bool
    */
  public shared ({ caller }) func isRegistered() : async Bool {

    return await UserUtils.isRegistered(userStore, caller);

  };

  /**
    *  Check if user is registered
    */
  public shared ({ caller }) func isReg() : async Bool {

    let data : Types.Response<User> = await getUserByPrincipal(caller);

    switch (data.data) {
      case (?user) {
        let isRegistered = user.is_verified;
        Debug.print("isRegistered:  is  " # debug_show (isRegistered));

        return isRegistered;

      };
      case null {
        Debug.print("isRegistered:  is  " # debug_show (false));
        return false;
      };
    };

  };

  /**
    * Update the user's information
    */
  public shared (context) func createAccount(user : User) : async Types.Response<User> {

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
  public shared ({ caller }) func userLength() : async Text {

    return await UserUtils.userLength(userStore);
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

    public shared ({ caller }) func CanistertoSubAccount(receiver:Text,amount:Nat) : async Types.Response<Transaction> {

    // check ckBTC balance of the callers dedicated account
    // let balance = await CkBtcLedger.icrc1_balance_of({
    //   owner = Principal.fromActor(this);
    //   subaccount = null;
    // });

   let balance = await BalanceUtils.getCanisterBalance(Principal.fromActor(this));
   

    // if (balance < 100) {
    //   return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    // };

    //Debug.print("balance:  is  " # debug_show (balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer({
        amount = amount;
        from_subaccount = null;
        created_at_time = null;
        fee = ?10;
        memo = null;
        to = {
          owner = Principal.fromActor(this);
          subaccount = ?toSubaccount(Principal.fromText(receiver));
        };
      });

      //Debug.print("transferresult:  is  " # debug_show (transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
           return {
        status = 406;
        status_text = "Rejected";
        data = null;
        error_text = ?"Reject message: ";
      };
         // return #err("Couldn't transfer funds to default account:\n" # debug_show (transferError));
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
     // return #err("Reject message: " # Error.message(error));
    };

  //  return #ok("🥠: " # "success");
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

  public shared ({ caller }) func getTestTokens() : async Result.Result<Text, Text> {
    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer({
        amount = 50000;
        from_subaccount = null;
        created_at_time = null;
        fee = ?10;
        memo = null;
        to = {
          owner = Principal.fromActor(this);
          subaccount = ?toSubaccount(caller);
        };
      });

      Debug.print("transferresult:  is  " # debug_show (transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to default account:\n" # debug_show (transferError));
        };
        case (_) {
          return #err("Couldn't transfer funds to default account:\n");
        };
        case (#Ok(transfer)) {
          return #ok("Funds Transferred");
        };
      };
    } catch (error : Error) {
      return #err("Reject message: " # Error.message(error));
    };
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

    stableAutom8Payments := Iter.toArray(autom8payments.entries());
    stableBulkPayments := Iter.toArray(bulkPayments.entries());



    _imgOffset := Iter.toArray(imgOffset.entries());
    _imgSize := Iter.toArray(imgSize.entries());

    _thumbs := Iter.toArray(thumbs.entries());
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

    autom8payments := HashMap.fromIter(Iter.fromArray(stableAutom8Payments), stableAutom8Payments.size(), Nat.equal, Hash.hash);
    stableAutom8Payments := [];
    bulkPayments := HashMap.fromIter(Iter.fromArray(stableBulkPayments), stableBulkPayments.size(), Nat.equal, Hash.hash);
    stableBulkPayments := [];

    _imgOffset := [];
    _imgSize := [];

    thumbs := HashMap.fromIter<ImgId, Blob>(_thumbs.vals(), 10, Text.equal, Text.hash);
    _thumbs := [];

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

  //save to Autom8

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
    // let id : Nat = noOfEmployees;
    // // increment counter
    // noOfEmployees += 1;

    let id : Nat = await getRandomNat();
    let empId = await generateCode("emp");

    let newEmp : Emp = {
      creator = caller;
      first_name = args.first_name;
      last_name = args.last_name;
      email_address = args.email_address;
      phone_number = args.phone_number;
      employee_id = id;
      gender = args.gender;
      organization = args.organization;
      department = args.department;
      designation = args.designation;
      employee_type = args.employee_type;
      job_group = args.job_group;
      gross_salary = args.gross_salary;
      role = args.role;
      identity = args.identity;

    };

    employees.put(id, newEmp);

    {
      status = 200;
      status_text = "OK";
      data = ?newEmp;
      error_text = null;
    };

  };


  //remove employee
  public shared ({ caller }) func remove_emp(args : StorageTypes.RemoveEmpArgs) : async Types.Response<Emp> {
    let id : Nat = args.employee_id;
    let emp = employees.get(id);
    switch (emp) {
      case (?e) {
        if (e.creator == caller) {
          employees.delete(id);
          return {
            status = 200;
            status_text = "OK";
            data = ?e;
            error_text = null;
          };
        };
        return {
          status = 403;
          status_text = "Forbidden";
          data = null;
          error_text = ?"You are not allowed to delete this employee";
        };
      };
      case (null) {
        return {
          status = 404;
          status_text = "Not Found";
          data = null;
          error_text = ?"Employee not found";
        };
      };
    };
  };

  // #region Create Department
  public shared ({ caller }) func create_department(args : StorageTypes.CreateDepartmentArgs) : async Types.Response<Department> {
    // let id : Nat = departmentsCounter;
    // // increment counter
    // departmentsCounter += 1;
    let id : Nat = await getRandomNat();
    let code = await generateCode("dep");

    let department : Department = {
      code = code;
      id= id;
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

 // #region remove Department
  public shared ({ caller }) func remove_department(args : StorageTypes.RemoveDepartmentArgs) : async Types.Response<Department> {
    let id : Nat = args.department_id;
    let department = departments.get(id);
    switch (department) {
      case (?d) {
        if (d.creator == caller) {
          departments.delete(id);
          return {
            status = 200;
            status_text = "OK";
            data = ?d;
            error_text = null;
          };
        };
        return {
          status = 403;
          status_text = "Forbidden";
          data = null;
          error_text = ?"You are not allowed to delete this department";
        };
      };
      case (null) {
        return {
          status = 404;
          status_text = "Not Found";
          data = null;
          error_text = ?"Department not found";
        };
      };
    };
  };


  // #region Create Organization
  public shared ({ caller }) func create_organization(args : StorageTypes.CreateOrganizationArgs) : async Types.Response<Organization> {
     let id : Nat = await getRandomNat();
    let code = await generateCode("org");

    let organization : Organization = {
      code = code;
      id = id;
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

  // #region remove Organization
  public shared ({ caller }) func remove_organization(args : StorageTypes.RemoveOrganizationArgs) : async Types.Response<Organization> {
    let id : Nat = args.organization_id;
    let organization = organizations.get(id);
    switch (organization) {
      case (?o) {
        if (o.creator == caller) {
          organizations.delete(id);
          return {
            status = 200;
            status_text = "OK";
            data = ?o;
            error_text = null;
          };
        };
        return {
          status = 403;
          status_text = "Forbidden";
          data = null;
          error_text = ?"You are not allowed to delete this organization";
        };
      };
      case (null) {
        return {
          status = 404;
          status_text = "Not Found";
          data = null;
          error_text = ?"Organization not found";
        };
      };
    };
  };

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


  //get no ofAutom8Payments
  public shared query ({ caller }) func getAutom8PaymentsLength() : async Text {
    let allEntries = Iter.toArray(autom8payments.entries());
    var size = 0;
    for ((_, autom8payment) in allEntries.vals()) {
      if (autom8payment.creator == caller) {
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

   public func getRandomNat() : async Nat {
    let max : Nat8 = 100; // Set the upper limit for the random number
    let seed : Blob = await Random.blob(); // Get a source of entropy
    let randomNat : Nat = Random.rangeFrom(max, seed); // Generate a random Nat
    return randomNat;
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
    // #region Create Autom8Payment
  public shared ({ caller }) func create_Autom8Payment(args: Autom8PaymentArgs) : async Types.Response<Autom8Payment>{
    let id : Text = await generateUUID();

    let code = await getRandomNat();
 

    let autom8payment : Autom8Payment = {
      creator = caller;
      amount = args.amount;
      receiver = args.receiver;
      memo = args.memo;
      status = #Created;
      created_at = Time.now();
      scheduled_after = args.scheduled_after;
    };

    autom8payments.put(code, autom8payment);

   // Schedule the payment execution
    let delay = args.scheduled_after; // seconds

    ignore setTimer(#seconds delay, func() : async () {
   await executePayment(code);
  });

    {
      status = 200;
      status_text = "OK";
      data = ?autom8payment;
      error_text = null;
    };
    

  };


  // Define the executePayment function
private func executePayment(code: Nat) : async () {
    let payment = autom8payments.get(code);
    switch (payment) {
        case (?p) {
            // Update the payment status to executed
            let updatedPayment = {
                creator = p.creator;
                amount = p.amount;
                receiver = p.receiver;
                memo = p.memo;
                status = #Queued;
                created_at = p.created_at;
                scheduled_after = p.scheduled_after;
            };
            autom8payments.put(code, updatedPayment);

            // Perform any other actions needed, such as transferring funds
       let transfer = await CanistertoSubAccount(p.receiver, p.amount);
      
        };
        case null {
            // Handle the case where the payment does not exist
        };
    };

};

  // #region Create Designation
  public shared ({ caller }) func create_designation(args : StorageTypes.CreateDesignationArgs) : async Types.Response<Designation> {
    let id : Nat = await getRandomNat();

    let code = await generateCode("desig");

    let designation : Designation = {
      code = code;
      id = id;
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

  // #region remove Designation
  public shared ({ caller }) func remove_designation(args : StorageTypes.RemoveDesignationArgs) : async Types.Response<Designation> {
    let id : Nat = args.designation_id;
    let designation = designations.get(id);
    switch (designation) {
      case (?d) {
        if (d.creator == caller) {
          designations.delete(id);
          return {
            status = 200;
            status_text = "OK";
            data = ?d;
            error_text = null;
          };
        };
        return {
          status = 403;
          status_text = "Forbidden";
          data = null;
          error_text = ?"You are not allowed to delete this designation";
        };
      };
      case (null) {
        return {
          status = 404;
          status_text = "Not Found";
          data = null;
          error_text = ?"Designation not found";
        };
      };
    };
  };

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

  //get Autom8Payments
  public shared query ({ caller }) func getAutom8Payments() : async [Autom8Payment]{
     let allEntries = Iter.toArray(autom8payments.entries());
    let my_payments = Buffer.Buffer<Autom8Payment>(50);
    for ((_, autom8payment) in allEntries.vals()) {
      if (autom8payment.creator == caller) {
        my_payments.add(autom8payment);
      };
    };

    return Buffer.toArray<Autom8Payment>(my_payments);
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
        }else{
          return {
      status = 404;
      status_text = "You arent Authorized";
      data = null;
      error_text = null;
    };
        }
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


  //bulk payments
    public shared ({ caller }) func bulkPayment(receivers : [Payment]) : async Types.Response<[Payment]> {
    var total : Nat = 0;
    let fee : Nat = 10;
    let payments = Buffer.Buffer<Payment>(50);
    for (receiver in receivers.vals()) {
      total += receiver.amount + fee;
    };
    Debug.print("total: " # debug_show (total));

    //check balance
    let balance = await CkBtcLedger.icrc1_balance_of({
      owner = Principal.fromActor(this);
      subaccount = null;
    });
    Debug.print("balance: " # debug_show (balance));

    if (balance < total) {
      let data : [Payment] = Buffer.toArray<Payment>(payments);
      return {
        status = 403;
        status_text = "Insufficient Balance";
        data = null;
        error_text = null;
      };
    } else {

      for (receiver in receivers.vals()) {
        Debug.print("receiver: " # debug_show (receiver));

        let transaction = await CanistertoSubAccount(receiver.receiver, receiver.amount);
        Debug.print("transaction: " # debug_show (transaction));

let payment:Payment= receiver;
Debug.print("payment: " # debug_show (payment));

         let id :Nat = await getRandomNat();
         bulkPayments.put(id, payment);
      };

    };

    {
      status = 200;
      status_text = "Transfer Successful";
      data = null;
      error_text = null;
    };

  };

  //get bulk payments
  public shared ({ caller }) func getBulkPayments() : async [Payment] {
    let allEntries = Iter.toArray(bulkPayments.entries());
    let my_payments = Buffer.Buffer<Payment>(50);
    for ((_, payment) in allEntries.vals()) {
      if (payment.receiver == Principal.toText(caller)) {
        my_payments.add(payment);
      };
    };

    return Buffer.toArray<Payment>(my_payments);
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

    //to get emails working fork https://github.com/cosmasken/bitpochi-notifications/ and deploy on netlify and change the follwing line
    // let url = "https://bitpochi-notifications.netlify.app/.netlify/functions/notify";
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
   // Cycles.add(70_000_000);
// As of Motoko version 0.11.0, you need to include the system type parameter when calling functions from this module
   Cycles.add<system>(70_000_000);
    let http_response : HttpTypes.HttpResponsePayload = await ic.http_request(http_request);

    Debug.print("http_response: " # debug_show (http_response));

    if (http_response.status > 299) {
      let response_body : Blob = Blob.fromArray(http_response.body);
      let decoded_text : Text = switch (Text.decodeUtf8(response_body)) {
        case (null) { "No value returned" };
        case (?y) { y };
      };
      // log("Error sending notification: " # decoded_text);
      Debug.print("Error sending notification: " # decoded_text);
    } else {
      Debug.print("Notification sent to " # email);
      //  log("Notification sent");
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


  //Helper method that generates a unique code for departments/employees/organizations
  public func generateCode(prefix : Text) : async Text {
    let random = Random.Finite(await Random.blob());
    let randomNat = random.range(32);
    switch (randomNat) {
      case (?nat) { return prefix # Nat.toText(nat) };
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

  public shared (msg) func uploadImg(imgId : ImgId, image : Blob) {
    storeBlobImg(imgId, image);
  };

  public shared (msg) func uploadThumbnail(imgId : ImgId, thumbnail : Blob) {
    thumbs.put(imgId, thumbnail);
  };

  public query ({ caller }) func getPic(id : ImgId) : async Blob {
    var pic = loadBlobImg(id);
    switch (pic) {
      case (null) {
        return Blob.fromArray([]);
      };
      case (?existingPic) {
        return existingPic;
      };
    };
  };

  public query ({ caller }) func getThumbnail(id : ImgId) : async Blob {
    var pic = thumbs.get(id);
    switch (pic) {
      case (null) {
        return Blob.fromArray([]);
      };
      case (?existingPic) {
        return existingPic;
      };
    };
  };

  private func storeBlobImg(imgId : ImgId, value : Blob) {
    var size : Nat = Nat32.toNat(Nat32.fromIntWrap(value.size()));
    // Each page is 64KiB (65536 bytes)
    var growBy : Nat = size / 65536 + 1;
    let a = Memory.grow(Nat64.fromNat(growBy));
    Memory.storeBlob(_currentMemoryOffset, value);
    imgOffset.put(imgId, _currentMemoryOffset);
    imgSize.put(imgId, size);
    size := size + 4;
    _currentMemoryOffset += Nat64.fromNat(size);
  };

  private func loadBlobImg(imgId : ImgId) : ?Blob {
    let offset = imgOffset.get(imgId);
    switch (offset) {
      case (null) {
        return null;
      };
      case (?offset) {
        let size = imgSize.get(imgId);
        switch (size) {
          case (null) {
            return null;
          };
          case (?size) {
            return ?Memory.loadBlob(offset, size);
          };
        };
      };
    };
  };

  public query func http_request(request : ImgTypes.Request) : async ImgTypes.Response {
    if (Text.contains(request.url, #text("imgid"))) {
      let imgId = Iter.toArray(Text.tokens(request.url, #text("imgid=")))[1];

      if (Text.contains(request.url, #text("thumbnail"))) {
        var pic = thumbs.get(imgId);
        switch (pic) {
          case (null) {
            return http404(?"no pic available");
          };
          case (?existingPic) {
            return picture(existingPic);
          };
        };
      } else {
        var pic = loadBlobImg(imgId);
        switch (pic) {
          case (null) {
            return http404(?"no thumbnail available");
          };
          case (?existingPic) {
            return picture(existingPic);
          };
        };
      };
    };
    return http404(?"Path not found.");
  };

  // A 200 Ok response with picture
  private func picture(pic : Blob) : ImgTypes.Response {
    {
      body = pic;
      headers = [
        ("Content-Type", "image/jpg"),
        ("Access-Control-Allow-Origin", "*"),
        ("Expires", "Wed, 9 Jan 2099 09:09:09 GMT"),
      ];
      status_code = 200;
      streaming_strategy = null;
    };
  };

  // A 404 response with an optional error message.
  private func http404(msg : ?Text) : ImgTypes.Response {
    {
      body = Text.encodeUtf8(
        switch (msg) {
          case (?msg) msg;
          case null "Not found.";
        }
      );
      headers = [
        ("Content-Type", "text/plain"),
      ];
      status_code = 404;
      streaming_strategy = null;
    };
  };
 

};
