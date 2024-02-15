import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Nat32 "mo:base/Nat32";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
import Result "mo:base/Result";

module {
  public type Subaccount = Blob;

  public type AccountIdentifier = {
    #text : Text;
    #principal : Principal;
    #blob : Blob;
  };

  public type Account = {
    owner : Principal;
    subaccount : ?Subaccount;
  };

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

  public type PayrollType = {
    id : Nat;
    created_at : Int;
    creator : Text;
    amount : Nat;
    successful : Bool;
    destination : Text;
  };

  public type Transaction = {
    id : Nat;
    created_at : Int;
    creator : Principal;
    amount : Nat;
    successful : Bool;
    destination : Principal;
  };

  public type User = {
    name : Text;
    email_notifications : Bool;
    email_address : Text;
    phone_notifications : Bool;
    phone_number : Text;
  };

  //type representing  a user that is an employee/freelancer
  public type Employee = {
    id : Nat;
    name : Text;
    email_address : Text;
    phone_number : Text;
    wallet : Text;
    creator : Principal;
    created_at : Int;
    modified_at : Int;
  };

  public type Response<T> = {
    status : Nat16;
    status_text : Text;
    data : ?T;
    error_text : ?Text;
  };

  public type Notification = {
    id : Nat;
    sender : Text;
    receiver : Text;
    amount : Nat;
    isRead : Bool;
  };

  // #region get_caller_identifier
  public type GetAccountIdentifierArgs = {
    principal : Principal;
  };
  public type GetAccountIdentifierResult = Result.Result<GetAccountIdentifierSuccess, GetAccountIdentifierErr>;
  public type GetAccountIdentifierSuccess = {
    accountIdentifier : AccountIdentifier;
  };
  public type GetAccountIdentifierErr = {
    message : ?Text;
  };
  // #endregion

  // #region accountIdentifierToBlob
  public type AccountIdentifierToBlobArgs = {
    accountIdentifier : AccountIdentifier;
    canisterId : ?Principal;
  };
  public type AccountIdentifierToBlobResult = Result.Result<AccountIdentifierToBlobSuccess, AccountIdentifierToBlobErr>;
  public type AccountIdentifierToBlobSuccess = Blob;
  public type AccountIdentifierToBlobErr = {
    message : ?Text;
    kind : {
      #InvalidAccountIdentifier;
      #Other;
    };
  };
  // #endregion

  // #region accountIdentifierToText
  public type AccountIdentifierToTextArgs = {
    accountIdentifier : AccountIdentifier;
    canisterId : ?Principal;
  };
  public type AccountIdentifierToTextResult = Result.Result<AccountIdentifierToTextSuccess, AccountIdentifierToTextErr>;
  public type AccountIdentifierToTextSuccess = Text;
  public type AccountIdentifierToTextErr = {
    message : ?Text;
    kind : {
      #InvalidAccountIdentifier;
      #Other;
    };
  };
  // #endregion

  // #region create_transaction

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
  // #endregion

  // #region get_transaction
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

  // #region create employee
  public type CreateEmployeeArgs = {
    wallet : Text;
  };
  public type CreateEmployeeResult = Result.Result<CreateEmployeeSuccess, CreateEmployeeErr>;
  public type CreateEmployeeSuccess = {
    employee : Employee;
  };
  public type CreateEmployeeErr = {
    message : ?Text;
    kind : {
      #InvalidUser;
      #InvalidPrincipal;
      #Other;
    };
  };

  //region create notification
  public type CreateNotificationArgs = {
    sender : Text;
    receiver : Text;
    amount : Nat;
    isRead : Bool;
  };
  public type CreateNotificationResult = Result.Result<CreateNotificationSuccess, CreateNotificationErr>;
  public type CreateNotificationSuccess = {
    notification : Notification;
  };
  public type CreateNotificationErr = {
    message : ?Text;
    kind : {
      #InvalidNotification;
      #Other;
    };
  };

  //region create invoice
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

};
