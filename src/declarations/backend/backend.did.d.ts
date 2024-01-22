import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'getBalance' : ActorMethod<[], bigint>,
  'getDepositAddress' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], Principal>,
}
