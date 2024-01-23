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
  'transferFromAccToCanister' : ActorMethod<[], Result>,
  'transferFromCanistertoSubAccount' : ActorMethod<[], Result>,
  'transferFromSubAccountToSubAccount' : ActorMethod<[string, bigint], Result>,
  'whoami' : ActorMethod<[], Principal>,
}
