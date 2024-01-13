import CkBtcLedger "canister:icrc1_ledger";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import { toAccount; toSubaccount; createInvoice } "./utils";
actor Backend {

    public shared query (msg) func whoami() : async Principal {
        msg.caller
    };

    stable var currentValue: Nat = 0;

    public func increment(): async () {
        currentValue += 1;
    };

    public shared ({ caller }) func getBalance() : async Text{

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      { owner = caller;
      subaccount = null;}
    );

    return Nat.toText(balance);

    };

    // if (balance < 100) {
    //   return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    // };

   
  };



