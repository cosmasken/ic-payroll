import CkBtcLedger "canister:ckbtc_ledger";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import { toAccount; toSubaccount; defaultSubaccount } "./utils";

module BalanceUtil {

  public func getFundingBalance(caller : Principal) : async Text {
    let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = caller;
        subaccount = null;
      },
    );
    return Nat.toText(balance);
  };

  public func getTradingBalance(canister : Principal, caller : Principal) : async Text {
    let balance = await CkBtcLedger.icrc1_balance_of({
      owner = canister;
      subaccount = ?toSubaccount(caller);
    });
    return Nat.toText(balance);
  };

  public func getCanisterBalance(owner : Principal) : async Text {
    let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = owner;
        subaccount = null;
      },
    );
    return Nat.toText(balance);
  };
};
