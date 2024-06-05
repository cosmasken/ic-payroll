export const idlFactory = ({ IDL }) => {
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  const CreateDepartmentArgs = IDL.Record({
    'code' : IDL.Text,
    'name' : IDL.Text,
  });
  const Department = IDL.Record({
    'creator' : IDL.Principal,
    'code' : IDL.Text,
    'name' : IDL.Text,
  });
  const Response_10 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Department),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const CreateDesignationArgs = IDL.Record({
    'code' : IDL.Text,
    'name' : IDL.Text,
  });
  const Designation = IDL.Record({
    'creator' : IDL.Principal,
    'code' : IDL.Text,
    'name' : IDL.Text,
  });
  const Response_9 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Designation),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const CreateEmpArgs = IDL.Record({
    'disability' : IDL.Bool,
    'email_address' : IDL.Text,
    'joining_date' : IDL.Text,
    'gross_salary' : IDL.Text,
    'designation' : IDL.Text,
    'role' : IDL.Text,
    'employee_type' : IDL.Text,
    'gender' : IDL.Text,
    'job_group' : IDL.Text,
    'first_name' : IDL.Text,
    'last_name' : IDL.Text,
    'identity' : IDL.Text,
    'organization' : IDL.Text,
    'phone_number' : IDL.Text,
    'department' : IDL.Text,
  });
  const Permissions = IDL.Record({
    'canEdit' : IDL.Bool,
    'canView' : IDL.Bool,
    'canAdd' : IDL.Bool,
    'canPay' : IDL.Bool,
    'canDelete' : IDL.Bool,
    'canUpdate' : IDL.Bool,
  });
  const Emp = IDL.Record({
    'disability' : IDL.Bool,
    'email_address' : IDL.Text,
    'permissions' : IDL.Opt(Permissions),
    'creator' : IDL.Principal,
    'joining_date' : IDL.Text,
    'gross_salary' : IDL.Text,
    'designation' : IDL.Text,
    'role' : IDL.Text,
    'employee_type' : IDL.Text,
    'gender' : IDL.Text,
    'job_group' : IDL.Text,
    'first_name' : IDL.Text,
    'last_name' : IDL.Text,
    'identity' : IDL.Text,
    'organization' : IDL.Text,
    'phone_number' : IDL.Text,
    'department' : IDL.Text,
  });
  const Response_6 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Emp),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const CreateEmployeeArgs = IDL.Record({
    'emp_type' : IDL.Text,
    'wallet' : IDL.Text,
    'access_type' : IDL.Text,
  });
  const Employee = IDL.Record({
    'id' : IDL.Nat,
    'email_address' : IDL.Text,
    'emp_type' : IDL.Text,
    'creator' : IDL.Principal,
    'modified_at' : IDL.Int,
    'name' : IDL.Text,
    'created_at' : IDL.Int,
    'wallet' : IDL.Text,
    'phone_number' : IDL.Text,
    'access_type' : IDL.Text,
  });
  const Response_4 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Employee),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const CreateOrganizationArgs = IDL.Record({
    'code' : IDL.Text,
    'name' : IDL.Text,
  });
  const Organization = IDL.Record({
    'creator' : IDL.Principal,
    'code' : IDL.Text,
    'name' : IDL.Text,
  });
  const Response_8 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Organization),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const Payslip = IDL.Record({
    'nhif_deductions' : IDL.Nat,
    'nssf_deductions' : IDL.Nat,
    'gross_salary' : IDL.Nat,
    'paye' : IDL.Nat,
    'net_salary' : IDL.Nat,
    'total_tax' : IDL.Nat,
    'taxable_income' : IDL.Nat,
    'personal_relief' : IDL.Nat,
    'other_deductions' : IDL.Nat,
    'housing' : IDL.Nat,
  });
  const Response_7 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(Payslip),
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
    'email_notifications' : IDL.Bool,
    'first_name' : IDL.Text,
    'last_name' : IDL.Text,
    'phone_number' : IDL.Text,
  });
  const Response = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(User),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
  });
  const PayslipData = IDL.Record({
    'nhif_deductions' : IDL.Nat,
    'nssf_deductions' : IDL.Nat,
    'gross_salary' : IDL.Nat,
    'name' : IDL.Text,
    'designation' : IDL.Text,
    'paye' : IDL.Nat,
    'net_salary' : IDL.Nat,
    'total_tax' : IDL.Nat,
    'taxable_income' : IDL.Nat,
    'personal_relief' : IDL.Nat,
    'organization' : IDL.Text,
    'department' : IDL.Text,
    'other_deductions' : IDL.Nat,
    'housing' : IDL.Nat,
  });
  const Response_5 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(PayslipData),
    'status_text' : IDL.Text,
    'error_text' : IDL.Opt(IDL.Text),
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
  const PayrollType__1 = IDL.Record({
    'id' : IDL.Nat,
    'creator' : IDL.Text,
    'destination' : IDL.Text,
    'created_at' : IDL.Int,
    'amount' : IDL.Nat,
    'successful' : IDL.Bool,
  });
  const Response_3 = IDL.Record({
    'status' : IDL.Nat16,
    'data' : IDL.Opt(IDL.Vec(PayrollType__1)),
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
  const PayrollType = IDL.Record({
    'id' : IDL.Nat,
    'creator' : IDL.Text,
    'destination' : IDL.Text,
    'created_at' : IDL.Int,
    'amount' : IDL.Nat,
    'successful' : IDL.Bool,
  });
  const SchedulePaymentsArgs = IDL.Record({
    'status' : IDL.Variant({
      'Paid' : IDL.Null,
      'Rejected' : IDL.Null,
      'Unpaid' : IDL.Null,
      'Accepted' : IDL.Null,
    }),
    'created_at' : IDL.Int,
    'receivers' : IDL.Vec(PayrollType),
    'payment_at' : IDL.Int,
  });
  const SchedulePaymentsSuccess = IDL.Record({
    'receivers' : IDL.Vec(PayrollType),
  });
  const SchedulePaymentsErr = IDL.Record({
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
  const SchedulePaymentsResult = IDL.Variant({
    'ok' : SchedulePaymentsSuccess,
    'err' : SchedulePaymentsErr,
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
    'addToMetamaskUsers' : IDL.Func([IDL.Text, IDL.Principal], [Result], []),
    'cancelRecurringTimer' : IDL.Func([IDL.Nat], [], []),
    'checkPayroll' : IDL.Func([], [], []),
    'create_department' : IDL.Func([CreateDepartmentArgs], [Response_10], []),
    'create_designation' : IDL.Func([CreateDesignationArgs], [Response_9], []),
    'create_emp' : IDL.Func([CreateEmpArgs], [Response_6], []),
    'create_employee' : IDL.Func([CreateEmployeeArgs], [Response_4], []),
    'create_organization' : IDL.Func(
        [CreateOrganizationArgs],
        [Response_8],
        [],
      ),
    'emailExists' : IDL.Func([IDL.Text], [IDL.Bool], ['query']),
    'generatePayslip' : IDL.Func([IDL.Text], [Response_7], []),
    'getAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterAddress' : IDL.Func([], [IDL.Text], []),
    'getCanisterBalance' : IDL.Func([], [IDL.Text], []),
    'getDepartments' : IDL.Func([], [IDL.Vec(Department)], ['query']),
    'getDepartmentsLength' : IDL.Func([], [IDL.Text], ['query']),
    'getDesignations' : IDL.Func([], [IDL.Vec(Designation)], ['query']),
    'getDesignationsLength' : IDL.Func([], [IDL.Text], ['query']),
    'getEmpByPrincipal' : IDL.Func([IDL.Principal], [Response_6], []),
    'getEmployeeByPrincipal' : IDL.Func([IDL.Principal], [Response_4], []),
    'getEmployees' : IDL.Func([], [IDL.Vec(Emp)], []),
    'getFundingAddress' : IDL.Func([], [IDL.Text], []),
    'getFundingBalance' : IDL.Func([], [IDL.Text], []),
    'getInvoice' : IDL.Func([], [Account], []),
    'getLogs' : IDL.Func([], [IDL.Vec(IDL.Text)], ['query']),
    'getMetamaskUsers' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Text, IDL.Principal))],
        [],
      ),
    'getMyContacts' : IDL.Func([], [IDL.Vec(Employee)], []),
    'getMyContactsLength' : IDL.Func([], [IDL.Text], []),
    'getMyTransactionLength' : IDL.Func([], [IDL.Text], []),
    'getNotifications' : IDL.Func([], [IDL.Vec(Notification__1)], []),
    'getOrganizations' : IDL.Func([], [IDL.Vec(Organization)], ['query']),
    'getOrganizationsLength' : IDL.Func([], [IDL.Text], ['query']),
    'getTradingAddress' : IDL.Func([], [IDL.Text], []),
    'getTradingBalance' : IDL.Func([], [IDL.Text], []),
    'getTransactionLength' : IDL.Func([], [IDL.Text], ['query']),
    'getUnreadNotifications' : IDL.Func([], [IDL.Vec(Notification__1)], []),
    'getUnreadNotificationsLength' : IDL.Func([], [IDL.Text], []),
    'getUser' : IDL.Func([], [Response], ['query']),
    'getUserByPrincipal' : IDL.Func([IDL.Principal], [Response], ['query']),
    'getUserPayslip' : IDL.Func([IDL.Text], [Response_5], []),
    'getUsersList' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Text, User))],
        ['query'],
      ),
    'get_transaction' : IDL.Func(
        [GetTransactionArgs],
        [GetTransactionResult],
        ['query'],
      ),
    'get_transactions' : IDL.Func([], [IDL.Vec(Transaction)], ['query']),
    'isRegistered' : IDL.Func([], [IDL.Bool], ['query']),
    'linkAccount' : IDL.Func([], [], []),
    'mapPrincipal' : IDL.Func([IDL.Text], [IDL.Principal], []),
    'remove_employee' : IDL.Func([IDL.Text], [Response_4], []),
    'runpayroll' : IDL.Func([IDL.Vec(PayrollType__1)], [Response_3], []),
    'save_notification' : IDL.Func(
        [CreateNotificationArgs],
        [CreateNotificationResult],
        [],
      ),
    'save_payroll' : IDL.Func(
        [SchedulePaymentsArgs],
        [SchedulePaymentsResult],
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
    'setRecurringTimer' : IDL.Func([IDL.Nat], [IDL.Nat], []),
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
    'whoami' : IDL.Func([], [IDL.Principal], ['query']),
  });
  return Backend;
};
export const init = ({ IDL }) => { return [IDL.Nat]; };
