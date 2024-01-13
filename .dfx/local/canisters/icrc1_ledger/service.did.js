export const idlFactory = ({ IDL }) => {
  const Value = IDL.Rec();
  const BlockIndex = IDL.Nat;
  const GetBlocksArgs = IDL.Record({
    'start' : BlockIndex,
    'length' : IDL.Nat,
  });
  const Map = IDL.Vec(IDL.Tuple(IDL.Text, Value));
  Value.fill(
    IDL.Variant({
      'Int' : IDL.Int,
      'Map' : Map,
      'Nat' : IDL.Nat,
      'Nat64' : IDL.Nat64,
      'Blob' : IDL.Vec(IDL.Nat8),
      'Text' : IDL.Text,
      'Array' : IDL.Vec(Value),
    })
  );
  const Block = Value;
  const BlockRange = IDL.Record({ 'blocks' : IDL.Vec(Block) });
  const QueryBlockArchiveFn = IDL.Func(
      [GetBlocksArgs],
      [BlockRange],
      ['query'],
    );
  const GetBlocksResponse = IDL.Record({
    'certificate' : IDL.Opt(IDL.Vec(IDL.Nat8)),
    'first_index' : BlockIndex,
    'blocks' : IDL.Vec(Block),
    'chain_length' : IDL.Nat64,
    'archived_blocks' : IDL.Vec(
      IDL.Record({
        'callback' : QueryBlockArchiveFn,
        'start' : BlockIndex,
        'length' : IDL.Nat,
      })
    ),
  });
  const DataCertificate = IDL.Record({
    'certificate' : IDL.Opt(IDL.Vec(IDL.Nat8)),
    'hash_tree' : IDL.Vec(IDL.Nat8),
  });
  const TxIndex = IDL.Nat;
  const GetTransactionsRequest = IDL.Record({
    'start' : TxIndex,
    'length' : IDL.Nat,
  });
  const Subaccount = IDL.Vec(IDL.Nat8);
  const Account = IDL.Record({
    'owner' : IDL.Principal,
    'subaccount' : IDL.Opt(Subaccount),
  });
  const Transaction = IDL.Record({
    'burn' : IDL.Opt(
      IDL.Record({
        'from' : Account,
        'memo' : IDL.Opt(IDL.Vec(IDL.Nat8)),
        'created_at_time' : IDL.Opt(IDL.Nat64),
        'amount' : IDL.Nat,
      })
    ),
    'kind' : IDL.Text,
    'mint' : IDL.Opt(
      IDL.Record({
        'to' : Account,
        'memo' : IDL.Opt(IDL.Vec(IDL.Nat8)),
        'created_at_time' : IDL.Opt(IDL.Nat64),
        'amount' : IDL.Nat,
      })
    ),
    'timestamp' : IDL.Nat64,
    'transfer' : IDL.Opt(
      IDL.Record({
        'to' : Account,
        'fee' : IDL.Opt(IDL.Nat),
        'from' : Account,
        'memo' : IDL.Opt(IDL.Vec(IDL.Nat8)),
        'created_at_time' : IDL.Opt(IDL.Nat64),
        'amount' : IDL.Nat,
      })
    ),
  });
  const TransactionRange = IDL.Record({
    'transactions' : IDL.Vec(Transaction),
  });
  const QueryArchiveFn = IDL.Func(
      [GetTransactionsRequest],
      [TransactionRange],
      ['query'],
    );
  const GetTransactionsResponse = IDL.Record({
    'first_index' : TxIndex,
    'log_length' : IDL.Nat,
    'transactions' : IDL.Vec(Transaction),
    'archived_transactions' : IDL.Vec(
      IDL.Record({
        'callback' : QueryArchiveFn,
        'start' : TxIndex,
        'length' : IDL.Nat,
      })
    ),
  });
  const Tokens = IDL.Nat;
  const MetadataValue = IDL.Variant({
    'Int' : IDL.Int,
    'Nat' : IDL.Nat,
    'Blob' : IDL.Vec(IDL.Nat8),
    'Text' : IDL.Text,
  });
  const Timestamp = IDL.Nat64;
  const TransferArg = IDL.Record({
    'to' : Account,
    'fee' : IDL.Opt(Tokens),
    'memo' : IDL.Opt(IDL.Vec(IDL.Nat8)),
    'from_subaccount' : IDL.Opt(Subaccount),
    'created_at_time' : IDL.Opt(Timestamp),
    'amount' : Tokens,
  });
  const TransferError = IDL.Variant({
    'GenericError' : IDL.Record({
      'message' : IDL.Text,
      'error_code' : IDL.Nat,
    }),
    'TemporarilyUnavailable' : IDL.Null,
    'BadBurn' : IDL.Record({ 'min_burn_amount' : Tokens }),
    'Duplicate' : IDL.Record({ 'duplicate_of' : BlockIndex }),
    'BadFee' : IDL.Record({ 'expected_fee' : Tokens }),
    'CreatedInFuture' : IDL.Record({ 'ledger_time' : IDL.Nat64 }),
    'TooOld' : IDL.Null,
    'InsufficientFunds' : IDL.Record({ 'balance' : Tokens }),
  });
  const TransferResult = IDL.Variant({
    'Ok' : BlockIndex,
    'Err' : TransferError,
  });
  const AllowanceArgs = IDL.Record({
    'account' : Account,
    'spender' : Account,
  });
  const Allowance = IDL.Record({
    'allowance' : Tokens,
    'expires_at' : IDL.Opt(Timestamp),
  });
  const ApproveArgs = IDL.Record({
    'fee' : IDL.Opt(Tokens),
    'memo' : IDL.Opt(IDL.Vec(IDL.Nat8)),
    'from_subaccount' : IDL.Opt(Subaccount),
    'created_at_time' : IDL.Opt(Timestamp),
    'amount' : Tokens,
    'expected_allowance' : IDL.Opt(Tokens),
    'expires_at' : IDL.Opt(Timestamp),
    'spender' : Account,
  });
  const ApproveError = IDL.Variant({
    'GenericError' : IDL.Record({
      'message' : IDL.Text,
      'error_code' : IDL.Nat,
    }),
    'TemporarilyUnavailable' : IDL.Null,
    'Duplicate' : IDL.Record({ 'duplicate_of' : BlockIndex }),
    'BadFee' : IDL.Record({ 'expected_fee' : Tokens }),
    'AllowanceChanged' : IDL.Record({ 'current_allowance' : Tokens }),
    'CreatedInFuture' : IDL.Record({ 'ledger_time' : IDL.Nat64 }),
    'TooOld' : IDL.Null,
    'Expired' : IDL.Record({ 'ledger_time' : IDL.Nat64 }),
    'InsufficientFunds' : IDL.Record({ 'balance' : Tokens }),
  });
  const ApproveResult = IDL.Variant({
    'Ok' : BlockIndex,
    'Err' : ApproveError,
  });
  const TransferFromArgs = IDL.Record({
    'to' : Account,
    'fee' : IDL.Opt(Tokens),
    'spender_subaccount' : IDL.Opt(Subaccount),
    'from' : Account,
    'memo' : IDL.Opt(IDL.Vec(IDL.Nat8)),
    'created_at_time' : IDL.Opt(Timestamp),
    'amount' : Tokens,
  });
  const TransferFromError = IDL.Variant({
    'GenericError' : IDL.Record({
      'message' : IDL.Text,
      'error_code' : IDL.Nat,
    }),
    'TemporarilyUnavailable' : IDL.Null,
    'InsufficientAllowance' : IDL.Record({ 'allowance' : Tokens }),
    'BadBurn' : IDL.Record({ 'min_burn_amount' : Tokens }),
    'Duplicate' : IDL.Record({ 'duplicate_of' : BlockIndex }),
    'BadFee' : IDL.Record({ 'expected_fee' : Tokens }),
    'CreatedInFuture' : IDL.Record({ 'ledger_time' : IDL.Nat64 }),
    'TooOld' : IDL.Null,
    'InsufficientFunds' : IDL.Record({ 'balance' : Tokens }),
  });
  const TransferFromResult = IDL.Variant({
    'Ok' : BlockIndex,
    'Err' : TransferFromError,
  });
  return IDL.Service({
    'get_blocks' : IDL.Func([GetBlocksArgs], [GetBlocksResponse], ['query']),
    'get_data_certificate' : IDL.Func([], [DataCertificate], ['query']),
    'get_transactions' : IDL.Func(
        [GetTransactionsRequest],
        [GetTransactionsResponse],
        ['query'],
      ),
    'icrc1_balance_of' : IDL.Func([Account], [Tokens], ['query']),
    'icrc1_decimals' : IDL.Func([], [IDL.Nat8], ['query']),
    'icrc1_fee' : IDL.Func([], [Tokens], ['query']),
    'icrc1_metadata' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Text, MetadataValue))],
        ['query'],
      ),
    'icrc1_minting_account' : IDL.Func([], [IDL.Opt(Account)], ['query']),
    'icrc1_name' : IDL.Func([], [IDL.Text], ['query']),
    'icrc1_supported_standards' : IDL.Func(
        [],
        [IDL.Vec(IDL.Record({ 'url' : IDL.Text, 'name' : IDL.Text }))],
        ['query'],
      ),
    'icrc1_symbol' : IDL.Func([], [IDL.Text], ['query']),
    'icrc1_total_supply' : IDL.Func([], [Tokens], ['query']),
    'icrc1_transfer' : IDL.Func([TransferArg], [TransferResult], []),
    'icrc2_allowance' : IDL.Func([AllowanceArgs], [Allowance], ['query']),
    'icrc2_approve' : IDL.Func([ApproveArgs], [ApproveResult], []),
    'icrc2_transfer_from' : IDL.Func(
        [TransferFromArgs],
        [TransferFromResult],
        [],
      ),
  });
};
export const init = ({ IDL }) => { return []; };
