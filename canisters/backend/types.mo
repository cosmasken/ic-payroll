import Principal "mo:base/Principal";
import Time "mo:base/Time";
module {
  public type Subaccount = Blob;
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
    status : Text;
    created_at : Int;
  };

  public type Transaction = {
    from : Principal;
    to : Principal;
    amount : Nat;
    memo : Text;
    created_at : Int;
  };

  // New type for User
  public type User = {
    id : Nat;
    name : Text;
    email : Text;
    email_notifications : Bool;
    phone : Text;
    phone_notifications : Bool;
    wallet : Text;
    created_at : Int;
  };

  public type Response<T> = {
    status : Nat16;
    status_text : Text;
    data : ?T;
    error_text : ?Text;
  };

};
