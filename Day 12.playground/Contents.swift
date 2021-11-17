import Cocoa

// MARK: - Day 12: Classes

// Classes are pretty similar to structs, they are created similar and keep properties and methods
// Classes introduce a new, important, and complex feature called inheritance, which is the ability to make one class build on the foundations of another.

// MARK: - How to create your own classes

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10


// MARK: - How to make one class inherit from another

class Employee {
    let hours: Int
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day")
    }
}

class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    // You could override functionality from parent class
    override func printSummary() {
        print("As a developer I code for \(hours) hours, but I take a couple for code reviewing.")
    }
}

// If you are sure you wont inherit from a class, you should mark it as final
final class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let manager = Manager(hours: 8)
let developer = Developer(hours: 6)

manager.printSummary()
developer.work()

// MARK: - How to add initializers for classes

class Vehicle {
    let isElectric: Bool
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

// You should, if you are useing inheritance, provide a super class initialization
class Car: Vehicle {
    let isConvertible: Bool
    init(isConvertible: Bool, isElectric: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let tesla = Car(isConvertible: false, isElectric: true)

// MARK: - How to copy classes

// All capies of a class always point to a single data source, thats why their are 'reference type' while structs are 'value type' because you copy the actual object in another real copy

class User {
    var username = "Anonymous"
    
    // Use this function to make a new fresh copy from the actual
    func copy() -> User {
        let newUser = User()
        newUser.username = username
        return newUser
    }
}

var user1 = User()
var user2 = user1
user2.username = "TheWeeknd"
var user3 = user1.copy()
user3.username = "KrazyJames"

print(user1.username)
print(user3.username)
print(user2.username)


// MARK: - How to create a deinitializer for a class

// Unlike structs, classes support optionally a deinit function, which takes no parameter, cannot be called and it's triggered by the system as needed (when the final copy that points to it, is removed).

class Student {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("Student \(id) is alive")
    }
    
    deinit {
        print("Student \(id) is dead")
    }
}

for i in 1...3 {
    let student = Student(id: i)
    print("Student \(student.id) is on now")
}

// MARK: - How to work with variables inside classes

class FacebookUser {
    var name = "Jaime"
}

// Even though we declared a constant, its variables can be modified
let jaime = FacebookUser()
jaime.name = "Jose"
print(jaime.name)

class TwitterUser {
    var account = "@JaimeEscobarMtz"
}

var twitter = TwitterUser()
twitter.account = "@twostraws"
print(twitter.account)
twitter = TwitterUser()
print(twitter.account)


// MARK: - Summary: Classes

/*
 CLASSES have lots of things in COMMON with STRUCTS, including the ability to have PROPERTIES and METHODS, but there are five key differences between classes and structs.
 - First, classes can INHERIT from other classes, which means they get access to the properties and methods of their PARENT class. You can optionally OVERRIDE methods in child classes if you want, or mark a class as being FINAL to stop others subclassing it.
 - Second, Swift DOESN'T generate a MEMBERWHISE INIT for classes, so you need to do it yourself. If a subclass has its own initializer, it must always call the PARENT class’s INIT at some point.
 - Third, if you create a class instance then take copies of it, all those copies point back to the SAME instance. This means changing some data in one of the copies changes them ALL.
 - Fourth, classes can have DEINITs that run when the LAST COPY of one instance is DESTROYED.
 - Finally, variable properties inside class instances can be CHANGED regardless of whether the instance itself was created as variable or constant.
 */

// MARK: - Checkpoint 7

/*
 Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.
 
 - The Animal class should have a legs integer property that tracks how many legs the animal has.
 - The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
 - The Cat class should have a matching speak() method, again with each subclass printing something different.
 - The Cat class should have an isTame Boolean property, provided using an initializer.
 */

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }
    func speak() {
        print("Bark!")
    }
}

class Corgi: Dog {
    override func speak() {
        super.speak()
    }
}

class Poodle: Dog {
    override func speak() {
        print("Fluffy bark!")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("Meow!")
    }
}

class Persian: Cat {
    init() {
        super.init(isTame: true)
    }
    override func speak() {
        super.speak()
    }
}

class Lion: Cat {
    init() {
        super.init(isTame: false)
    }
    override func speak() {
        print("Roar!")
    }
}

let monkey = Animal(legs: 2)
let dog = Dog()
let corgi = Corgi()
let poodle = Poodle()
let cat = Cat(isTame: true)
let persian = Persian()
let lion = Lion()

var animals: [Animal] = [monkey, dog, corgi, poodle, cat, persian, lion]
var dogs: [Dog] = [dog, corgi, poodle]
var cats: [Cat] = [cat, persian, lion]

for animal in animals {
    print(animal.legs)
}

for doggy in dogs {
    doggy.speak()
}

for kitty in cats {
    kitty.speak()
    print(kitty.isTame)
}


