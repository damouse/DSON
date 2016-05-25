//
//  ConversionTests.swift
//  Deferred
//
//  Created by damouse on 5/17/16.
//  Copyright © 2016 I. All rights reserved.
//
//  These tests cover converstion TO swift types
//  Note that "Primitives" refers to JSON types that arent collections

import XCTest
@testable import DSON


// Primitives
class StringConversion: XCTestCase {
    func testSameType() {
        let a: String = "asdf"
        let b = try! convert(a, to: String.self)
        XCTAssert(a == b)
    }
    
    func testFromFoundation() {
        let a: NSString = "asdf"
        let b = try! convert(a, to: String.self)
        XCTAssert(a == b)
    }
}

class IntConversion: XCTestCase {
    func testSameType() {
        let a: Int = 1
        let b = try! convert(a, to: Int.self)
        XCTAssert(a == b)
    }
    
    func testFromFoundation() {
        let a: NSNumber = 1
        let b = try! convert(a, to: Int.self)
        XCTAssert(a == b)
    }
}

class FloatConversion: XCTestCase {
    func testSameType() {
        let a: Float = 123.456
        let b = try! convert(a, to: Float.self)
        XCTAssert(a == b)
    }
    
    func testFromFoundation() {
        let a: NSNumber = 123.456
        let b = try! convert(a, to: Float.self)
        XCTAssert(b == 123.456)
    }
}

class DoubleConversion: XCTestCase {
    func testSameType() {
        let a: Double = 123.456
        let b = try! convert(a, to: Double.self)
        XCTAssert(a == b)
    }
    
    func testFromFoundation() {
        let a: NSNumber = 123.456
        let b = try! convert(a, to: Double.self)
        XCTAssert(b == 123.456)
    }
}

class BoolConversion: XCTestCase {
    func testSameType() {
        let a: Bool = true
        let b = try! convert(a, to: Bool.self)
        XCTAssert(a == b)
    }
    
    func testFromFoundation() {
        let a: ObjCBool = true
        let b = try! convert(a, to: Bool.self)
        XCTAssert(b == true)
    }
}


// Collections
class ArrayConversion: XCTestCase {
    func testSameType() {
        let a: [String] = ["asdf", "qwer"]
        let b = try! convert(a, to: [String].self)
        XCTAssert(a == b)
    }
    
    // NSArray with Convertible elements
    func testFoundationArray() {
        let a: NSArray = NSArray(objects: "asdf", "qwer")
        let b = try! convert(a, to: [String].self)
        XCTAssert(a == b)
    }
    
    // Swift array with Foundation elements
    func testFoundationElements() {
        let a: [NSString] = [NSString(string: "asdf"), NSString(string: "qwer")]
        let b = try! convert(a, to: [String].self)
        XCTAssert(a == b)
    }
    
    // NSArray array with Foundation elements
    func testFoundationArrayElements() {
        let a: NSArray = NSArray(objects: NSString(string: "asdf"), NSString(string: "qwer"))
        let b = try! convert(a, to: [String].self)
        XCTAssert(a == b)
    }
}


class DictionaryConversion: XCTestCase {
    func testSameType() {
        let a: [String: String] = ["asdf": "qwer"]
        let b = try! convert(a, to: [String: String].self)
        XCTAssert(a == b)
    }
    
    func testAnyObject() {
        let a: [String: AnyObject] = ["asdf": "qwer"]
        let b = try! convert(a, to: [String: String].self)
        
        XCTAssert(b.count == 1)
        XCTAssert(b["asdf"] == "qwer")
    }
    
    func testFoundationDictionary() {
        let a: NSDictionary = NSDictionary(dictionary: ["asdf": "qwer"])
        let b = try! convert(a, to: [String: String].self)
        XCTAssert(a == b)
    }
    
    func testFoundationKeys() {
        let a: [NSString: String] = [NSString(string: "asdf"): "qwer"]
        let b = try! convert(a, to: [String: String].self)
        
        XCTAssert(b.count == 1)
        XCTAssert(b["asdf"] == "qwer")
    }
    
    func testFoundationValues() {
        let a: [String: NSString] = ["asdf": NSString(string: "qwer")]
        let b = try! convert(a, to: [String: String].self)
        
        XCTAssert(b.count == 1)
        XCTAssert(b["asdf"] == "qwer")
    }
    
    func testFoundationKeysValues() {
        let a: [NSString: NSString] = [NSString(string: "asdf"): NSString(string: "qwer")]
        let b = try! convert(a, to: [String: String].self)
        
        XCTAssert(b.count == 1)
        XCTAssert(b["asdf"] == "qwer")
    }
}














































