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
  const Subaccount = IDL.Vec(IDL.Nat8);
  const Account = IDL.Record({
    'owner' : IDL.Principal,
    'subaccount' : IDL.Opt(Subaccount),
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
    'amount' : IDL.Nat,
    'successful' : IDL.Bool,
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
  const Response_2 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(IDL.Text),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  const Response_1 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Transaction),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const Backend = IDL.Service({
    'accountIdentifierToBlob' : IDL.Func(
        [AccountIdentifier],
        [AccountIdentifierToBlobResult],
        [],
      ),
    'getAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterBalance' : IDL.Func([], [IDL.Text], []),
    'getFundingAddress' : IDL.Func([], [IDL.Text], []),
    'getFundingBalance' : IDL.Func([], [IDL.Text], []),
    'getInvoice' : IDL.Func([], [Account], []),
    'getLogs' : IDL.Func([], [IDL.Vec(IDL.Text)], ['query']),
    'getTradingAddress' : IDL.Func([], [IDL.Text], []),
    'getTradingBalance' : IDL.Func([], [IDL.Text], []),
    'getUser' : IDL.Func([], [Response], ['query']),
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
    'save_transaction' : IDL.Func(
        [CreateTransactionArgs],
        [CreateTransactionResult],
        [],
      ),
    'setCourierApiKey' : IDL.Func([IDL.Text], [Response_2], []),
    'transferFromCanistertoSubAccount' : IDL.Func([], [Result], []),
    'transferFromSubAccountToCanister' : IDL.Func([IDL.Nat], [Result], []),
    'transferFromSubAccountToSubAccount' : IDL.Func(
        [IDL.Text, IDL.Nat],
        [Response_1],
        [],
      ),
    'updateUser' : IDL.Func([User], [Response], []),
    'userExists' : IDL.Func([], [IDL.Bool], ['query']),
    'userLength' : IDL.Func([], [IDL.Text], ['query']),
    'whoami' : IDL.Func([], [IDL.Principal], []),
  });
  return Backend;
};
export const init = ({ IDL }) => { return []; };
