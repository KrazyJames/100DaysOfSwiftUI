import Cocoa

// MARK: - Day 11: Structs, part 2

// MARK: - How to limit access to internal data using access control

// You could declare the level of access a property could have
// With private keyword you set an access control that dont let anything outside the struct use the variable
// With fileprivate you dont let anything outside the current file use this
// With public you let anyone, anywhere use this, this is the default when not set
// private(set) let externals to read the property, but it can only be written internally
struct BankAccount {
    private var founds = 0
    
    mutating func deposti(amount: Int) {
        self.founds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if amount > founds {
            return false
        } else {
            founds -= amount
            return true
        }
    }
}

// MARK: - Static properties and methods

// With static properties or methods you wont need to declare a new object from a struct, just to call directly from it

struct School {
    static var studentCount = 0
    // Only static functions could call static properties directly, a non-static function could not access as internal, should specify the type or use Self
    static func add(student: String) {
        print("\(student) joined the school")
        Self.studentCount += 1
    }
}

// This way, it only exists one School to work with
School.add(student: "Kevin")
print(School.studentCount)

// It is also used when sampling
struct Employee {
    let name: String
    let pass: String
    
    static let sample = Employee(name: "Federighi", pass: "CoolHairPower")
}

print(Employee.sample)

// MARK: - Summary: Structs

/*
 Let’s recap what else we learned:

 - You can create your own structs by writing 'struct', giving it a name, then placing the struct’s code inside braces.
 - Structs can have variable and constants (known as properties) and functions (known as methods)
 - If a method tries to modify properties of its struct, you must mark it as 'mutating'.
 - You can store properties in memory, or create computed properties that calculate a value every time they are accessed.
 - We can attach didSet and willSet property observers to properties inside a struct, which is helpful when we need to be sure that some code is always executed when the property changes.
 - Initializers are a bit like specialized functions, and Swift generates one for all structs using their property names.
 - You can create your own custom initializers if you want, but you must always make sure ALL properties in your struct have a value by the time the initializer finishes, and before you call any other methods.
 - We can use access to mark any properties and methods as being available or unavailable externally, as needed.
 - It’s possible to attach a property or methods directly to a struct using STATIC, so you can use them without creating an instance of the struct.
 */

// MARK: - Checkpoint 6

/*
 Create a struct to store info about a car
 - Its model
 - Number of seats
 - Current gear
 - Add a method to change gears up or down
 - Have a think about variables and access control
 - Dont allow invalid gears 1...10 seams a fair max range
 */

enum CarError: Error {
    case maxGear, minGear
    
    var description: String {
        switch self {
        case .maxGear:
            return "Maximum gear reached"
        case .minGear:
            return "Minimum gear reached"
        }
    }
}

struct Car {
    let model: String
    let seats: Int
    private(set) var currentGear: Int = 1 {
        didSet {
            print(currentGear)
        }
    }
    static let maxGear = 10
    static let minGear = 1
    
    mutating func gearUp() throws {
        if currentGear < Self.maxGear {
            currentGear += 1
        } else {
            throw CarError.maxGear
        }
    }
    
    mutating func gearDown() throws {
        if currentGear > Self.minGear {
            currentGear -= 1
        } else {
            throw CarError.minGear
        }
    }
}

var tesla = Car(model: "S", seats: 4, currentGear: 8)

do {
    try tesla.gearUp()
    try tesla.gearUp()
    try tesla.gearUp()
} catch CarError.minGear {
    print(CarError.minGear.description)
} catch CarError.maxGear {
    print(CarError.maxGear.description)
}
