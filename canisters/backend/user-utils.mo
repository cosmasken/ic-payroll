import UserTypes "user-types";
import Principal "mo:base/Principal";
import Types "types";
import Trie "mo:base/Trie";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
module UserUtils {

  type User = UserTypes.User;

  /**
    * Generate a Trie key based on  principal ID
    */
  private func userKey(x : Text) : Trie.Key<Text> {
    return { hash = Text.hash(x); key = x };
  };

  public func getUser(userStore : Trie.Trie<Text, User>, caller : Principal) : async Types.Response<User> {

    switch (Trie.get(userStore, userKey(Principal.toText(caller)), Text.equal)) {
      case (?user) {
        {
          status = 200;
          status_text = "OK";
          data = ?user;
          error_text = null;
        };
      };
      case null {
        {
          status = 404;
          status_text = "Not Found";
          data = null;
          error_text = ?("User with principal ID: " # Principal.toText(caller) # " not found.");
        };
      };
    };
  };

  /**
    *  Get user data by principal
    */
  public func getUserByPrincipal(userStore : Trie.Trie<Text, User>, principal : Principal) : async Types.Response<User> {
    switch (Trie.get(userStore, userKey(Principal.toText(principal)), Text.equal)) {
      case (?user) {
        {
          status = 200;
          status_text = "OK";
          data = ?user;
          error_text = null;
        };
      };
      case null {
        {
          status = 404;
          status_text = "Not Found";
          data = null;
          error_text = ?("User with principal ID: " # Principal.toText(principal) # " not found.");
        };
      };
    };
  };

  /**
    *  Check if user exists and return Bool
    */
  public func isRegistered(userStore : Trie.Trie<Text, User>, caller : Principal) : async Bool {

    switch (Trie.get(userStore, userKey(Principal.toText(caller)), Text.equal)) {
      case (?user) {
        return true;
      };
      case null {
        return false;
      };
    };
  };

  /**
    *  Check no of registered users
    */
  public func userLength(userStore : Trie.Trie<Text, User>) : async Text {
    var size = Trie.size(userStore);
    return Nat.toText(size);
  };

};
