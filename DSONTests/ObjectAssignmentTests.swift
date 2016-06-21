//
//  ClassTests.swift
//  Silvery
//
//  Created by Mickey Barboi on 5/26/16.
//  Copyright © 2016 I. All rights reserved.
//

import XCTest
@testable import DSON

class Fish: Class {
    var str: String?
    var int: Int?
    var bool: Bool?
    var float: Float?
    var double: Double?
}


class ObjectAssignmentTests: XCTestCase {
    func testSimpleDictionaryFrom() {
        let a = try! Fish.from(["str": "str", "int": 1, "bool": true, "float": 12.34, "double": 56.78])
        
        XCTAssert(a.str! == "str")
        XCTAssert(a.int! == 1)
        XCTAssert(a.bool! == true)
        XCTAssert(a.float! == 12.34)
        XCTAssert(a.double! == 56.78)
    }
}
