import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Account {
  'owner' : Principal,
  'subaccount' : [] | [Subaccount],
}
export type AssocList = [] | [[[Key, User], List]];
export interface Branch { 'left' : Trie, 'size' : bigint, 'right' : Trie }
export type Hash = number;
export interface Key { 'key' : UserId, 'hash' : Hash }
export interface Leaf { 'size' : bigint, 'keyvals' : AssocList }
export type List = [] | [[[Key, User], List]];
export type Result = { 'ok' : string } |
  { 'err' : string };
export type Subaccount = Uint8Array | number[];
export interface Transaction {
  'to' : Principal,
  'from' : Principal,
  'memo' : string,
  'created_at' : bigint,
  'amount' : bigint,
}
export type TransactionId = number;
export type Trie = { 'branch' : Branch } |
  { 'leaf' : Leaf } |
  { 'empty' : null };
export interface User {
  'id' : bigint,
  'phone_notifications' : boolean,
  'name' : string,
  'email_notifications' : boolean,
  'created_at' : bigint,
  'email' : string,
  'wallet' : Principal,
  'phone' : string,
}
export type UserId = number;
export interface _SERVICE {
  'create' : ActorMethod<[User], UserId>,
  'delete' : ActorMethod<[UserId], boolean>,
  'getAllUsers' : ActorMethod<[], Trie>,
  'getCanisterAddress' : ActorMethod<[], string>,
  'getCanisterBalance' : ActorMethod<[], string>,
  'getFundingAddress' : ActorMethod<[], string>,
  'getFundingBalance' : ActorMethod<[], string>,
  'getInvoice' : ActorMethod<[], Account>,
  'getTradingAddress' : ActorMethod<[], string>,
  'getTradingBalance' : ActorMethod<[], string>,
  'read' : ActorMethod<[UserId], [] | [User]>,
  'saveTransaction' : ActorMethod<[Transaction], TransactionId>,
  'transactionsLength' : ActorMethod<[], string>,
  'transferFromCanistertoSubAccount' : ActorMethod<[], Result>,
  'transferFromSubAccountToSubAccount' : ActorMethod<[string, bigint], Result>,
  'update' : ActorMethod<[UserId, User], boolean>,
  'userLength' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], Principal>,
}
