import Text "mo:base/Text";
import HttpTypes "http-types";
import Random "mo:base/Random";
import Blob "mo:base/Blob";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Error "mo:base/Error";
import Nat64 "mo:base/Nat64";
import Cycles "mo:base/ExperimentalCycles";
import Buffer "mo:base/Buffer";
module {

  //this method is used for the Idempotency Key used in the request headers of the POST request.
  public func generateUUID() : async Text {
    let random = Random.Finite(await Random.blob());
    let randomNat = random.range(32);
    switch (randomNat) {
      case (?nat) { return "UUID-" # Nat.toText(nat) };
      case null { throw Error.reject("Entropy exhausted") };
    };
  };

};
