export const idlFactory = ({ IDL }) => {
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({
    'getCanister' : IDL.Func([], [IDL.Text], []),
    'getMyBalance' : IDL.Func([], [IDL.Text], []),
    'transfer' : IDL.Func([], [Result], []),
    'whoami' : IDL.Func([], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
