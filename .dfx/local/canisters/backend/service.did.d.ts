import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Account {
  'owner' : Principal,
  'subaccount' : [] | [Subaccount],
}
export interface Backend {
  'addemployer' : ActorMethod<[User], Principal>,
  'create' : ActorMethod<[User], UserId>,
  'delete' : ActorMethod<[UserId], boolean>,
  'getAddress' : ActorMethod<[], string>,
  'getCanisterAddress' : ActorMethod<[], string>,
  'getCanisterBalance' : ActorMethod<[], string>,
  'getFundingAddress' : ActorMethod<[], string>,
  'getFundingBalance' : ActorMethod<[], string>,
  'getInvoice' : ActorMethod<[], Account>,
  'getLogs' : ActorMethod<[], Array<string>>,
  'getTradingAddress' : ActorMethod<[], string>,
  'getTradingBalance' : ActorMethod<[], string>,
  'getUser' : ActorMethod<[Principal], [] | [User]>,
  'getUsers' : ActorMethod<[], Array<User>>,
  'read' : ActorMethod<[UserId], [] | [User]>,
  'register' : ActorMethod<
    [bigint, string, string, boolean, string, boolean, string, bigint],
    undefined
  >,
  'setCourierApiKey' : ActorMethod<[string], Response>,
  'transactionsLength' : ActorMethod<[], string>,
  'transferFromCanistertoSubAccount' : ActorMethod<[], Result>,
  'transferFromSubAccountToCanister' : ActorMethod<[bigint], Result>,
  'transferFromSubAccountToSubAccount' : ActorMethod<[string, bigint], Result>,
  'update' : ActorMethod<[UserId, User], boolean>,
  'userLength' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], Principal>,
}
export interface Response {
  'status' : number,
  'data' : [] | [string],
  'status_text' : string,
  'error_text' : [] | [string],
}
export type Result = { 'ok' : string } |
  { 'err' : string };
export type Subaccount = Uint8Array | number[];
export interface User {
  'id' : bigint,
  'phone_notifications' : boolean,
  'name' : string,
  'email_notifications' : boolean,
  'created_at' : bigint,
  'email' : string,
  'wallet' : string,
  'phone' : string,
}
export type UserId = number;
export interface _SERVICE extends Backend {}
