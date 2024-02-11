import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Account {
  'owner' : Principal,
  'subaccount' : [] | [Subaccount],
}
export type AccountIdentifier = { 'principal' : Principal } |
  { 'blob' : Uint8Array | number[] } |
  { 'text' : string };
export interface AccountIdentifierToBlobErr {
  'kind' : { 'InvalidAccountIdentifier' : null } |
    { 'Other' : null },
  'message' : [] | [string],
}
export type AccountIdentifierToBlobResult = {
    'ok' : AccountIdentifierToBlobSuccess
  } |
  { 'err' : AccountIdentifierToBlobErr };
export type AccountIdentifierToBlobSuccess = Uint8Array | number[];
export interface Backend {
  'accountIdentifierToBlob' : ActorMethod<
    [AccountIdentifier],
    AccountIdentifierToBlobResult
  >,
  'getAddress' : ActorMethod<[], string>,
  'getCanisterAddress' : ActorMethod<[], string>,
  'getCanisterBalance' : ActorMethod<[], string>,
  'getFundingAddress' : ActorMethod<[], string>,
  'getFundingBalance' : ActorMethod<[], string>,
  'getInvoice' : ActorMethod<[], Account>,
  'getLogs' : ActorMethod<[], Array<string>>,
  'getTradingAddress' : ActorMethod<[], string>,
  'getTradingBalance' : ActorMethod<[], string>,
  'getUser' : ActorMethod<[], Response>,
  'getUsersList' : ActorMethod<[], Array<[string, User]>>,
  'get_account_identifier' : ActorMethod<
    [GetAccountIdentifierArgs],
    GetAccountIdentifierResult
  >,
  'setCourierApiKey' : ActorMethod<[string], Response_2>,
  'transferFromCanistertoSubAccount' : ActorMethod<[], Result>,
  'transferFromSubAccountToCanister' : ActorMethod<[bigint], Result>,
  'transferFromSubAccountToSubAccount' : ActorMethod<
    [string, bigint],
    Response_1
  >,
  'updateUser' : ActorMethod<[User], Response>,
  'userExists' : ActorMethod<[], boolean>,
  'userLength' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], Principal>,
}
export interface GetAccountIdentifierArgs { 'principal' : Principal }
export interface GetAccountIdentifierErr { 'message' : [] | [string] }
export type GetAccountIdentifierResult = {
    'ok' : GetAccountIdentifierSuccess
  } |
  { 'err' : GetAccountIdentifierErr };
export interface GetAccountIdentifierSuccess {
  'accountIdentifier' : AccountIdentifier,
}
export interface Response {
  'status' : number,
  'data' : [] | [User],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_1 {
  'status' : number,
  'data' : [] | [Transaction],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_2 {
  'status' : number,
  'data' : [] | [string],
  'status_text' : string,
  'error_text' : [] | [string],
}
export type Result = { 'ok' : string } |
  { 'err' : string };
export type Subaccount = Uint8Array | number[];
export interface Transaction {
  'to' : string,
  'from' : string,
  'amount' : string,
}
export interface User {
  'email_address' : string,
  'phone_notifications' : boolean,
  'name' : string,
  'email_notifications' : boolean,
  'phone_number' : string,
}
export interface _SERVICE extends Backend {}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: ({ IDL }: { IDL: IDL }) => IDL.Type[];
