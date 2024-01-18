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
import Nat32 "mo:base/Nat32";
import Result "mo:base/Result";
import Error "mo:base/Error";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import { toAccount; toSubaccount; createInvoice } "./utils";
actor Backend {


  
  /**
   * Types
   */

  // The type of a freelanceer identifier.
  public type EmployeeId = Nat32;

  // The type of a freelanceer.
  public type Employee = {
    name : Text;
    email : Text;
    address : Text;
    wallet : Text;
    phone : Text;
    salary : Nat;
    role : Text;
    department : Text;
    //id : EmployeeId;

  };

  /**
   * Application State
   */

  // The next available freelanceer identifier.
  private stable var next : EmployeeId = 0;

  private stable var employees : [Employee] = [];

  // The freelanceer data store.
  private stable var freelancers : Trie.Trie<EmployeeId, Employee> = Trie.empty();

//get number of freelancers
  public query func getNumberOfFreelancers() : async Nat32 {
    return next;
  };

  //return all freelancers
  // public query func getAllFreelancers() : async Trie {
  //   let freelancersList = Trie.all(freelancers);
  //   return freelancersList;
  // };
  /**
   * High-Level API
   */

  // Create a freelanceer.
  public func create(freelancer : Employee) : async EmployeeId {
    let freelancerId = next;
    next += 1;
    freelancers := Trie.replace(
      freelancers,
      key(freelancerId),
      eq,
      ?freelancer,
    ).0;
    return freelancerId;
  };

  // Read a freelanceer.
  public query func read(freelancerId : EmployeeId) : async ?Employee {
    let result = Trie.find(freelancers, key(freelancerId), eq);
    return result;
  };

  // Update a freelanceer.
  public func update(freelancerId : EmployeeId, freelancer : Employee) : async Bool {
    let result = Trie.find(freelancers, key(freelancerId), eq);
    let exists = Option.isSome(result);
    if (exists) {
      freelancers := Trie.replace(
        freelancers,
        key(freelancerId),
        eq,
        ?freelancer,
      ).0;
    };
    return exists;
  };

  // Delete a freelanceer.
  public func delete(freelancerId : EmployeeId) : async Bool {
    let result = Trie.find(freelancers, key(freelancerId), eq);
    let exists = Option.isSome(result);
    if (exists) {
      freelancers := Trie.replace(
        freelancers,
        key(freelancerId),
        eq,
        null,
      ).0;
    };
    return exists;
  };

  /**
   * Utilities
   */

  // Test two superhero identifiers for equality.
  private func eq(x : EmployeeId, y : EmployeeId) : Bool {
    return x == y;
  };

  // Create a trie key from a superhero identifier.
  private func key(x : EmployeeId) : Trie.Key<EmployeeId> {
    return { hash = x; key = x };
  };



  };



