import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Backend {
  'cancelRecurringTimer' : ActorMethod<[bigint], undefined>,
  'checkPayroll' : ActorMethod<[], undefined>,
  'createAccount' : ActorMethod<[User], Response_4>,
  'create_department' : ActorMethod<[CreateDepartmentArgs], Response_9>,
  'create_designation' : ActorMethod<[CreateDesignationArgs], Response_8>,
  'create_emp' : ActorMethod<[CreateEmpArgs], Response_5>,
  'create_organization' : ActorMethod<[CreateOrganizationArgs], Response_7>,
  'emailExists' : ActorMethod<[string], boolean>,
  'generateCode' : ActorMethod<[string], string>,
  'generatePayslip' : ActorMethod<[bigint], Response_6>,
  'generateUUID' : ActorMethod<[], string>,
  'getCanisterAddress' : ActorMethod<[], string>,
  'getCanisterBalance' : ActorMethod<[], string>,
  'getDepartments' : ActorMethod<[], Array<Department>>,
  'getDepartmentsLength' : ActorMethod<[], string>,
  'getDesignations' : ActorMethod<[], Array<Designation>>,
  'getDesignationsLength' : ActorMethod<[], string>,
  'getEmpByPrincipal' : ActorMethod<[Principal], Response_5>,
  'getEmployees' : ActorMethod<[], Array<Emp>>,
  'getFundingAddress' : ActorMethod<[], string>,
  'getFundingBalance' : ActorMethod<[], string>,
  'getLogs' : ActorMethod<[], Array<string>>,
  'getMyTransactionLength' : ActorMethod<[], string>,
  'getNotifications' : ActorMethod<[], Array<Notification__1>>,
  'getOrganizations' : ActorMethod<[], Array<Organization>>,
  'getOrganizationsLength' : ActorMethod<[], string>,
  'getTestTokens' : ActorMethod<[], Result>,
  'getTradingAddress' : ActorMethod<[], string>,
  'getTradingBalance' : ActorMethod<[], string>,
  'getTransactionLength' : ActorMethod<[], string>,
  'getUnreadNotifications' : ActorMethod<[], Array<Notification__1>>,
  'getUnreadNotificationsLength' : ActorMethod<[], string>,
  'getUser' : ActorMethod<[], Response_4>,
  'getUserByPrincipal' : ActorMethod<[Principal], Response_4>,
  'getUserPayslip' : ActorMethod<[string], Response_3>,
  'getUsersList' : ActorMethod<[], Array<[string, User]>>,
  'get_transaction' : ActorMethod<[GetTransactionArgs], GetTransactionResult>,
  'get_transactions' : ActorMethod<[], Array<Transaction>>,
  'isReg' : ActorMethod<[], boolean>,
  'isRegistered' : ActorMethod<[], boolean>,
  'runpayroll' : ActorMethod<[Array<PayrollType__1>], Response_2>,
  'save_notification' : ActorMethod<
    [CreateNotificationArgs],
    CreateNotificationResult
  >,
  'save_payroll' : ActorMethod<[SchedulePaymentsArgs], SchedulePaymentsResult>,
  'save_transaction' : ActorMethod<
    [CreateTransactionArgs],
    CreateTransactionResult
  >,
  'schedulePayment' : ActorMethod<[bigint], bigint>,
  'sendToOwner' : ActorMethod<[bigint, string], Response>,
  'send_notifications' : ActorMethod<
    [string, string, string, string, string],
    undefined
  >,
  'setCourierApiKey' : ActorMethod<[string], Response_1>,
  'setRecurringTimer' : ActorMethod<[bigint], bigint>,
  'transferFromCanistertoSubAccount' : ActorMethod<[], Result>,
  'transferFromSubAccountToSubAccount' : ActorMethod<
    [string, bigint],
    Response
  >,
  'transform' : ActorMethod<[TransformArgs], CanisterHttpResponsePayload>,
  'userLength' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], Principal>,
}
export interface CanisterHttpResponsePayload {
  'status' : bigint,
  'body' : Uint8Array | number[],
  'headers' : Array<HttpHeader>,
}
export interface CreateDepartmentArgs { 'name' : string }
export interface CreateDesignationArgs { 'name' : string }
export interface CreateEmpArgs {
  'disability' : boolean,
  'email_address' : string,
  'username' : string,
  'gross_salary' : bigint,
  'designation' : string,
  'role' : string,
  'employee_type' : string,
  'gender' : string,
  'job_group' : string,
  'first_name' : string,
  'last_name' : string,
  'identity' : string,
  'organization' : string,
  'phone_number' : string,
  'department' : string,
}
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
export interface CreateOrganizationArgs { 'name' : string }
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
export interface Department {
  'creator' : Principal,
  'code' : string,
  'name' : string,
}
export interface Designation {
  'creator' : Principal,
  'code' : string,
  'name' : string,
}
export interface Emp {
  'disability' : boolean,
  'email_address' : string,
  'creator' : Principal,
  'username' : string,
  'gross_salary' : bigint,
  'designation' : string,
  'role' : string,
  'employee_type' : string,
  'gender' : string,
  'job_group' : string,
  'first_name' : string,
  'last_name' : string,
  'identity' : string,
  'organization' : string,
  'phone_number' : string,
  'department' : string,
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
export interface Organization {
  'creator' : Principal,
  'code' : string,
  'name' : string,
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
export interface Payslip {
  'nhif_deductions' : bigint,
  'nssf_deductions' : bigint,
  'gross_salary' : bigint,
  'paye' : bigint,
  'net_salary' : bigint,
  'total_tax' : bigint,
  'taxable_income' : bigint,
  'personal_relief' : bigint,
  'other_deductions' : bigint,
  'housing' : bigint,
}
export interface PayslipData {
  'nhif_deductions' : bigint,
  'nssf_deductions' : bigint,
  'gross_salary' : bigint,
  'name' : string,
  'designation' : string,
  'paye' : bigint,
  'net_salary' : bigint,
  'total_tax' : bigint,
  'taxable_income' : bigint,
  'personal_relief' : bigint,
  'organization' : string,
  'department' : string,
  'other_deductions' : bigint,
  'housing' : bigint,
}
export interface Response {
  'status' : number,
  'data' : [] | [Transaction],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_1 {
  'status' : number,
  'data' : [] | [string],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_2 {
  'status' : number,
  'data' : [] | [Array<PayrollType__1>],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_3 {
  'status' : number,
  'data' : [] | [PayslipData],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_4 {
  'status' : number,
  'data' : [] | [User],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_5 {
  'status' : number,
  'data' : [] | [Emp],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_6 {
  'status' : number,
  'data' : [] | [Payslip],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_7 {
  'status' : number,
  'data' : [] | [Organization],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_8 {
  'status' : number,
  'data' : [] | [Designation],
  'status_text' : string,
  'error_text' : [] | [string],
}
export interface Response_9 {
  'status' : number,
  'data' : [] | [Department],
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
  'email_notifications' : boolean,
  'is_verified' : boolean,
  'first_name' : string,
  'last_name' : string,
  'phone_number' : string,
}
export interface _SERVICE extends Backend {}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: ({ IDL }: { IDL: IDL }) => IDL.Type[];
