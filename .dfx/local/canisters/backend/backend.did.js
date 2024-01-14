export const idlFactory = ({ IDL }) => {
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({
    'getBalance' : IDL.Func([], [IDL.Text], []),
    'increment' : IDL.Func([], [], []),
    'makeTransfer' : IDL.Func([IDL.Text, IDL.Nat], [Result], []),
    'whoami' : IDL.Func([], [IDL.Principal], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
