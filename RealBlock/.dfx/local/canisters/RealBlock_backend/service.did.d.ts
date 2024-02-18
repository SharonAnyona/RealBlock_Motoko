import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Property {
  'id' : PropertyId,
  'name' : string,
  'size' : string,
  'address' : string,
}
export type PropertyId = number;
export interface User { 'id' : UserId, 'role' : string }
export type UserId = number;
export interface _SERVICE {
  'addProperty' : ActorMethod<[Property, number], boolean>,
  'getProperty' : ActorMethod<[number], [] | [Property]>,
  'loginUser' : ActorMethod<[number], [] | [User]>,
  'performTransaction' : ActorMethod<
    [number, PropertyId, UserId, UserId],
    boolean
  >,
  'registerUser' : ActorMethod<[User], boolean>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: ({ IDL }: { IDL: IDL }) => IDL.Type[];
