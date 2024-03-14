import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Account {
  'owner' : Principal,
  'subaccount' : [] | [Subaccount],
}
export type AccountIdentifier = { 'principal' : Principal } |
  { 'blob' : Uint8Array | number[] } |
  { 'text' : string };
export interface AccountIdentifierToBlobErr {
  'kind' : { 'InvalidAccountIdentifier' : null } |
    { 'Other' : null },
  'message' : [] | [string],
}
export type AccountIdentifierToBlobResult = {
    'ok' : AccountIdentifierToBlobSuccess
  } |
  { 'err' : AccountIdentifierToBlobErr };
export type AccountIdentifierToBlobSuccess = Uint8Array | number[];
export interface Backend {
  'accountIdentifierToBlob' : ActorMethod<
    [AccountIdentifier],
    AccountIdentifierToBlobResult
  >,
  'checkPayroll' : ActorMethod<[], boolean>,
  'create_employee' : ActorMethod<[CreateEmployeeArgs], Response_4>,
  'emailExists' : ActorMethod<[string], boolean>,
  'getAddress' : ActorMethod<[], string>,
  'getCanisterAddress' : ActorMethod<[], string>,
  'getCanisterBalance' : ActorMethod<[], string>,
  'getEmployeeByPrincipal' : ActorMethod<[Principal], Response_4>,
  'getFundingAddress' : ActorMethod<[], string>,
  'getFundingBalance' : ActorMethod<[], string>,
  'getInvoice' : ActorMethod<[], Account>,
  'getLogs' : ActorMethod<[], Array<string>>,
  'getMyContacts' : ActorMethod<[], Array<Employee>>,
  'getMyContactsLength' : ActorMethod<[], string>,
  'getMyTransactionLength' : ActorMethod<[], string>,
  'getNotifications' : ActorMethod<[], Array<Notification__1>>,
  'getTradingAddress' : ActorMethod<[], string>,
  'getTradingBalance' : ActorMethod<[], string>,
  'getTransactionLength' : ActorMethod<[], string>,
  'getUnreadNotifications' : ActorMethod<[], Array<Notification__1>>,
  'getUnreadNotificationsLength' : ActorMethod<[], string>,
  'getUser' : ActorMethod<[], Response>,
  'getUserByPrincipal' : ActorMethod<[Principal], Response>,
  'getUsersList' : ActorMethod<[], Array<[string, User]>>,
  'get_account_identifier' : ActorMethod<
    [GetAccountIdentifierArgs],
    GetAccountIdentifierResult
  >,
  'get_transaction' : ActorMethod<[GetTransactionArgs], GetTransactionResult>,
  'get_transactions' : ActorMethod<[], Array<Transaction>>,
  'isRegistered' : ActorMethod<[], boolean>,
  'runpayroll' : ActorMethod<[Array<PayrollType__1>], Response_3>,
  'save_notification' : ActorMethod<
    [CreateNotificationArgs],
    CreateNotificationResult
  >,
  'save_payroll' : ActorMethod<[SchedulePaymentsArgs], SchedulePaymentsResult>,
  'save_transaction' : ActorMethod<
    [CreateTransactionArgs],
    CreateTransactionResult
  >,
  'sendToOwner' : ActorMethod<[bigint, string], Result>,
  'send_notifications' : ActorMethod<
    [string, string, string, string, string],
    undefined
  >,
  'setCourierApiKey' : ActorMethod<[string], Response_2>,
  'transferFromCanistertoSubAccount' : ActorMethod<[], Result>,
  'transferFromSubAccountToSubAccount' : ActorMethod<
    [string, bigint],
    Response_1
  >,
  'transform' : ActorMethod<[TransformArgs], CanisterHttpResponsePayload>,
  'updateUser' : ActorMethod<[User], Response>,
  'userLength' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], Principal>,
}
export interface CanisterHttpResponsePayload {
  'status' : bigint,
  'body' : Uint8Array | number[],
  'headers' : Array<HttpHeader>,
}
export interface CreateEmployeeArgs { 'wallet' : string }
export interface CreateNotificationArgs {
  'isRead' : boolean,
  'sender' : string,
  'amount' : bigint,
  'receiver' : string,
}
export interface CreateNotificationErr {
  'kind' : { 'InvalidNotification' : null } |
    { 'Other' : null },
  'message' : [] | [string],
}
export type CreateNotificationResult = { 'ok' : CreateNotificationSuccess } |
  { 'err' : CreateNotificationErr };
