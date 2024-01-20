import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface GetAccountAddress { 'accountAddress' : ICRC1Address }
export interface GetAccountBalanceErr { 'msg' : string }
export type GetAccountBalanceResult = { 'ok' : GetAccountBalanceSuccess } |
  { 'err' : GetAccountBalanceErr };
export interface GetAccountBalanceSuccess {
  'currentBalance' : bigint,
  'timestampNs' : Time,
  'accountAddress' : ICRC1Address,
}
export interface GetAccountPayments {
  'payments' : Array<Payment>,
  'createdCount' : bigint,
  'timestampNs' : Time,
}
export type GetTokenCanisterMetadataResult = {
    'ok' : { 'metadata' : Metadatas, 'canisterId' : string }
  } |
  { 'err' : { 'msg' : string } };
export type ICRC1Address = string;
export type Metadatas = Array<Metadatum>;
export type Metadatum = [string, Value];
export interface Payment {
  'id' : string,
  'status' : PaymentStatus,
  'clientPaymentId' : string,
  'createdAtNs' : Time,
  'description' : [] | [string],
  'number' : bigint,
  'recipientAddress' : ICRC1Address,
  'amount' : bigint,
  'sourceAddress' : ICRC1Address,
}
export type PaymentError = { 'InvalidRecipientAddress' : {} } |
  { 'InterCanisterCallCaughtError' : string } |
  { 'ICRC1TokenCanisterTransferErr' : TransferError };
export interface PaymentProcessor {
  'getMyAccountBalance' : ActorMethod<[], string>,
  'getSubAccountBalance' : ActorMethod<[], string>,
  'get_account_address' : ActorMethod<[], GetAccountAddress>,
  'get_account_balance' : ActorMethod<[], GetAccountBalanceResult>,
  'get_account_payments' : ActorMethod<[], GetAccountPayments>,
  'get_icrc1_token_canister_metadata' : ActorMethod<
    [],
    GetTokenCanisterMetadataResult
  >,
  'send_payment' : ActorMethod<
    [
      {
        'clientPaymentId' : string,
        'description' : [] | [string],
        'recipientAddress' : string,
        'amount' : bigint,
      },
    ],
    SendPayment
  >,
  'set_icrc1_token_canister' : ActorMethod<[string], Result>,
  'whoami' : ActorMethod<[], Principal>,
}
export type PaymentStatus = {
    'Failed' : { 'kind' : PaymentError, 'timestampNs' : Time }
  } |
  { 'Completed' : { 'txIndex' : TxIndex, 'timestampNs' : Time } } |
  { 'Pending' : {} };
export type Result = { 'ok' : null } |
  { 'err' : { 'msg' : string } };
export interface SendPayment { 'result' : Result, 'payment' : Payment }
export type Time = bigint;
export type Timestamp = bigint;
export type Tokens = bigint;
export type TransferError = {
    'GenericError' : { 'message' : string, 'error_code' : bigint }
  } |
  { 'TemporarilyUnavailable' : null } |
  { 'BadBurn' : { 'min_burn_amount' : Tokens } } |
  { 'Duplicate' : { 'duplicate_of' : TxIndex__1 } } |
  { 'BadFee' : { 'expected_fee' : Tokens } } |
  { 'CreatedInFuture' : { 'ledger_time' : Timestamp } } |
  { 'TooOld' : null } |
  { 'InsufficientFunds' : { 'balance' : Tokens } };
export type TxIndex = bigint;
export type TxIndex__1 = bigint;
export type Value = { 'Int' : bigint } |
  { 'Nat' : bigint } |
  { 'Blob' : Uint8Array | number[] } |
  { 'Text' : string };
export interface _SERVICE extends PaymentProcessor {}
