//
//  SerializationTests.swift
//  Silvery
//
//  Created by damouse on 6/9/16.
//  Copyright © 2016 I. All rights reserved.
//
//
//  NOTE: these tests are actually from DSON, but were written here when the circular dependancy issue made things tough


import XCTest
@testable import DSON

class ObjectSerializationTests: XCTestCase {
    // This test *does not work*. The resulting nil is never passed through to the json string!
    //    func testNil() {
    //        let f = Pod()
    //        f.str = nil
    //        let json = try! serialize(f)
    //
    //        XCTAssert(json["str"].type == .Null)
    //
    //    }
    
    // Object with primitive properties
    func testPrimitiveObject() {
        class Shark: Class {
            var str: String? = "str1"
            var int = 123456
            var bool = true
            var flt: Float = 111.111
            var double: Double = 111.111
            
            required init() {}
        }
        
        let f = Shark()
        let json = try! serialize(f)
        let str = json.rawString(options: NSJSONWritingOptions())!
        
        XCTAssert(str == "{\"str\":\"str1\",\"int\":123456,\"bool\":true,\"flt\":111.111,\"double\":111.111}")
    }
    
    // Arrays of primitives
    func testPrimitiveArrays() {
        class Trout: Class {
            var str: [String]? = ["str1"]
            var int: [Int]? = [123456]
            var bool: [Bool]? = [true]
            var flt: [Float]? = [111.111]
            var double: [Double]? = [111.111]
            
            required init() {}
        }
        
        let f = Trout()
        let json = try! serialize(f)
        let str = json.rawString(options: NSJSONWritingOptions())!
        
        XCTAssert(str == "{\"str\":[\"str1\"],\"int\":[123456],\"bool\":[true],\"flt\":[111.111],\"double\":[111.111]}")
    }
    
    func testNestedObject() {
        class Minnow: Class {
            var name = "tim"
            required init() {}
        }
        
        class Fish: Class {
            var type = Minnow()
        }
        
        let f = Fish()
        let json = try! serialize(f)
        let str = json.rawString(options: NSJSONWritingOptions())!
        
        XCTAssert(str == "{\"type\":{\"name\":\"tim\"}}")
    }
    
    func testNestedObjectArray() {
        class Minnow: Class {
            var name = "tim"
        }
        
        class School: Class {
            var members = [Minnow(), Minnow(), Minnow()]
        }
        
        let f = School()
        let json = try! serialize(f)
        let str = json.rawString(options: NSJSONWritingOptions())!
        
        XCTAssert(str == "{\"members\":[{\"name\":\"tim\"},{\"name\":\"tim\"},{\"name\":\"tim\"}]}")
    }
    
    func testObjectDictionary() {
        class Dolphin: Class {
            var age = 14
        }
        
        class Pod: Class {
            var members: [String: Dolphin] = ["bill": Dolphin(), "steve": Dolphin()]
        }
        
        let json = try! serialize(Pod())
        let str = json.rawString(options: NSJSONWritingOptions())
        
        XCTAssert(str == "{\"members\":{\"bill\":{\"age\":14},\"steve\":{\"age\":14}}}")
    }
}


