import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Nat32 "mo:base/Nat32";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
import Result "mo:base/Result";

module {

  //1. Type that describes the Request arguments for an HTTPS outcall
  //See: https://internetcomputer.org/docs/current/references/ic-interface-spec/#ic-http_request
  public type HttpRequestArgs = {
    url : Text;
    max_response_bytes : ?Nat64;
    headers : [HttpHeader];
    body : ?[Nat8];
    method : HttpMethod;
    transform : ?TransformRawResponseFunction;
  };

  public type HttpHeader = {
    name : Text;
    value : Text;
  };

  public type HttpMethod = {
    #get;
    #post;
    #head;
  };

  public type HttpResponsePayload = {
    status : Nat;
    headers : [HttpHeader];
    body : [Nat8];
  };

  //2. HTTPS outcalls have an optional "transform" key. These two types help describe it.
  //"The transform function may, for example, transform the body in any way, add or remove headers,
  //modify headers, etc. "
  //See: https://internetcomputer.org/docs/current/references/ic-interface-spec/#ic-http_request

  //2.1 This type describes a function called "TransformRawResponse" used in line 14 above
  //"If provided, the calling canister itself must export this function."
  //In this minimal example for a GET request, we declare the type for completeness, but
  //we do not use this function. We will pass "null" to the HTTP request.
  public type TransformRawResponseFunction = {
    function : shared query TransformArgs -> async HttpResponsePayload;
    context : Blob;
  };

  //2.2 This type describes the arguments the transform function needs
  public type TransformArgs = {
    response : HttpResponsePayload;
    context : Blob;
  };

  public type CanisterHttpResponsePayload = {
    status : Nat;
    headers : [HttpHeader];
    body : [Nat8];
  };

  public type TransformContext = {
    function : shared query TransformArgs -> async HttpResponsePayload;
    context : Blob;
  };

  //3. Declaring the IC management canister which we use to make the HTTPS outcall
  public type IC = actor {
    http_request : HttpRequestArgs -> async HttpResponsePayload;
  };

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

   public type Percentage        = Float;
  public type Ticker                    = Text;
  public type Timestamp                 = Int;
  public type SubPrice                  = Float;
  public type TransactionID     = Text;

  public type AccessType = ?{ 
    #edit ;
    #add ;
    #view ;
    #delete;
  };

  public type EmployeeType = ?{ 
    #permanent ;
    #intern ;
    #contract ;
    #freelancer ;
  };

  public type AccessLevel =?{
    #administrator;
    #user;
    #owner;
    #finance;
  };

   public type TaxType = ?{ 
    #paye : Percentage ;
    #contract : Percentage;
    #withholding : Percentage;
  };

  public type PaymentSchedule = {
    #daily; 
    #weekly;
    #monthly;
    #yearly;
  };

  public type Departments = {
    #hr;
    #finance;
    #legal;
    #engineering;
    #marketing;
    #admin;
  };

  // public type PayrollType = {
  //   id : Nat;
  //   created_at : Int;
  //   creator : Text;
  //   amount : Nat;
  //   approved : Bool;
  //   successful : Bool;
  //   destination : Text;
  // };

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
    emp_type : Text;
    access_type : Text;
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
   emp_type : Text;
    access_type : Text;
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


    // #region create_tpayroll instance

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
  // #endregion

};
