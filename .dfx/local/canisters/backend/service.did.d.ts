import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Employee {
  'salary' : bigint,
  'name' : string,
  'role' : string,
  'email' : string,
  'address' : string,
  'wallet' : string,
  'phone' : string,
  'department' : string,
}
export type EmployeeId = number;
export type Result = { 'ok' : string } |
  { 'err' : string };
export interface _SERVICE {
  'create' : ActorMethod<[Employee], EmployeeId>,
  'delete' : ActorMethod<[EmployeeId], boolean>,
  'getBalance' : ActorMethod<[], string>,
  'getNumberOfFreelancers' : ActorMethod<[], number>,
  'makeTransfer' : ActorMethod<[string, bigint], Result>,
  'read' : ActorMethod<[EmployeeId], [] | [Employee]>,
  'update' : ActorMethod<[EmployeeId, Employee], boolean>,
  'whoami' : ActorMethod<[], Principal>,
}
