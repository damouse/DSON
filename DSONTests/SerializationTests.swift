//
//  SerializationTests.swift
//  DSON
//
//  Created by damouse on 6/9/16.
//  Copyright © 2016 I. All rights reserved.
//

import XCTest
@testable import DSON


class SerializationTests: XCTestCase {
    // Swift Primitives
    func testString() {
        let a: String = "hello"
        let serialized = try! serialize(a)
        XCTAssert(serialized.string! == "hello")
    }
    
    func testInt() {
        let a: Int = 123
        let serialized = try! serialize(a)
        XCTAssert(serialized.int! == a)
    }
    
    func testBool() {
        let a: Bool = true
        let serialized = try! serialize(a)
        XCTAssert(serialized.bool! == a)
    }
    
    func testFloat() {
        let a: Float = 123.456
        let serialized = try! serialize(a)
        XCTAssert(serialized.float! == a)
    }
    
    func testDouble() {
        let a: Double = 123.456
        let serialized = try! serialize(a)
        XCTAssert(serialized.double! == a)
    }
    
    
    // Foundation Primitives
    func testNSString() {
        let a: NSString = "hello"
        let serialized = try! serialize(a)
        XCTAssert(serialized.string! == "hello")
    }
    
    func testNSInt() {
        let a: NSNumber = 123
        let serialized = try! serialize(a)
        XCTAssert(serialized.int! == a)
    }
    
    
    // Collections
    func testArray() {
        let a: [AnyObject] = ["a", 1]
        let serialized = try! serialize(a)
        
        XCTAssert(serialized.array![0].string! == "a")
        XCTAssert(serialized.array![1].int! == 1)
    }
    
    func testNSArray() {
        let a = NSArray(array: ["a", 1])
        let serialized = try! serialize(a)
        
        XCTAssert(serialized.array![0].string! == "a")
        XCTAssert(serialized.array![1].int! == 1)
    }
    
    func testDict() {
        let a: [String: AnyObject] = ["a": 1]
        let serialized = try! serialize(a)
        
        XCTAssert(serialized.dictionaryValue["a"] == 1)
    }
    
    func testNSDict() {
        let a = NSDictionary(dictionary: ["a": 1])
        let serialized = try! serialize(a)
        
        XCTAssert(serialized.dictionaryValue["a"] == 1)
    }
}
