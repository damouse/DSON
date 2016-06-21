//
//  ViewController.swift
//  TestingTarget
//
//  Created by damouse on 6/1/16.
//  Copyright © 2016 I. All rights reserved.
//

import UIKit
import DSON

class Parent: Class {
    var name = "Owner"
}

class Cat: Class {
    var str: String?
    var int: Int?
    var bool: Bool?
    var float: Float?
    var double: Double?
    
    var human = Parent()
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Testing target started")
        
        let num = NSString(string: "strr")
        let dict: [String: AnyObject] = ["str": num, "int": 1, "bool": true, "float": 12.34 as! Float, "double": 56.78 as! Double, "human": ["name": "Neeghbor"]]
        
        let a = try! Cat.from(dict)
        print("Done: \(a.str) \(a.int) \(a.bool) \(a.float) \(a.double) \(a.human.name)")
    }
}

