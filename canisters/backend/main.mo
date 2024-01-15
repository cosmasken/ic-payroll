/**
 * Module     : Main.mo
 * Copyright  : Cosmas Ken
 * License    : Apache 2.0 with LLVM Exception
 * Maintainer : Cosmas Ken <arubacosmas@gmail.com>
 * Stability  : Stable
 */

import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import CkBtcLedger "canister:icrc1_ledger";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Error "mo:base/Error";
import Text "mo:base/Text";
import { toAccount; toSubaccount; createInvoice } "./utils";
actor Backend {

    public shared query (msg) func whoami() : async Principal {
        msg.caller
    };

  
  stable var projectName : Text = "Pochi";

  /**
   * Low-Level API
   */

  public query func get() : async Text {
    return projectName;
  };


  /**
   * Types
   */

    // The type of a company identifier.
  public type CompanyId = Nat32;
   // The type of a director identifier.
  public type DirectorId = Nat32;

    // The type of a company.
  public type Director = {
    name : Text;
    companies : List.List<Company>;
  };


    // The type of a company.
  public type Company = {
    name : Text;
    departments : List.List<Department>;
  };

      // The type of a department.
  public type Department = {
    name : Text;
    employees : List.List<Employee>;
  };

      // The type of a employee.
  public type Employee = {
    name : Text;
    address : Text;
  };

  /**
   * Application State
   */

  // The next available superhero identifier.
    private stable var nextCompany : CompanyId = 0;

    // The company data store.
  private stable var companies : Trie.Trie<CompanyId, Company> = Trie.empty();

  /**
   * High-Level API
   */


   // Create a company.
  public func createCompany(company : Company) : async CompanyId {
    let companyId = nextCompany;
    nextCompany += 1;
    companies := Trie.replace(
      companies,
      key(companyId),
      Nat32.equal,
      ?company,
    ).0;
    return companyId;
  };


  
  // Read a company.
  public query func readCompany(companyId : CompanyId) : async ?Company {
    let result = Trie.find(companies, key(companyId), Nat32.equal);
    return result;
  };

  

    // Update a company.
  public func updateCompanyDetails(companyId : CompanyId, company : Company) : async Bool {
    let result = Trie.find(companies, key(companyId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      companies := Trie.replace(
        companies,
        key(companyId),
        Nat32.equal,
        ?company,
      ).0;
    };
    return exists;
  };



    // Delete a company.
  public func deleteCompany(companyId : CompanyId) : async Bool {
    let result = Trie.find(companies, key(companyId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      companies := Trie.replace(
        companies,
        key(companyId),
        Nat32.equal,
        null,
      ).0;
    };
    return exists;
  };

  /**
   * Utilities
   */

  // Create a trie key from a company identifier.
  private func key(x : CompanyId) : Trie.Key<CompanyId> {
    return { hash = x; key = x };
  };



    public shared ({ caller }) func getBalance() : async Text{

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      { owner = caller;
      subaccount = null;}
    );

    let formattedBalance = balance / 100000000;

    return Nat.toText(formattedBalance);

    };


     public shared ({ caller }) func makeTransfer(receiver:Text, amount:Nat) : async Result.Result<Text, Text>{

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
      { owner = caller;
      subaccount = null;}
    );

  let formattedBalance = balance / 100000000;
  
    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

  

      try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = amount - 10;
          from_subaccount = null;
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromText(receiver);
            subaccount = null;
          };
        }
      );

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to default account:\n" # debug_show (transferError));
        };
        case (_) {};
      };
    } catch (error : Error) {
      return #err("Reject message: " # Error.message(error));
    };


return #ok("🥠: " # " amount Sent");

    };



 

   
  };



