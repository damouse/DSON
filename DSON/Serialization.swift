//
//  Serialization.swift
//  DSON
//
//  Created by damouse on 6/9/16.
//  Copyright © 2016 I. All rights reserved.
//
//  Handles serialization of Convertible objects into JSON. Uses SwiftyJSON to produce final JSON output


import Foundation
import SwiftyJSON


// Performs two steps: serializes "from" to some json-ready form, and converts that serialized form to JSON 
// This serialization mostly means turning objects and structs into Dictionaries recursively
// Returns a SwiftyJSON object. Raw JSON can be retrieved by accessing .rawData on the result
public func serialize(from: AnyObject) throws -> JSON {
    var target = from
    
    // Ask the target to serialize itself
    if let convertible = target as? Convertible {
        target = try convertible.serialize()
    }
    
    // Convert it to json and return
    let json = JSON(target)
    
    if json.type == .Unknown {
        throw ConversionError.JSONFailed(type: from.dynamicType, error: json.error!.localizedDescription)
    }
    
    return json
}