export interface CreateNotificationSuccess { 'notification' : Notification }
export interface CreateTransactionArgs {
  'creator' : Principal,
  'destination' : Principal,
  'amount' : bigint,
  'successful' : boolean,
}
export interface CreateTransactionErr {
  'kind' : { 'InvalidDetails' : null } |
    { 'InvalidAmount' : null } |
    { 'InvalidDestination' : null } |
    { 'MaxTransactionsReached' : null } |
    { 'InsufficientBalance' : null } |
    { 'InvalidSender' : null } |
    { 'Other' : null },
  'message' : [] | [string],
}
export type CreateTransactionResult = { 'ok' : CreateTransactionSuccess } |
  { 'err' : CreateTransactionErr };
export interface CreateTransactionSuccess { 'transaction' : Transaction__1 }
export interface Employee {
  'id' : bigint,
  'email_address' : string,
  'creator' : Principal,
  'modified_at' : bigint,
  'name' : string,
  'created_at' : bigint,
  'wallet' : string,
  'phone_number' : string,
}
export interface GetAccountIdentifierArgs { 'principal' : Principal }
export interface GetAccountIdentifierErr { 'message' : [] | [string] }
export type GetAccountIdentifierResult = {
    'ok' : GetAccountIdentifierSuccess
  } |
  { 'err' : GetAccountIdentifierErr };
export interface GetAccountIdentifierSuccess {
  'accountIdentifier' : AccountIdentifier,
}
export interface GetTransactionArgs { 'id' : bigint }
export interface GetTransactionErr {
  'kind' : { 'NotFound' : null } |
    { 'NotAuthorized' : null } |
    { 'Other' : null } |
    { 'InvalidTransactionId' : null },
  'message' : [] | [string],
}
export type GetTransactionResult = { 'ok' : GetTransactionSuccess } |
  { 'err' : GetTransactionErr };
export interface GetTransactionSuccess { 'transaction' : Transaction__1 }
export interface HttpHeader { 'value' : string, 'name' : string }
export interface HttpResponsePayload {
  'status' : bigint,
  'body' : Uint8Array | number[],
  'headers' : Array<HttpHeader>,
}
export interface Notification {
  'id' : bigint,
  'isRead' : boolean,
  'sender' : string,
  'amount' : bigint,
  'receiver' : string,
}
export interface Notification__1 {
  'id' : bigint,
  'isRead' : boolean,
  'sender' : string,
  'amount' : bigint,
  'receiver' : string,
}
export interface PayrollType {
  'id' : bigint,
  'creator' : string,
  'destination' : string,
  'created_at' : bigint,
  'amount' : bigint,
  'successful' : boolean,
}
export interface PayrollType__1 {
  'id' : bigint,
  'creator' : string,
  'destination' : string,
  'created_at' : bigint,
  'amount' : bigint,
  'successful' : boolean,
}
export interface Response {
  'status' : number,
  'data' : [] | [User],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_1 {
  'status' : number,
  'data' : [] | [Transaction],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_2 {
  'status' : number,
  'data' : [] | [string],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_3 {
  'status' : number,
  'data' : [] | [Array<PayrollType__1>],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_4 {
  'status' : number,
  'data' : [] | [Employee],
  'status_text' : string,
  'error_text' : [] | [string],
}
export type Result = { 'ok' : string } |
  { 'err' : string };
export interface SchedulePaymentsArgs {
  'status' : { 'Paid' : null } |
    { 'Rejected' : null } |
    { 'Unpaid' : null } |
    { 'Accepted' : null },
  'created_at' : bigint,
  'receivers' : Array<PayrollType>,
  'payment_at' : bigint,
}
export interface SchedulePaymentsErr {
  'kind' : { 'InvalidDetails' : null } |
    { 'InvalidAmount' : null } |
    { 'InvalidDestination' : null } |
    { 'MaxTransactionsReached' : null } |
    { 'InsufficientBalance' : null } |
    { 'InvalidSender' : null } |
    { 'Other' : null },
  'message' : [] | [string],
}
export type SchedulePaymentsResult = { 'ok' : SchedulePaymentsSuccess } |
  { 'err' : SchedulePaymentsErr };
export interface SchedulePaymentsSuccess { 'receivers' : Array<PayrollType> }
export type Subaccount = Uint8Array | number[];
export interface Transaction {
  'id' : bigint,
  'creator' : Principal,
  'destination' : Principal,
  'created_at' : bigint,
  'amount' : bigint,
  'successful' : boolean,
}
export interface Transaction__1 {
  'id' : bigint,
  'creator' : Principal,
  'destination' : Principal,
  'created_at' : bigint,
  'amount' : bigint,
  'successful' : boolean,
}
export interface TransformArgs {
  'context' : Uint8Array | number[],
  'response' : HttpResponsePayload,
}
export interface User {
  'email_address' : string,
  'phone_notifications' : boolean,
  'name' : string,
  'email_notifications' : boolean,
  'phone_number' : string,
}
export interface _SERVICE extends Backend {}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: ({ IDL }: { IDL: IDL }) => IDL.Type[];
