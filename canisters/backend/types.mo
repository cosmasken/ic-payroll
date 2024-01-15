import Text "mo:base/Text";
module {
  public type Subaccount = Blob;
  public type Account = {
    owner : Principal;
    subaccount : ?Subaccount;
  };
 
  public type Invoice = {
    to : Account;
    amount : Nat;
  };

  public type Payment = {
    from : Account;
    amount : Nat;
  };

  
};
