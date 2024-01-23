import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Account {
  'owner' : Principal,
  'subaccount' : [] | [Subaccount],
}
export type Result = { 'ok' : string } |
  { 'err' : string };
export type Subaccount = Uint8Array | number[];
export interface _SERVICE {
  'getCanisterAddress' : ActorMethod<[], string>,
  'getCanisterBalance' : ActorMethod<[], string>,
  'getFundingAddress' : ActorMethod<[], string>,
  'getFundingBalance' : ActorMethod<[], string>,
  'getInvoice' : ActorMethod<[], Account>,
  'getTradingAddress' : ActorMethod<[], string>,
  'getTradingBalance' : ActorMethod<[], string>,
  'transferToCanister' : ActorMethod<[], Result>,
  'transferToUserFromCanister' : ActorMethod<[], Result>,
  'whoami' : ActorMethod<[], Principal>,
}
