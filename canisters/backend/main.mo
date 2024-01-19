import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Error "mo:base/Error";
import HashMap "mo:base/HashMap";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Map "mo:map/Map";
import CkBtcLedger "canister:icrc1_ledger";

import Types "./types";
import Utils "./utils";
import ICRC1 "./icrc1-types";

actor Backend {
    

  var icrc1Actor_ : Types.ICRC1TokenCanisterActorInterface = actor ("mxzaz-hqaaa-aaaar-qaada-cai");
  var icrc1TokenCanisterId_ : Text = Types.INVALID_CANISTER_ID;
  var icrc1TokenCanisterDecimals_ : Nat8 = 8;

   let addressConverter_ = Utils.addressConverter;
   let toAccount = Utils.toAccount;
   let computeUserSubaccountAccount  = Utils.computeUserSubaccountAccount;

  /** Get's this canister's id.  */
  func getCanisterId_() : Principal { Principal.fromActor(Backend) };

  public func getCanister() : async Text {  
 return  Principal.toText(Principal.fromActor(Backend))
   };

     public shared (message) func whoami() : async Principal {
    return message.caller;
  };

//   public shared ({caller}) func getMyBalance() : async Result.Result<Text, Text>  {

//   };


}