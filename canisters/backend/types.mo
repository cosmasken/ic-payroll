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
    from : Principal;
    to : Principal;
    amount : Nat;
    memo : Text;
    status : InvoiceStatus;
    created_at : Int;
    modified_at : Int;
  };

    public type Transaction = {
    id : Nat;
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

  public type Response<T> = {
    status : Nat16;
    status_text : Text;
    data : ?T;
    error_text : ?Text;
  };

  public type Notification = {
    receiver : Text;
    amount : Nat;
    time : Text;
    isSuccessful : Bool;
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
  // public type CreateTransactionArgs = {
  //   id : Nat;
  //   creator : Principal;
  //   amount : Text;
  //   from : Text;
  //   to: Text;
  //   memo : ?Blob;
  // };
  // id : Nat;
  //   creator : Principal;
  //   amount : Nat;
  //   verifiedAtTime : ?Time.Time;
  //   successful : Bool;
  //   destination : Principal;
   public type CreateTransactionArgs = {
    creator : Principal;
    amount : Nat;
    destination: Principal;
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



};
