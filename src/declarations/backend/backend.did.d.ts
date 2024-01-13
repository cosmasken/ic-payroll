import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'getBalance' : ActorMethod<[], string>,
  'increment' : ActorMethod<[], undefined>,
  'whoami' : ActorMethod<[], Principal>,
}
