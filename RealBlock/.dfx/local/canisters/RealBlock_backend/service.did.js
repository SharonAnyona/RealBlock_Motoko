export const idlFactory = ({ IDL }) => {
  const PropertyId = IDL.Nat32;
  const Property = IDL.Record({
    'id' : PropertyId,
    'name' : IDL.Text,
    'size' : IDL.Text,
    'address' : IDL.Text,
  });
  const UserId = IDL.Nat32;
  const User = IDL.Record({ 'id' : UserId, 'role' : IDL.Text });
  return IDL.Service({
    'addProperty' : IDL.Func([Property, IDL.Nat32], [IDL.Bool], []),
    'getProperty' : IDL.Func([IDL.Nat32], [IDL.Opt(Property)], []),
    'loginUser' : IDL.Func([IDL.Nat32], [IDL.Opt(User)], []),
    'performTransaction' : IDL.Func(
        [IDL.Nat32, PropertyId, UserId, UserId],
        [IDL.Bool],
        [],
      ),
    'registerUser' : IDL.Func([User], [IDL.Bool], []),
  });
};
export const init = ({ IDL }) => { return []; };
