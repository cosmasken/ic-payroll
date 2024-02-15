import Types "./types";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Prelude "mo:base/Prelude";
import Time "mo:base/Time";
import Random "mo:base/Random";
import Sha256 "mo:sha2/Sha256";
import ICRC1_AccountConverter "./icrc1-account-converter";
import Hex "./Hex";
import Account "./Account";

module {

  type AccountIdentifier = Types.AccountIdentifier;

  /// Convert Principal to ICRC1.Subaccount
  // from https://github.com/research-ag/motoko-lib/blob/2772d029c1c5087c2f57b022c84882f2ac16b79d/src/TokenHandler.mo#L51
  public func toSubaccount(p : Principal) : Types.Subaccount {
    // p blob size can vary, but 29 bytes as most. We preserve it'subaccount size in result blob
    // and it'subaccount data itself so it can be deserialized back to p
    let bytes = Blob.toArray(Principal.toBlob(p));
    let size = bytes.size();

    assert size <= 29;

    let a = Array.tabulate<Nat8>(
      32,
      func(i : Nat) : Nat8 {
        if (i + size < 31) {
          0;
        } else if (i + size == 31) {
          Nat8.fromNat(size);
        } else {
          bytes[i + size - 32];
        };
      },
    );
    Blob.fromArray(a);
  };

  public func toAccount({ caller : Principal; canister : Principal }) : Types.Account {
    {
      owner = canister;
      subaccount = ?toSubaccount(caller);
    };
  };

  /** Decodes an ICRC1 account from text if valid, otherwise returns #InvalidAddressText. */
  func icrc1AccountFromText(textAddress : Text) : Result.Result<Types.Account, ()> {
    switch (ICRC1_AccountConverter.fromText(textAddress)) {
      case (#ok(account)) #ok(account);
      case (#err(_)) #err;
    };
  };

  /** Converts: an ICRC1 account to text; and text, if valid, to ok result of an ICRC1 account or else the unit error. */
  public let addressConverter : {
    toText : Types.Account -> Text;
    fromText : Text -> Result.Result<Types.Account, ()>;
  } = {
    toText = ICRC1_AccountConverter.toText;
    fromText = icrc1AccountFromText;
  };

  /** **Computes the constant subaccount of an end-user used to create the corresponding ICRC1 account and its textual address**.
    Deposits to the address of the account of the subaccount computed from the principal `p` passed will **credit** the
    caller's spending balance who has that same principal; while payments made by the caller with that same principal
    passed as the `p` param will **debit** the account of the address of the subaccount computed. */
  public func computeUserSubaccountAccount(p : Principal) : Blob {
    // Domain separator length - domain separator - user's principal.
    Sha256.fromArray(#sha256, Array.flatten([[0x04 : Nat8], Blob.toArray(Text.encodeUtf8("user")), Blob.toArray(Principal.toBlob(p))]));
  };

  public func getAccountUserSubaccount({
    canisterId : Principal;
    user : Principal;
  }) : Types.Account {
    { owner = canisterId; subaccount = ?(computeUserSubaccountAccount(user)) };
  };

  func beBytes(n : Nat32) : [Nat8] {
    func byte(n : Nat32) : Nat8 {
      Nat8.fromNat(Nat32.toNat(n & 0xff));
    };
    [byte(n >> 24), byte(n >> 16), byte(n >> 8), byte(n)];
  };

  public func defaultSubaccount() : Types.Subaccount {
    Blob.fromArrayMut(Array.init(32, 0 : Nat8));
  };

  /**
    * args : { accountIdentifier : AccountIdentifier, canisterId  : ?Principal }
    * Takes an account identifier and returns a Blob
    *
    * Canister ID is required only for Principal, and will return an account identifier using that principal as a subaccount for the provided canisterId
    */
  public func accountIdentifierToBlob(args : Types.AccountIdentifierToBlobArgs) : Types.AccountIdentifierToBlobResult {
    let accountIdentifier = args.accountIdentifier;
    let canisterId = args.canisterId;
    let err = {
      kind = #InvalidAccountIdentifier;
      message = ?"Invalid account identifier";
    };
    switch (accountIdentifier) {
      case (#text(identifier)) {
        switch (Hex.decode(identifier)) {
          case (#ok v) {
            let blob = Blob.fromArray(v);
            if (Account.validateAccountIdentifier(blob)) {
              #ok(blob);
            } else {
              #err(err);
            };
          };
          case (#err _) {
            #err(err);
          };
        };
      };
      case (#principal principal) {
        switch (canisterId) {
          case (null) {
            #err({
              kind = #Other;
              message = ?"Canister Id is required for account identifiers of type principal";
            });
          };
          case (?id) {
            let identifier = Account.accountIdentifier(id, Account.principalToSubaccount(principal));
            if (Account.validateAccountIdentifier(identifier)) {
              #ok(identifier);
            } else {
              #err(err);
            };
          };
        };
      };
      case (#blob(identifier)) {
        if (Account.validateAccountIdentifier(identifier)) {
          #ok(identifier);
        } else {
          #err(err);
        };
      };
    };
  };

  /**
    * args : { accountIdentifier : AccountIdentifier, canisterId  : ?Principal }
    * Takes an account identifier and returns Hex-encoded Text
    *
    * Canister ID is required only for Principal, and will return an account identifier using that principal as a subaccount for the provided canisterId
    */
  public func accountIdentifierToText(args : Types.AccountIdentifierToTextArgs) : Types.AccountIdentifierToTextResult {
    let accountIdentifier = args.accountIdentifier;
    let canisterId = args.canisterId;
    switch (accountIdentifier) {
      case (#text(identifier)) {
        #ok(identifier);
      };
      case (#principal(identifier)) {
        let blobResult = accountIdentifierToBlob(args);
        switch (blobResult) {
          case (#ok(blob)) {
            #ok(Hex.encode(Blob.toArray(blob)));
          };
          case (#err(err)) {
            #err(err);
          };
        };
      };
      case (#blob(identifier)) {
        let blobResult = accountIdentifierToBlob(args);
        switch (blobResult) {
          case (#ok(blob)) {
            #ok(Hex.encode(Blob.toArray(blob)));
          };
          case (#err(err)) {
            #err(err);
          };
        };
      };
    };
  };

  type DefaultAccountArgs = {
    // Hex-encoded AccountIdentifier
    canisterId : Principal;
    principal : Principal;
  };
  public func getDefaultAccount(args : DefaultAccountArgs) : Blob {
    Account.accountIdentifier(args.canisterId, Account.principalToSubaccount(args.principal));
  };

};
