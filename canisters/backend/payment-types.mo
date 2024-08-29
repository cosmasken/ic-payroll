import Result "mo:base/Result";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Principal "mo:base/Principal";

module {

  public type InvoiceStatus = {
    #Paid : Text;
    #Unpaid : Text;
  };

  public type Invoice = {
    id : Nat;
    creator : Text;
    isApproved : Bool;
    isPaid : Bool;
    client : Text;
    receiver : Text;
    amount : Text;
    memo : ?Text;
    created_at : Int;
    modified_at : Int;
  };
  // #region create_transaction
  public type Transaction = {
    id : Nat;
    created_at : Int;
    creator : Principal;
    amount : Nat;
    successful : Bool;
    destination : Principal;
  };

  public type CreateTransactionArgs = {
    creator : Principal;
    amount : Nat;
    destination : Principal;
    successful : Bool;
  };
  public type CreateTransactionResult = Result.Result<CreateTransactionSuccess, CreateTransactionErr>;
  public type CreateTransactionSuccess = {
    transaction : Transaction;
  };
  public type CreateTransactionErr = {
    message : ?Text;
    kind : {
      #InsufficientBalance;
      #InvalidAmount;
      #InvalidDestination;
      #InvalidDetails;
      #InvalidSender;
      #MaxTransactionsReached;
      #Other;
    };
  };

  public type GetTransactionArgs = {
    id : Nat;
  };
  public type GetTransactionResult = Result.Result<GetTransactionSuccess, GetTransactionErr>;
  public type GetTransactionSuccess = {
    transaction : Transaction;
  };
  public type GetTransactionErr = {
    message : ?Text;
    kind : {
      #InvalidTransactionId;
      #NotFound;
      #NotAuthorized;
      #Other;
    };
  };

  // #endregion

  public type Payslip = {
    gross_salary : Nat;
    taxable_income : Nat;
    net_salary : Nat;
    housing : Nat;
    nhif_deductions : Nat;
    nssf_deductions : Nat;
    personal_relief : Nat;
    paye : Nat;
    other_deductions : Nat;
    total_tax : Nat;
  };

  public type PayrollType = {
    id : Nat;
    created_at : Int;
    creator : Text;
    amount : Nat;
    successful : Bool;
    destination : Text;
  };

  public type Payment = {
    amount : Nat;
    receiver : Text;
  };

  public type Autom8Payment = {
    creator : Principal;
    amount : Nat;
    receiver : Text;
    memo : Text;
    status : {
      #Created;
      #Queued;
      #Accepted;
      #Rejected;
      #Unpaid;
      #Paid;
    };
    created_at : Int;
    scheduled_after : Nat;
  };

  public type Autom8PaymentArgs = {
    amount : Nat;
    receiver : Text;
    memo : Text;
    scheduled_after : Nat;
  };

  //bulk payment
  public type BulkPayment = {
    id : Nat;
    created_at : Int;
    creator : Principal;
    amount : Nat;
    receivers : [Principal];
    status : {
      #Created;
      #Accepted;
      #Rejected;
      #Unpaid;
      #Paid;
    };
  };

  public type CreateInvoiceArgs = {

    client : Text;
    receiver : Text;
    amount : Text;
    memo : ?Text;

  };
  public type CreateInvoiceResult = Result.Result<CreateInvoiceSuccess, CreateInvoiceErr>;
  public type CreateInvoiceSuccess = {
    invoice : Invoice;
  };
  public type CreateInvoiceErr = {
    message : ?Text;
    kind : {
      #InvalidUser;
      #InvalidId;
      #Other;
    };
  };

  public type SchedulePaymentsArgs = {
    receivers : [PayrollType];
    created_at : Int;
    payment_at : Int;
    status : {
      #Accepted;
      #Rejected;
      #Unpaid;
      #Paid;
    };
  };
  public type SchedulePaymentsResult = Result.Result<SchedulePaymentsSuccess, SchedulePaymentsErr>;
  public type SchedulePaymentsSuccess = {
    receivers : [PayrollType];
  };
  public type SchedulePaymentsErr = {
    message : ?Text;
    kind : {
      #InsufficientBalance;
      #InvalidAmount;
      #InvalidDestination;
      #InvalidDetails;
      #InvalidSender;
      #MaxTransactionsReached;
      #Other;
    };
  };

  public type PayslipData = {
    code: Text;
    name : Text;
    organization : Text;
    department : Text;
    designation : Text;
     gross_salary : Nat;
    taxable_income : Nat;
    net_salary : Nat;
    housing : Nat;
    nhif_deductions : Nat;
    nssf_deductions : Nat;
    personal_relief : Nat;
    paye : Nat;
    other_deductions : Nat;
    total_tax : Nat;
  };

};
