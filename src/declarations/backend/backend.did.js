export const idlFactory = ({ IDL }) => {
  const Response_1 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(IDL.Text),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const Subaccount = IDL.Vec(IDL.Nat8);
  const Account = IDL.Record({
    'owner' : IDL.Principal,
    'subaccount' : IDL.Opt(Subaccount),
  });
  const User = IDL.Record({
    'phone_notifications' : IDL.Bool,
    'name' : IDL.Text,
    'email_notifications' : IDL.Bool,
    'created_at' : IDL.Int,
    'email' : IDL.Text,
    'wallet' : IDL.Text,
    'phone' : IDL.Text,
  });
  const Response = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(User),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  const Backend = IDL.Service({
    'deleteUser' : IDL.Func([IDL.Text], [Response_1], []),
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
    'setCourierApiKey' : IDL.Func([IDL.Text], [Response_1], []),
    'transactionsLength' : IDL.Func([], [IDL.Text], ['query']),
    'transferFromCanistertoSubAccount' : IDL.Func([], [Result], []),
    'transferFromSubAccountToCanister' : IDL.Func([IDL.Nat], [Result], []),
    'transferFromSubAccountToSubAccount' : IDL.Func(
        [IDL.Text, IDL.Nat],
        [Result],
        [],
      ),
    'updateUser' : IDL.Func([User], [Response], []),
    'userLength' : IDL.Func([], [IDL.Text], ['query']),
    'whoami' : IDL.Func([], [IDL.Principal], []),
  });
  return Backend;
};
export const init = ({ IDL }) => { return [IDL.Nat]; };
