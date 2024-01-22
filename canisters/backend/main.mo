import Account "./Account";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Nat8 "mo:base/Nat8";

actor Backend {

  public type Account = { owner : Principal; subaccount : ?Blob };

  public type Actor = actor {
    icrc1_balance_of : (acc : Account) -> async Nat;
  };

  private stable var ledgerActor : Actor = actor ("mxzaz-hqaaa-aaaar-qaada-cai") : Actor;

  public shared ({ caller }) func whoami() : async Principal {
      return caller;
   };

  public shared (msg) func getDepositAddress() : async Text {
    let acc : Account = {
      owner = Principal.fromActor(Backend);
      subaccount = ?Account.toSubaccount(msg.caller);
    };
    return Account.toText(acc);
  };

  public shared (msg) func getBalance() : async Nat {
    let acc : Account = {
      owner = Principal.fromActor(Backend);
      subaccount = ?Account.toSubaccount(msg.caller);
    };
    var response : Nat = await ledgerActor.icrc1_balance_of(acc);
    return response;
  }

};
