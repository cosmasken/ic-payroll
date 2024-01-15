import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export type Result = { 'ok' : string } |
  { 'err' : string };
export interface _SERVICE {
  'getBalance' : ActorMethod<[], string>,
  'increment' : ActorMethod<[], undefined>,
  'makeTransfer' : ActorMethod<[string, bigint], Result>,
  'whoami' : ActorMethod<[], Principal>,
}
