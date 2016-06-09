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
}
