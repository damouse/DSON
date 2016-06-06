//
//  Conversino.swift
//  Deferred
//
//  Created by damouse on 5/4/16.
//  Copyright © 2016 I. All rights reserved.
//

import Foundation

public protocol Convertible {
    // Convert the given argument to this type. Assumes "T as? Self", has already been tried, or in other words checking
    // if no conversion is needed.
    static func from<T>(from: T) throws -> Self
}


public enum ConversionError : ErrorType, CustomStringConvertible {
    case NoConversionPossible(from: Any.Type, type: Any.Type)
    case ConvertibleFailed(from: Any.Type, type: Any.Type)
    
    public var description: String {
        switch self {
        case .NoConversionPossible(from: let from, type: let type): return "Cant convert \"\(from)\". Cast failed or \"\(type)\" does not implement Convertible"
        case .ConvertibleFailed(from: let from, type: let type): return "Convertible type \"\(type)\" does not support conversion from \"\(from)\""
        }
    }
}


// Conversion methods should do all kinds of conversion in the absence of the deferred system
// This method is for single value targets and sources
// This works a lot like GSON for Android: give me something and tell me how you want it
public func convert<A, B>(from: A, to: B.Type) throws -> B {
    
    // Catch a suprising majority of simple conversions where Swift can bridge or handle the type conversion itself
    if let simpleCast = from as? B {
        return simpleCast
    }
    
    // If B conforms to Convertible then the type has conversion overrides that may be able to handle the conversion
    if let convertible = B.self as? Convertible.Type {
        return try convertible.from(from) as! B
    }
    
    throw ConversionError.NoConversionPossible(from: A.self, type: to.self)
}


// Convertible builtin overrides
extension Bool : Convertible {
    public static func from<T>(from: T) throws -> Bool {
        // Convert from Foundation
        if let from = from as? ObjCBool {
            return from.boolValue
        }
        
        throw ConversionError.ConvertibleFailed(from: T.self, type: self)
    }
}

extension Array: Convertible {
    public static func from<T>(from: T) throws -> Array {
        
        // Dont have to check for swift arrays here, they'll bridge to NSArrays
        if let from = from as? NSArray {
            return try from.map() { (element: AnyObject) throws -> Element in
                return try convert(element, to: Element.self)
            }
        }
        
        throw ConversionError.ConvertibleFailed(from: T.self, type: self)
    }
}

extension Dictionary: Convertible {
    public static func from<T>(from: T) throws -> Dictionary {
        
        // Like Array from, we don't have to check for swift Dictionaries, they'll bridge over
        if let from = from as? NSDictionary {
            var ret: [Key: Value] = [:]
            
            for key in from.allKeys {
                ret[try convert(key, to: Key.self)] = try convert(from.objectForKey(key)!, to: Value.self)
            }
            
            return ret
        }
        
        throw ConversionError.ConvertibleFailed(from: T.self, type: self)
    }
}


























