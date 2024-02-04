import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Account {
  'owner' : Principal,
  'subaccount' : [] | [Subaccount],
}
export interface Backend {
  'deleteUser' : ActorMethod<[string], Response_1>,
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
  'setCourierApiKey' : ActorMethod<[string], Response_1>,
  'transactionsLength' : ActorMethod<[], string>,
  'transferFromCanistertoSubAccount' : ActorMethod<[], Result>,
  'transferFromSubAccountToCanister' : ActorMethod<[bigint], Result>,
  'transferFromSubAccountToSubAccount' : ActorMethod<[string, bigint], Result>,
  'updateUser' : ActorMethod<[User], Response>,
  'userLength' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], Principal>,
}
export interface Response {
  'status' : number,
  'data' : [] | [User],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_1 {
  'status' : number,
  'data' : [] | [string],
  'status_text' : string,
  'error_text' : [] | [string],
}
export type Result = { 'ok' : string } |
  { 'err' : string };
export type Subaccount = Uint8Array | number[];
export interface User {
  'phone_notifications' : boolean,
  'name' : string,
  'email_notifications' : boolean,
  'created_at' : bigint,
  'email' : string,
  'wallet' : string,
  'phone' : string,
}
export interface _SERVICE extends Backend {}
