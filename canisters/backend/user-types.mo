import Blob "mo:base/Blob";
import Principal "mo:base/Principal";

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

  public type User = {
    first_name : Text;
    last_name : Text;
    email_notifications : Bool;
    email_address : Text;
    phone_notifications : Bool;
    phone_number : Text;
    is_verified : Bool;
  };

};
