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


// We're going to assume that no conversion is needed if the arguments do not implement convertible
// If it does, then its responsible for returning the appropriate values
public func serialize(from: AnyObject) throws -> JSON {
    let json = JSON(from)
    
    if json.type == .Unknown {
        throw ConversionError.JSONFailed(type: from.dynamicType, error: json.error!.localizedDescription)
    }
    
    return json
}
