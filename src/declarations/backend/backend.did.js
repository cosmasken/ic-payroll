export const idlFactory = ({ IDL }) => {
  const List = IDL.Rec();
  const Trie = IDL.Rec();
  const User = IDL.Record({
    'id' : IDL.Nat,
    'phone_notifications' : IDL.Bool,
    'name' : IDL.Text,
    'email_notifications' : IDL.Bool,
    'created_at' : IDL.Int,
    'email' : IDL.Text,
    'wallet' : IDL.Principal,
    'phone' : IDL.Text,
  });
  const UserId = IDL.Nat32;
  const Branch = IDL.Record({
    'left' : Trie,
    'size' : IDL.Nat,
    'right' : Trie,
  });
  const Hash = IDL.Nat32;
  const Key = IDL.Record({ 'key' : UserId, 'hash' : Hash });
  List.fill(IDL.Opt(IDL.Tuple(IDL.Tuple(Key, User), List)));
  const AssocList = IDL.Opt(IDL.Tuple(IDL.Tuple(Key, User), List));
  const Leaf = IDL.Record({ 'size' : IDL.Nat, 'keyvals' : AssocList });
  Trie.fill(
    IDL.Variant({ 'branch' : Branch, 'leaf' : Leaf, 'empty' : IDL.Null })
  );
  const Subaccount = IDL.Vec(IDL.Nat8);
  const Account = IDL.Record({
    'owner' : IDL.Principal,
    'subaccount' : IDL.Opt(Subaccount),
  });
  const Transaction = IDL.Record({
    'to' : IDL.Principal,
    'from' : IDL.Principal,
    'memo' : IDL.Text,
    'created_at' : IDL.Int,
    'amount' : IDL.Nat,
  });
  const TransactionId = IDL.Nat32;
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({
    'create' : IDL.Func([User], [UserId], []),
    'delete' : IDL.Func([UserId], [IDL.Bool], []),
    'getAllUsers' : IDL.Func([], [Trie], ['query']),
    'getCanisterAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterBalance' : IDL.Func([], [IDL.Text], []),
    'getFundingAddress' : IDL.Func([], [IDL.Text], []),
    'getFundingBalance' : IDL.Func([], [IDL.Text], []),
    'getInvoice' : IDL.Func([], [Account], []),
    'getTradingAddress' : IDL.Func([], [IDL.Text], []),
    'getTradingBalance' : IDL.Func([], [IDL.Text], []),
    'read' : IDL.Func([UserId], [IDL.Opt(User)], ['query']),
    'saveTransaction' : IDL.Func([Transaction], [TransactionId], []),
    'transactionsLength' : IDL.Func([], [IDL.Text], ['query']),
    'transferFromCanistertoSubAccount' : IDL.Func([], [Result], []),
    'transferFromSubAccountToSubAccount' : IDL.Func(
        [IDL.Text, IDL.Nat],
        [Result],
        [],
      ),
    'update' : IDL.Func([UserId, User], [IDL.Bool], []),
    'userLength' : IDL.Func([], [IDL.Text], ['query']),
    'whoami' : IDL.Func([], [IDL.Principal], []),
  });
};
export const init = ({ IDL }) => { return []; };
