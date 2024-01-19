import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";
module {

  // The following are reassigned for export:
  public type ICRC1TokenCanisterActorInterface = TokenCanisterInterface.Actor;
  public type Account = TokenCanister.Account;
  public type Subaccount = TokenCanister.Subaccount;
  public type Value = TokenCanister.Value;
  public type BalanceArgs = TokenCanister.BalanceArgs;
  public type BalanceReturned = TokenCanister.Tokens;
  public type TransferArgs = TokenCanister.TransferArgs;
  public type TransferResult = TokenCanister.TransferResult;
  public type TransferError = TokenCanister.TransferError;
  public type TxIndex = TokenCanister.TxIndex;
  public type MetadataReturned = [(Text, Value)];

  /** ICRC1 actor interface proxy. */
  module TokenCanisterInterface {
    public type Actor = actor {
      icrc1_transfer : shared TokenCanister.TransferArgs -> async TokenCanister.TransferResult;
      icrc1_balance_of : shared query TokenCanister.BalanceArgs -> async TokenCanister.Tokens;
      icrc1_metadata : shared query () -> async [(Text, Value)];
      icrc1_decimals : shared query () -> async Nat8;
    };
  };

  /** Types of the ICRC1 token canister ("ledger").  */
  module TokenCanister {

    public type Value = { #Nat : Nat; #Int : Int; #Blob : Blob; #Text : Text };

    public type Account = { owner : Principal; subaccount : ?Subaccount };
    public type Subaccount = Blob;
    public type Memo = Blob;
    public type Timestamp = Nat64;
    public type Duration = Nat64;
    public type TxIndex = Nat;
    public type Tokens = Nat;

    public type BalanceArgs = Account;

    public type TransferArgs = {
      from_subaccount : ?Subaccount;
      to : Account;
      amount : Tokens;
      fee : ?Tokens;
      memo : ?Memo;
      created_at_time : ?Timestamp;
    };

    public type Result<T, E> = { #Ok : T; #Err : E };

    public type TransferResult = Result<TxIndex, TransferError>;

    public type CommonFields = {
      memo : ?Memo;
      fee : ?Tokens;
      created_at_time : ?Timestamp;
    };

    public type DeduplicationError = {
      #TooOld;
      #Duplicate : { duplicate_of : TxIndex };
      #CreatedInFuture : { ledger_time : Timestamp };
    };

    public type CommonError = {
      #InsufficientFunds : { balance : Tokens };
      #BadFee : { expected_fee : Tokens };
      #TemporarilyUnavailable;
      #GenericError : { error_code : Nat; message : Text };
    };

    public type TransferError = DeduplicationError or CommonError or {
      #BadBurn : { min_burn_amount : Tokens };
    };
  };
};
