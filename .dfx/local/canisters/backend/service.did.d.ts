import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'getCanister' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], Principal>,
}
