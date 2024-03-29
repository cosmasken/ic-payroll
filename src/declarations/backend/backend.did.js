export const idlFactory = ({ IDL }) => {
  const AccountIdentifier = IDL.Variant({
    'principal' : IDL.Principal,
    'blob' : IDL.Vec(IDL.Nat8),
    'text' : IDL.Text,
  });
  const AccountIdentifierToBlobSuccess = IDL.Vec(IDL.Nat8);
  const AccountIdentifierToBlobErr = IDL.Record({
    'kind' : IDL.Variant({
      'InvalidAccountIdentifier' : IDL.Null,
      'Other' : IDL.Null,
    }),
    'message' : IDL.Opt(IDL.Text),
  });
  const AccountIdentifierToBlobResult = IDL.Variant({
    'ok' : AccountIdentifierToBlobSuccess,
    'err' : AccountIdentifierToBlobErr,
  });
  const CreateEmployeeArgs = IDL.Record({ 'wallet' : IDL.Text });
  const Employee = IDL.Record({
    'id' : IDL.Nat,
    'email_address' : IDL.Text,
    'creator' : IDL.Principal,
    'modified_at' : IDL.Int,
    'name' : IDL.Text,
    'created_at' : IDL.Int,
    'wallet' : IDL.Text,
    'phone_number' : IDL.Text,
  });
  const Response_4 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Employee),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const Subaccount = IDL.Vec(IDL.Nat8);
  const Account = IDL.Record({
    'owner' : IDL.Principal,
    'subaccount' : IDL.Opt(Subaccount),
  });
  const Notification__1 = IDL.Record({
    'id' : IDL.Nat,
    'isRead' : IDL.Bool,
    'sender' : IDL.Text,
    'amount' : IDL.Nat,
    'receiver' : IDL.Text,
  });
  const User = IDL.Record({
    'email_address' : IDL.Text,
    'phone_notifications' : IDL.Bool,
    'name' : IDL.Text,
    'email_notifications' : IDL.Bool,
    'phone_number' : IDL.Text,
  });
  const Response = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(User),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const GetAccountIdentifierArgs = IDL.Record({ 'principal' : IDL.Principal });
  const GetAccountIdentifierSuccess = IDL.Record({
    'accountIdentifier' : AccountIdentifier,
  });
  const GetAccountIdentifierErr = IDL.Record({ 'message' : IDL.Opt(IDL.Text) });
  const GetAccountIdentifierResult = IDL.Variant({
    'ok' : GetAccountIdentifierSuccess,
    'err' : GetAccountIdentifierErr,
  });
  const GetTransactionArgs = IDL.Record({ 'id' : IDL.Nat });
  const Transaction__1 = IDL.Record({
    'id' : IDL.Nat,
    'creator' : IDL.Principal,
    'destination' : IDL.Principal,
    'created_at' : IDL.Int,
    'amount' : IDL.Nat,
    'successful' : IDL.Bool,
  });
  const GetTransactionSuccess = IDL.Record({ 'transaction' : Transaction__1 });
  const GetTransactionErr = IDL.Record({
    'kind' : IDL.Variant({
      'NotFound' : IDL.Null,
      'NotAuthorized' : IDL.Null,
      'Other' : IDL.Null,
      'InvalidTransactionId' : IDL.Null,
    }),
    'message' : IDL.Opt(IDL.Text),
  });
  const GetTransactionResult = IDL.Variant({
    'ok' : GetTransactionSuccess,
    'err' : GetTransactionErr,
  });
  const Transaction = IDL.Record({
    'id' : IDL.Nat,
    'creator' : IDL.Principal,
    'destination' : IDL.Principal,
    'created_at' : IDL.Int,
    'amount' : IDL.Nat,
    'successful' : IDL.Bool,
  });
  const PayrollType = IDL.Record({
    'id' : IDL.Nat,
    'creator' : IDL.Text,
    'destination' : IDL.Text,
    'created_at' : IDL.Int,
    'amount' : IDL.Nat,
    'successful' : IDL.Bool,
  });
  const Response_3 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(IDL.Vec(PayrollType)),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const CreateNotificationArgs = IDL.Record({
    'isRead' : IDL.Bool,
    'sender' : IDL.Text,
    'amount' : IDL.Nat,
    'receiver' : IDL.Text,
  });
  const Notification = IDL.Record({
    'id' : IDL.Nat,
    'isRead' : IDL.Bool,
    'sender' : IDL.Text,
    'amount' : IDL.Nat,
    'receiver' : IDL.Text,
  });
  const CreateNotificationSuccess = IDL.Record({
    'notification' : Notification,
  });
  const CreateNotificationErr = IDL.Record({
    'kind' : IDL.Variant({
      'InvalidNotification' : IDL.Null,
      'Other' : IDL.Null,
    }),
    'message' : IDL.Opt(IDL.Text),
  });
  const CreateNotificationResult = IDL.Variant({
    'ok' : CreateNotificationSuccess,
    'err' : CreateNotificationErr,
  });
  const CreateTransactionArgs = IDL.Record({
    'creator' : IDL.Principal,
    'destination' : IDL.Principal,
    'amount' : IDL.Nat,
    'successful' : IDL.Bool,
  });
  const CreateTransactionSuccess = IDL.Record({
    'transaction' : Transaction__1,
  });
  const CreateTransactionErr = IDL.Record({
    'kind' : IDL.Variant({
      'InvalidDetails' : IDL.Null,
      'InvalidAmount' : IDL.Null,
      'InvalidDestination' : IDL.Null,
      'MaxTransactionsReached' : IDL.Null,
      'InsufficientBalance' : IDL.Null,
      'InvalidSender' : IDL.Null,
      'Other' : IDL.Null,
    }),
    'message' : IDL.Opt(IDL.Text),
  });
  const CreateTransactionResult = IDL.Variant({
    'ok' : CreateTransactionSuccess,
    'err' : CreateTransactionErr,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  const Response_2 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(IDL.Text),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const Response_1 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Transaction),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const HttpHeader = IDL.Record({ 'value' : IDL.Text, 'name' : IDL.Text });
  const HttpResponsePayload = IDL.Record({
    'status' : IDL.Nat,
    'body' : IDL.Vec(IDL.Nat8),
    'headers' : IDL.Vec(HttpHeader),
  });
  const TransformArgs = IDL.Record({
    'context' : IDL.Vec(IDL.Nat8),
    'response' : HttpResponsePayload,
  });
  const CanisterHttpResponsePayload = IDL.Record({
    'status' : IDL.Nat,
    'body' : IDL.Vec(IDL.Nat8),
    'headers' : IDL.Vec(HttpHeader),
  });
  const Backend = IDL.Service({
    'accountIdentifierToBlob' : IDL.Func(
        [AccountIdentifier],
        [AccountIdentifierToBlobResult],
        [],
      ),
    'create_employee' : IDL.Func([CreateEmployeeArgs], [Response_4], []),
    'emailExists' : IDL.Func([IDL.Text], [IDL.Bool], ['query']),
    'getAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterBalance' : IDL.Func([], [IDL.Text], []),
    'getEmployeeByPrincipal' : IDL.Func([IDL.Principal], [Response_4], []),
    'getFundingAddress' : IDL.Func([], [IDL.Text], []),
    'getFundingBalance' : IDL.Func([], [IDL.Text], []),
    'getInvoice' : IDL.Func([], [Account], []),
    'getLogs' : IDL.Func([], [IDL.Vec(IDL.Text)], ['query']),
    'getMyContacts' : IDL.Func([], [IDL.Vec(Employee)], []),
    'getMyContactsLength' : IDL.Func([], [IDL.Text], []),
    'getMyTransactionLength' : IDL.Func([], [IDL.Text], []),
    'getNotifications' : IDL.Func([], [IDL.Vec(Notification__1)], []),
    'getTradingAddress' : IDL.Func([], [IDL.Text], []),
    'getTradingBalance' : IDL.Func([], [IDL.Text], []),
    'getTransactionLength' : IDL.Func([], [IDL.Text], ['query']),
    'getUnreadNotifications' : IDL.Func([], [IDL.Vec(Notification__1)], []),
    'getUnreadNotificationsLength' : IDL.Func([], [IDL.Text], []),
    'getUser' : IDL.Func([], [Response], ['query']),
    'getUserByPrincipal' : IDL.Func([IDL.Principal], [Response], ['query']),
    'getUsersList' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Text, User))],
        ['query'],
      ),
    'get_account_identifier' : IDL.Func(
        [GetAccountIdentifierArgs],
        [GetAccountIdentifierResult],
        ['query'],
      ),
    'get_transaction' : IDL.Func(
        [GetTransactionArgs],
        [GetTransactionResult],
        ['query'],
      ),
    'get_transactions' : IDL.Func([], [IDL.Vec(Transaction)], ['query']),
    'isRegistered' : IDL.Func([], [IDL.Bool], ['query']),
    'runpayroll' : IDL.Func([IDL.Vec(PayrollType)], [Response_3], []),
    'save_notification' : IDL.Func(
        [CreateNotificationArgs],
        [CreateNotificationResult],
        [],
      ),
    'save_transaction' : IDL.Func(
        [CreateTransactionArgs],
        [CreateTransactionResult],
        [],
      ),
    'sendToOwner' : IDL.Func([IDL.Nat, IDL.Text], [Result], []),
    'send_notifications' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Text, IDL.Text, IDL.Text],
        [],
        [],
      ),
    'setCourierApiKey' : IDL.Func([IDL.Text], [Response_2], []),
    'transferFromCanistertoSubAccount' : IDL.Func([], [Result], []),
    'transferFromSubAccountToSubAccount' : IDL.Func(
        [IDL.Text, IDL.Nat],
        [Response_1],
        [],
      ),
    'transform' : IDL.Func(
        [TransformArgs],
        [CanisterHttpResponsePayload],
        ['query'],
      ),
    'updateUser' : IDL.Func([User], [Response], []),
    'userLength' : IDL.Func([], [IDL.Text], ['query']),
    'whoami' : IDL.Func([], [IDL.Principal], []),
  });
  return Backend;
};
export const init = ({ IDL }) => { return [IDL.Nat]; };
