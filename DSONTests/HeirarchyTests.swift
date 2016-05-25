//
//  HeirarchyTests.swift
//  Silvery
//
//  Created by damouse on 5/4/16.
//  Copyright © 2016 I. All rights reserved.
//
//  Testing superclasses

import XCTest
import Silvery

class Parent {
    var baseStr = "baseStr"
}

class Child: Parent, Model {
    var str1 = "str1"
    var int1 = 123456
    
    var bool1 = true
    var bool2 = false
    var bool3 = true
    
    var str2 = "str2"
    
    var flt1: Float = 111.111
    var flt2: Float = 222.222
    var flt3: Float = 333.333
    
    var str3 = "str3"
    
    var double1: Double = 111.111
    var double2: Double = 222.222
    var double3: Double = 333.333
    
    var str4 = "str4"
    
    override init() {}
}


// We can successfully write primitive types from objects
class NestedTest: XCTestCase {
    var d = Child()
    
    func testString() {
        d["baseStr"] = "baseStr-new"
        d["str1"] = "str1-new"
        d["str2"] = "str2-new"
        d["str3"] = "str3-new"
        d["str4"] = "str4-new"
        
        XCTAssert(d.baseStr == "baseStr-new")
        XCTAssert(d.str1 == "str1-new")
        XCTAssert(d.str2 == "str2-new")
        XCTAssert(d.str3 == "str3-new")
        XCTAssert(d.str4 == "str4-new")
    }
    
    func testInt() {
        d["int1"] = 999
        XCTAssert(d.int1 == 999)
    }
    
    func testBool() {
        d["bool1"] = false
        XCTAssert(d.bool1 == false)
        d["bool2"] = true
        XCTAssert(d.bool2 == true)
        d["bool3"] = false
        XCTAssert(d.bool3 == false)
    }
    
    func testFloat() {
        d["flt1"] = Float(1.0)
        XCTAssert(d.flt1 == 1.0)
        d["flt2"] = Float(2.0)
        XCTAssert(d.flt2 == 2.0)
        d["flt3"] = Float(3.0)
        XCTAssert(d.flt3 == 3.0)
    }
    
    func testDouble() {
        d["double1"] = 1.0
        XCTAssert(d.double1 == 1.0)
        d["double2"] = 2.0
        XCTAssert(d.double2 == 2.0)
        d["double3"] = 3.0
        XCTAssert(d.double3 == 3.0)
    }
}
