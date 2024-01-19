export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'getCanister' : IDL.Func([], [IDL.Text], []),
    'whoami' : IDL.Func([], [IDL.Principal], []),
  });
};
export const init = ({ IDL }) => { return []; };
