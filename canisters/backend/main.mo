import CkBtcLedger "canister:icrc1_ledger";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Error "mo:base/Error";
import Text "mo:base/Text";
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

    let formattedBalance = balance / 100000000;

    return Nat.toText(formattedBalance);

    };


     public shared ({ caller }) func makeTransfer(receiver:Text, amount:Nat) : async Result.Result<Text, Text>{

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      { owner = caller;
      subaccount = null;}
    );

  let formattedBalance = balance / 100000000;
  
    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

  

      try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = amount - 10;
          from_subaccount = null;
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromText(receiver);
            subaccount = null;
          };
        }
      );

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to default account:\n" # debug_show (transferError));
        };
        case (_) {};
      };
    } catch (error : Error) {
      return #err("Reject message: " # Error.message(error));
    };


return #ok("🥠: " # " amount Sent");

    };



 

   
  };



