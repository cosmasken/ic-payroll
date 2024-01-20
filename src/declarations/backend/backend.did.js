export const idlFactory = ({ IDL }) => {
  const ICRC1Address = IDL.Text;
  const GetAccountAddress = IDL.Record({ 'accountAddress' : ICRC1Address });
  const Time = IDL.Int;
  const GetAccountBalanceSuccess = IDL.Record({
    'currentBalance' : IDL.Nat,
    'timestampNs' : Time,
    'accountAddress' : ICRC1Address,
  });
  const GetAccountBalanceErr = IDL.Record({ 'msg' : IDL.Text });
  const GetAccountBalanceResult = IDL.Variant({
    'ok' : GetAccountBalanceSuccess,
    'err' : GetAccountBalanceErr,
  });
  const Tokens = IDL.Nat;
  const TxIndex__1 = IDL.Nat;
  const Timestamp = IDL.Nat64;
  const TransferError = IDL.Variant({
    'GenericError' : IDL.Record({
      'message' : IDL.Text,
      'error_code' : IDL.Nat,
    }),
    'TemporarilyUnavailable' : IDL.Null,
    'BadBurn' : IDL.Record({ 'min_burn_amount' : Tokens }),
    'Duplicate' : IDL.Record({ 'duplicate_of' : TxIndex__1 }),
    'BadFee' : IDL.Record({ 'expected_fee' : Tokens }),
    'CreatedInFuture' : IDL.Record({ 'ledger_time' : Timestamp }),
    'TooOld' : IDL.Null,
    'InsufficientFunds' : IDL.Record({ 'balance' : Tokens }),
  });
  const PaymentError = IDL.Variant({
    'InvalidRecipientAddress' : IDL.Record({}),
    'InterCanisterCallCaughtError' : IDL.Text,
    'ICRC1TokenCanisterTransferErr' : TransferError,
  });
  const TxIndex = IDL.Nat;
  const PaymentStatus = IDL.Variant({
    'Failed' : IDL.Record({ 'kind' : PaymentError, 'timestampNs' : Time }),
    'Completed' : IDL.Record({ 'txIndex' : TxIndex, 'timestampNs' : Time }),
    'Pending' : IDL.Record({}),
  });
  const Payment = IDL.Record({
    'id' : IDL.Text,
    'status' : PaymentStatus,
    'clientPaymentId' : IDL.Text,
    'createdAtNs' : Time,
    'description' : IDL.Opt(IDL.Text),
    'number' : IDL.Nat,
    'recipientAddress' : ICRC1Address,
    'amount' : IDL.Nat,
    'sourceAddress' : ICRC1Address,
  });
  const GetAccountPayments = IDL.Record({
    'payments' : IDL.Vec(Payment),
    'createdCount' : IDL.Nat,
    'timestampNs' : Time,
  });
  const Value = IDL.Variant({
    'Int' : IDL.Int,
    'Nat' : IDL.Nat,
    'Blob' : IDL.Vec(IDL.Nat8),
    'Text' : IDL.Text,
  });
  const Metadatum = IDL.Tuple(IDL.Text, Value);
  const Metadatas = IDL.Vec(Metadatum);
  const GetTokenCanisterMetadataResult = IDL.Variant({
    'ok' : IDL.Record({ 'metadata' : Metadatas, 'canisterId' : IDL.Text }),
    'err' : IDL.Record({ 'msg' : IDL.Text }),
  });
  const Result = IDL.Variant({
    'ok' : IDL.Null,
    'err' : IDL.Record({ 'msg' : IDL.Text }),
  });
  const SendPayment = IDL.Record({ 'result' : Result, 'payment' : Payment });
  const PaymentProcessor = IDL.Service({
    'getMyAccountBalance' : IDL.Func([], [IDL.Text], []),
    'getSubAccountBalance' : IDL.Func([], [IDL.Text], []),
    'get_account_address' : IDL.Func([], [GetAccountAddress], ['query']),
    'get_account_balance' : IDL.Func([], [GetAccountBalanceResult], []),
    'get_account_payments' : IDL.Func([], [GetAccountPayments], ['query']),
    'get_icrc1_token_canister_metadata' : IDL.Func(
        [],
        [GetTokenCanisterMetadataResult],
        [],
      ),
    'send_payment' : IDL.Func(
        [
          IDL.Record({
            'clientPaymentId' : IDL.Text,
            'description' : IDL.Opt(IDL.Text),
            'recipientAddress' : IDL.Text,
            'amount' : IDL.Nat,
          }),
        ],
        [SendPayment],
        [],
      ),
    'set_icrc1_token_canister' : IDL.Func([IDL.Text], [Result], []),
    'whoami' : IDL.Func([], [IDL.Principal], []),
  });
  return PaymentProcessor;
};
export const init = ({ IDL }) => { return []; };
