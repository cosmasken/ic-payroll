import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Error "mo:base/Error";
import HashMap "mo:base/HashMap";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Time "mo:base/Time";

import ICRC1 "./icrc1-types";

module {

  public type ICRC1TokenCanisterActorInterface = ICRC1.ICRC1TokenCanisterActorInterface;
  public type Account = ICRC1.Account;
  public type Value = ICRC1.Value;
  public type BalanceArgs = ICRC1.BalanceArgs;
  public type BalanceReturned = ICRC1.BalanceReturned;
  public type TransferArgs = ICRC1.TransferArgs;
  public type TransferResult = ICRC1.TransferResult;
  public type TransferError = ICRC1.TransferError;
  public type TxIndex = ICRC1.TxIndex;
  public type Metadatum = (Text, Value);
  public type Metadatas = [Metadatum];

  public type ICRC1Address = Text;

  public let INVALID_CANISTER_ID = "invalid!canister!id";

  public type Payment = {
    createdAtNs : Time.Time;
    amount : Nat;
    description : ?Text;
    // Could be canister generated UUID or ULID; but currently just number concatenated with clientPaymentId:
    id : Text;
    // Naive id or payment creation count for this user, displayed to the user:
    number : Nat;
    // In more developed version, would serve as payment's idempotent key for reliable processing:
    clientPaymentId : Text;
    // In (future) case where a single user's account can have multiple
    // subaccounts, store the specific address funds are sourced from:
    sourceAddress : ICRC1Address;
    recipientAddress : ICRC1Address;
    status : PaymentStatus;
  };

  public type PaymentStatus = {
    // Otherwise the frontend will be false for `status.Pending ?` so add unit record type:
    #Pending : {};
    #Completed : { timestampNs : Time.Time; txIndex : TxIndex };
    #Failed : { timestampNs : Time.Time; kind : PaymentError };
  };

  public type PaymentError = {
    // Otherwise the frontend will be false for `status.Pending ?` so add unit record type:
    #InvalidRecipientAddress : {};
    #ICRC1TokenCanisterTransferErr : ICRC1.TransferError;
    #InterCanisterCallCaughtError : Text;
  };

  public type GetTokenCanisterMetadataArgs = ();
  public type GetTokenCanisterMetadataResult = Result.Result<{ metadata : Metadatas; canisterId : Text }, { msg : Text }>;

  public type GetAccountAddressArgs = ();
  public type GetAccountAddress = { accountAddress : ICRC1Address };

  public type GetAccountBalanceArgs = ();
  public type GetAccountBalanceResult = Result.Result<GetAccountBalanceSuccess, GetAccountBalanceErr>;
  public type GetAccountBalanceSuccess = {
    timestampNs : Time.Time;
    accountAddress : ICRC1Address;
    currentBalance : Nat;
  };
  public type GetAccountBalanceErr = { msg : Text };

  public type GetAccountPaymentsArgs = ();
  public type GetAccountPayments = {
    timestampNs : Time.Time;
    payments : [Payment];
    createdCount : Nat;
  };

  public type SendPaymentArgs = {
    clientPaymentId : Text;
    description : ?Text;
    amount : Nat;
    recipientAddress : Text;
  };
  public type SendPayment = {
    payment : Payment;
    result : Result.Result<(), { msg : Text }>;
  };
};
