import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Array "mo:base/Array";
import List "mo:base/List";
import Option "mo:base/Option";
import Time "mo:base/Time";

actor {
  type PropertyId = Nat32;
  type UserId = Nat32;

  type Property = {
    id : PropertyId;
    address : Text;
    name : Text;
    size : Text;

  };

  type User = {
    id : UserId;
    role : Text; // e.g., "buyer", "seller"
  };

  var propertiesFiles : [Property] = [];

  public type userId = Nat32;
  public type propertyId = Nat32;
  private stable var next : userId = 0;
  private stable var users : Trie.Trie<userId, User> = Trie.empty();
  private stable var properties : Trie.Trie<propertyId, Property> = Trie.empty();
  // private var transactions : Trie.Trie<Nat, Transaction> = Trie.empty();

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
      ?property,
    ).0;

    return true;
  };

  //  Function to get property information
  public func getProperty(propertyId : Nat32) : async ?Property {

    let result = Trie.find(properties, key(propertyId), Nat32.equal);
    return result;
  };

  // Function to search for properties based on a query
  // public func searchProperties(query : Text) : async List<(Property, User)> {
  //   var searchResults : List<(Property, User)> = [];
  //   Trie.iter(properties, func (key : Trie.Key<propertyId>, property : Property) {
  //     if (Text.contains(property.address, query)) {
  //       let owner = Trie.find(users, key(property.id), Nat32.equal);
  //       switch (owner) {
  //         case (?user) {
  //           searchResults := List.concat(searchResults, List.singleton((property, user)));
  //         };
  //         case null {

  //         };
  //       };
  //     };
  //   });

  //   return searchResults;
  // };

  // Function to perform a transaction when a buyer wants to buy land
  public func performTransaction(
    transactionId : Nat32,
    propertyId : PropertyId,
    buyerId : UserId,
    sellerId : UserId,
  ) : async Bool {
    // Get property information
    let propertyResult = Trie.find(properties, key(propertyId), Nat32.equal);

    switch (propertyResult) {
      case (?property) {
        // Check if the property is available for sale or implement other transaction conditions

        // Get buyer and seller information
        let buyerResult = Trie.find(users, key(buyerId), Nat32.equal);
        let sellerResult = Trie.find(users, key(sellerId), Nat32.equal);

        switch (buyerResult, sellerResult) {

          case (?buyer, ?seller) {
            // Your existing code here...
            return true;
          };
          case (?buyer, _) {
            // Handle case when seller information is not found
            return false;
          };
          case (_, ?seller) {
            // Handle case when buyer information is not found
            return false;
          };
          case (null, null) {
            // Handle cases when buyer or seller information is not found
            return false;
          };
        };
      };
      case null {
        // Handle case when property information is not found
        return false;
      };
    };
  };

};
