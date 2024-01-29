import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Array "mo:base/Array";
import List "mo:base/List";
import Option "mo:base/Option";

actor {
  type PropertyId = Nat32;
  type UserId = Nat32;

  type Property = {
    id : PropertyId;
    address : Text;

  };

  type User = {
    id : UserId;
    role : Text; // e.g., "buyer", "seller"
  };

  type Transaction = {
    id : Nat;
    propertyId : PropertyId;
    buyerId : UserId;
    sellerId : UserId;
    // Additional transaction details...
  };

  var propertiesFiles : [Property] = [];

  public type userId = Nat32;
  public type propertyId = Nat32;
  private stable var next : userId = 0;
  private stable var users : Trie.Trie<userId, User> = Trie.empty();
  private stable var properties : Trie.Trie<propertyId, Property> = Trie.empty();
  private var transactions : Trie.Trie<Nat, Transaction> = Trie.empty();

  private func key(x : userId) : Trie.Key<userId> {
    return { hash = x; key = x };
  };

  private func key2(x : propertyId) : Trie.Key<propertyId> {
    return { hash = x; key = x };
  };

  // Function to register a new user
  public func registerUser(user : User) : async Bool {
    users := Trie.replace(
      users,
      key(user.id),
      Nat32.equal,
      ?user,
    ).0;
    return true;
  };

  // Function to get user information
  public func loginUser(id : Nat32) : async ?User {
    let result = Trie.find(users, key(id), Nat32.equal);
    return result;
  };

  // Function to add a new property listing
  public func addProperty(property : Property, uid : Nat32) : async Bool {
    properties := Trie.replace(
      properties,
      key2(property.id),
      Nat32.equal,
      ?property, // Use ? to indicate an Option type
    ).0;

    return true;
  };

  //  Function to get property information
  public func getProperty(propertyId : Nat32) : async ?Property {

    let result = Trie.find(properties, key(propertyId), Nat32.equal);
    return result;
  };

  // Function to initiate a real estate transaction
  // public func initiateTransaction(transaction : Transaction) : async Bool {
  //   transactions := Trie.replace(
  //     transactions,
  //    key2(property.id),
  //     Nat32.equal,
  //     ?transaction,
  //   ).0;
  //   return true;
  // };

  // Function to get transaction information
  //  public func getTransaction(transactionId : Nat) : async ?Transaction {
  //     let result = Trie.find(transactions, key(transactionId), Nat32.equal);
  //     return result;

  // };

};
