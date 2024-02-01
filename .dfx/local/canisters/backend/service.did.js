export const idlFactory = ({ IDL }) => {
  const User = IDL.Record({
    'id' : IDL.Nat,
    'phone_notifications' : IDL.Bool,
    'name' : IDL.Text,
    'email_notifications' : IDL.Bool,
    'created_at' : IDL.Int,
    'email' : IDL.Text,
    'wallet' : IDL.Text,
    'phone' : IDL.Text,
  });
  const UserId = IDL.Nat32;
  const Subaccount = IDL.Vec(IDL.Nat8);
  const Account = IDL.Record({
    'owner' : IDL.Principal,
    'subaccount' : IDL.Opt(Subaccount),
  });
  const Response = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(IDL.Text),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  const Backend = IDL.Service({
    'addemployer' : IDL.Func([User], [IDL.Principal], []),
    'create' : IDL.Func([User], [UserId], []),
    'delete' : IDL.Func([UserId], [IDL.Bool], []),
    'getAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterBalance' : IDL.Func([], [IDL.Text], []),
    'getFundingAddress' : IDL.Func([], [IDL.Text], []),
    'getFundingBalance' : IDL.Func([], [IDL.Text], []),
    'getInvoice' : IDL.Func([], [Account], []),
    'getLogs' : IDL.Func([], [IDL.Vec(IDL.Text)], ['query']),
    'getTradingAddress' : IDL.Func([], [IDL.Text], []),
    'getTradingBalance' : IDL.Func([], [IDL.Text], []),
    'getUser' : IDL.Func([IDL.Principal], [IDL.Opt(User)], ['query']),
    'getUsers' : IDL.Func([], [IDL.Vec(User)], ['query']),
    'read' : IDL.Func([UserId], [IDL.Opt(User)], ['query']),
    'register' : IDL.Func(
        [
          IDL.Nat,
          IDL.Text,
          IDL.Text,
          IDL.Bool,
          IDL.Text,
          IDL.Bool,
          IDL.Text,
          IDL.Int,
        ],
        [],
        [],
      ),
    'setCourierApiKey' : IDL.Func([IDL.Text], [Response], []),
    'transactionsLength' : IDL.Func([], [IDL.Text], ['query']),
    'transferFromCanistertoSubAccount' : IDL.Func([], [Result], []),
    'transferFromSubAccountToCanister' : IDL.Func([IDL.Nat], [Result], []),
    'transferFromSubAccountToSubAccount' : IDL.Func(
        [IDL.Text, IDL.Nat],
        [Result],
        [],
      ),
    'update' : IDL.Func([UserId, User], [IDL.Bool], []),
    'userLength' : IDL.Func([], [IDL.Text], ['query']),
    'whoami' : IDL.Func([], [IDL.Principal], []),
  });
  return Backend;
};
export const init = ({ IDL }) => { return []; };
