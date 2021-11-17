import Cocoa

// MARK: - Day 13: Protocols and extensions

// Protocols are a kind of contract in which you define a set of rules that a struct that conforms that contract, must fulfill

// Functions in a protocols have no body or implementation due to they are the contract with the requirements
protocol Vehicle {
    var name: String { get }
    var currentPassangers: Int { get set }
    // NOTE: Protocol's properties requierements could not be set-only
    func eta(for distance: Int) -> Int
    func travel(distance: Int)
}

// Once a struct conforms a protocol, it must fulfill the requirements, but you could add more functionality or properties
struct Car: Vehicle {
    var name: String = "Car"
    
    var currentPassangers: Int = 1
    
    func eta(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("Driving \(distance)")
    }
    
    func openSunroof() {
        print("It's a nice day!")
    }
}

struct Bicycle: Vehicle {
    var name: String = "Bicycle"
    
    var currentPassangers: Int = 1
    
    func eta(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print("I'm cycling \(distance)")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.eta(for: distance) >= 10 {
        print("Thats too slow")
    } else {
        vehicle.travel(distance: distance)
    }
}

func travelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.eta(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)")
    }
}

let car = Car(currentPassangers: 3)
let bicycle = Bicycle()

let vehicles: [Vehicle] = [car, bicycle]

commute(distance: 100, using: car)
commute(distance: 100, using: bicycle)

travelEstimates(using: vehicles, distance: 100)


// MARK: - How to use opaque return types

// With the some keyword, you define that the function will return some type that conforms to a protocol, but you are hiding the real type, but Swift always knows it.
func getRandomInt() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomInt() == getRandomInt())

func getRandomVehicle() -> some Vehicle {
    Car()
}

let randomVehicle = getRandomVehicle()


// MARK: - How to create and use extensions

// Extensions allow us to add functionality to current types

var quote = "   The truth is rarely and never simple   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed()
    }
    
    // Extensions could have properties, but only computed ones.
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

print(quote.trimmed())
print(quote)
quote.trim()
print(quote)

let lyrics = """
I've been tryna call
I've been on my own for long enough
Maybe you can show me how to love,
maybe
"""

print(lyrics.lines.count)

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book {
    // If we declare a custom initializer in the extension rather than the actual struct, we wont loose the memberwhise initializer
    init(title: String, pages: Int) {
        self.title = title
        self.pageCount = pages
        self.readingHours = pages / 50
    }
}

let atomicHabits = Book(title: "Atomic Habits", pageCount: 306, readingHours: 1)

// MARK: - How to create and use protocol extensions

// You could extend a protocol to add the protocol implementation itself
extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print("Guests count: \(guests.count)")
}

let aSet = Set(guests)

if aSet.isNotEmpty {
    print("aSet contains \(aSet.count) values")
}

protocol Person {
    var name: String { get }
    func sayHello()
}

// This provides to all conformers to Person protocol a default implementation to it.
extension Person {
    func sayHello() {
        print("Hello, I'm \(name)")
    }
}

struct Employee: Person {
    var name: String
}

let patrick = Employee(name: "Patrick")
patrick.sayHello()

// MARK: - How to get the most from protocol extensions

extension Numeric {
    func squared() -> Self {
        self * self
    }
}

let wholeNumber = 5
print(wholeNumber.squared())

let decimalNumber = 2.5
print(decimalNumber.squared())

// Comparable inherits from Equatable, thats why we could remove it
struct User: /*Equatable,*/ Comparable {
    let name: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
}

let user1 = User(name: "Link")
let user2 = User(name: "Zelda")

print(user1 == user2)
print(user1 < user2)


// MARK: - Summary: Protocols and Extensions

/*
 - Protocols are like CONTRACTS for code: we specify the functions and methods that we REQUIRE, and conforming types must IMPLEMENT them.
 - Opaque return types let us HIDE some information in our code. That might mean we want to retain flexibility to change in the future, but also means we don’t need to write out gigantic return types.
 - Extensions let us ADD functionality to our own custom types, or to Swift’s built-in types. This might mean adding a method, but we can also add COMPUTED properties.
 - Protocol extensions let us add functionality to many types all at once – we can add properties and methods to a protocol, and ALL conforming types get access to them.
 */


// MARK: - Checkpoint 8
 /*
  Make a protocol that describes a building, House and Office
  - A property storing how many rooms
  - A property storing the cost as Int
  - A property storing the name of the state agent selling it
  - A method for printing the salses summary of the building
  */

protocol Building {
    var rooms: Int { get }
    var cost: Int { get set }
    var agent: String { get set }
    func summary()
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var agent: String
    
    func summary() {
        print("This house is a \(rooms) rooms building that costs \(cost), and it is sold by \(agent)")
    }
    
    mutating func addRoom() {
        rooms += 1
    }
}

struct Office: Building {
    let rooms: Int = 1
    var cost: Int
    var agent: String
    
    func summary() {
        print("This office is sold by \(agent) for \(cost)")
    }
}

let myHouse = House(rooms: 3, cost: 500_000, agent: "Linda Houses")
let office = Office(cost: 1_000_000, agent: "Nice Offices")

myHouse.summary()
office.summary()
