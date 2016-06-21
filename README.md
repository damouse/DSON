# DSON

Swift type conversion with emphasis on dealing with JSON. Heavily inspired by Google's GSON library. `DSON` is *damouse's* GSON!

Developed and tested for Swift 2.2. Support for Swift 3.0 and Swift Package Manager coming soon. 

Cocoapods: 

```ruby
pod 'DSON', '~> 1.0.2'
```

## Usage

### Making JSON from stuff

DSON can convert boring things to json.

```swift
let json = try! DSON.serialize(["apple": "boy", "cat": 14])
print(json.rawString()) 

// => {"apple":"boy", "cat":14}
```

But it can automatically serialize objects that subclass `Class`: 

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

### Making stuff from other stuff

DSON can turn arbitrary stuff into other stuff using the `convert` function. 

```swift
let objectiveString = NSString(string: "apple")
let swiftString = try DSON.convert(objectiveString, to: String.self)
```

Also works for nested collections of normally unfun things: 

```swift
let yuck: NSArray = NSArray(objects: NSString(string: "apple"), NSString(string: "boy"))
let yum = try DSON.convert(yuck, to: [String].self)

// => ["apple", "boy"] of type: Array<String>
```

You can of course turn json back into objects: 

```swift
class Fish: Class {
    var bool: Bool?
    var float: Float?
}

let a = try Fish.from(["bool": true, "float": 12.34])
}
```

