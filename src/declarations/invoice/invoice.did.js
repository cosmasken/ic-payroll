export const idlFactory = ({ IDL }) => {
  const Employee = IDL.Record({
    'salary' : IDL.Nat,
    'name' : IDL.Text,
    'role' : IDL.Text,
    'email' : IDL.Text,
    'address' : IDL.Text,
    'wallet' : IDL.Text,
    'phone' : IDL.Text,
    'department' : IDL.Text,
  });
  const EmployeeId = IDL.Nat32;
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({
    'create' : IDL.Func([Employee], [EmployeeId], []),
    'delete' : IDL.Func([EmployeeId], [IDL.Bool], []),
    'getBalance' : IDL.Func([], [IDL.Text], []),
    'getNumberOfFreelancers' : IDL.Func([], [IDL.Nat32], ['query']),
    'makeTransfer' : IDL.Func([IDL.Text, IDL.Nat], [Result], []),
    'read' : IDL.Func([EmployeeId], [IDL.Opt(Employee)], ['query']),
    'update' : IDL.Func([EmployeeId, Employee], [IDL.Bool], []),
    'whoami' : IDL.Func([], [IDL.Principal], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
