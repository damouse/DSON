//
//  Class.swift
//  DSON
//
//  Created by Mickey Barboi on 5/26/16.
//  Copyright © 2016 I. All rights reserved.
//
//  This is the components of Silvery classes that didn't really fit into Silvery any longer. 
//  I'm not entirely happy with this decision, but the code here should be pretty portable

import Foundation
import Silvery

public class Class: Silvery {
    
    // All subclasses must be initializable without arguments so silvery can do its work
    required public init() {}
    
    // Return a list of keys that *will not be touched* when converting to and from json
    // ALWAYS call the superclass method when subclassing!
    public static func ignoreProperties() -> [String] {
        return []
    }
    
    // Reflects differences betweeen property names on this class and resulting json 
    // For example, if this class has a property called "name":
    //
    //      var name: String = "anyrandomname"
    //
    // but the corresponding json key should be "firstName":
    //
    //      { "firstName": "anyrandomname" }
    //
    // then this method should return the swift dictionary:
    //
    //      ["name": "firstName"]
    //
    // That is the swift property names and their corresponding json names.
    // If the property does not exist or appears in the list returned by ignoreProperties then nothing is done.
    // The mapping occurs both ways: from json to object and from object to json.
    //
    // ALWAYS call the superclass method when subclassing!
    public static func propertyKeysToJson() -> [String: String] {
        return [:]
    }
}

extension Class: Convertible {
    
    public static func from<T>(from: T) throws -> Self {
        // Automatically cover cases where "from" is not the correct type
        let json = try convert(from, to: [String: AnyObject].self)
        print("Have json: \(json)")
        
        let ignored = ignoreProperties()
        let transformed = propertyKeysToJson()
        
        // Instantiate self and assign values to it. Strangely the reference to "object" is not recognized as conforming to silvery without an explicit cast
        var object = self.init()        
        var silveryReference = object as! Silvery

        for k in silveryReference.keys() {
            if ignored.contains(k) { continue }
            
            // This is the name of the property. It could be switched out for another value based on propertyKeysToJson
            var propertyName = k
            
            for (propertyKey, jsonKey) in transformed {
                if jsonKey == propertyName {
                    propertyName = propertyKey
                    break
                }
            }
            
            let newValue = json[propertyName]! as! Property
            print("Setting property \(propertyName) to \(newValue)")
            
            // Need to run one more round of conversion so the newValue is the right type
            // Silvery does not do this, but it also doesn't report the type of property well (or at all?)
            
            try silveryReference.setValue(newValue as! Property, forKey: propertyName)
        }
        
        print("Returning object: \(object)")
        return object
    }
}




