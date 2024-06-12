import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Nat32 "mo:base/Nat32";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Bool "mo:base/Bool";

module {

  public type AccountType = {
    #Individual : Text;
    #Company : Text;
  };

  public type Percentage = Float;
  public type Ticker = Text;
  public type Timestamp = Int;
  public type SubPrice = Float;
  public type TransactionID = Text;

  public type AccessType = ?{
    #edit;
    #add;
    #view;
    #delete;
  };

  public type EmployeeType = ?{
    #permanent;
    #intern;
    #contract;
    #freelancer;
  };

  public type AccessLevel = ?{
    #administrator;
    #user;
    #owner;
    #finance;
  };

  public type TaxType = ?{
    #paye : Percentage;
    #contract : Percentage;
    #withholding : Percentage;
  };

  public type PaymentSchedule = {
    #daily;
    #weekly;
    #monthly;
    #yearly;
  };

  public type Response<T> = {
    status : Nat16;
    status_text : Text;
    data : ?T;
    error_text : ?Text;
  };

};
