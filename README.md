# DSON

Swift type conversion with emphasis on dealing with JSON. Heavily inspired by Google's GSON library. `DSON` is *damouse's* GSON!

Developed and tested for Swift 2.2. Support for Swift 3.0 and Swift Package Manager coming soon. 

Cocoapods: 

```ruby
pod 'DSON', '~> 1.0.2'
```

## Usage

### Turning stuff into JSON

DSON can convert boring things to json.

```swift
let json = try! DSON.serialize(["apple": "boy", "cat": 14])
print(json.rawString()) 

// => {"apple":"boy", "cat":14}
```

But it can also automatically serialize objects that subclass `DSON.Class`: 

```swift 
class Shark: Class {
    var name: String? = "Bill"
    var age = 12
}

let shark = Shark()
let json = try! DSON.serialize(shark)
print(json.rawString()) 

// => {"name":"Bill", "age":12}
```

Including relationships with multiple objects: 

```swift 
class Dolphin: Class {
    var name: String

    convenience init(newName: String) {
        name = newName
    }
}

class Pod: Class {
    var members: [Dolphin] = []
}

let pod = Pod()
pod.members = [Dolphin("Jill"), Dolphin("Steve"), Dolphin("Judy")]

let json = try! DSON.serialize(pod)
print(json.rawString()) 

// => {"members": [{"name": Jill}, {"name": Steve}, {"name": Judy}] }
```

### Turning stuff into other stuff

The `convert` function attempts to turn any arbitrary argument into a passed type:

```swift
let objectiveString = NSString(string: "apple")
let swiftString = try DSON.convert(objectiveString, to: String.self)
```

Also works for collections and nested conversions. Here we start with an NSArray that contains NSStrings and end up with an Array<String>, or a swift array with swift strings:

```swift
let yuck: NSArray = NSArray(objects: NSString(string: "apple"), NSString(string: "boy"))
let yum = try DSON.convert(yuck, to: [String].self)

// => ["apple", "boy"] of type: Array<String>
```

Finally, you can of course turn json back into objects: 

```swift
class Fish: Class {
    var bool: Bool?
    var float: Float?
}

let a = try Fish.from(["bool": true, "float": 12.34])
}
```

## Guide

### Convert

The convert function takes a variable and a type and tries to turn the variable into that type. 

```swift
let a: NSString = NSString(string: "Im a foundation string")
var b: String? // but we want a swift string :(

b = try DSON.convert(a, to: String.self)
```

Note that the type we want to end up with, `String`, is passed in as a parameter at the end of the convert function. 

`convert` will first try to cast the variable to the new type. In this example:

```swift
b = a as! String
```

will succeed due to swift automatically bridging between Objective-C and Swift types. DSON takes over if this fails. 

You can convert to any type as long as it implements `Convertible`. Heres what the protocol looks like: 

```
protocol Convertible {
    static func from<T>(from: T) throws -> Self
    func serialize() throws -> AnyObject
}
```

`from` is the important function here. To allow a type to be converted to, implement `from` and enumerate how different kinds of types should be converted. 

As an example, here's the protocol implementation for `Bool`. 

```swift
extension Bool : Convertible {
    public static func from<T>(from: T) throws -> Bool {
        // Convert from Objective-C boolean
        if let from = from as? ObjCBool {
            return from.boolValue
        }
        
        throw ConversionError.ConvertibleFailed(from: T.self, type: self)
    }
    
    public func serialize() throws -> AnyObject {
        return self
    }
}
```

You should quickly notice from this example that `from` is not exhaustive. Conversion can always fail.

To make custom types `Convertible` write your own implementation of `from` as so:

```swift
class DemoUser: Convertible {
    var name: String? 

    init(newName: String) {
        name = newNAme
    }

    public static func from<T>(from: T) throws -> DemoUser {
        // We can convert strings to DemoUser...
        if let newName = from as? String {
            return DemoUser(newName)
        }

        //... but not anything else. To add support for other conversions, make more "if let as? type" blocks
        throw ConversionError.ConvertibleFailed(from: T.self, type: self)
    }
}
```

For completeness, here's what the `convert` method looks like. 

```swift
let newUser = try DSON.convert("Jim", to: DemoUser.self)
```

*Dont use the from function directly.* One of the first things that `convert` does is try a simple cast-- you may miss simple conversions! 

#### Conversion Errors

`convert` can throw two types of errors. As an example, lets call the incoming variable *value* and the target type *target*.

- ConversionError.NoConversionPossible: `variable as? target` failed and `target` does not implement `Convertible`. 
- ConversionError.NoConversionPossible: `target` implements `Convertible`, but its implementation doesn't know how to handle `variable` types.

### Class

`DSON.Class` is a built-in class that automatically conforms to `Convertible` for all its descendants. It allows subclasses to automagically convert to and from JSON. 

More to follow. 

## To Do

- Struct conversion and serialization
- Enum conversion and serialization


