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

## To Do

- Struct conversion and serialization
- Enum conversion and serialization


