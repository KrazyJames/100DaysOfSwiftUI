import Cocoa

// MARK: - Day 10: Structs, Part 1

// MARK: - How to create your own structs

// Swift let us create our own types with custom properties and functions

// By standard, structs should start with capital letter
struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title), \(year) by \(artist)")
    }
}

let starboy = Album(title: "Starboy", artist: "The Weeknd", year: 2016)
let blindingLights = Album(title: "Blinding Lights", artist: "The Weeknd", year: 2020)

print(starboy.title)
starboy.printSummary()
blindingLights.printSummary()


struct Employee {
    let name: String
    var vacationRemaining: Int
    
    // This function cant "mutate" the constant we are trying to change, we move it to be a var first, in that case, we use mutating keyword to let Swift know that this function will mutate the state of this struct
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

// And in order to use the mutating function, we must declare the struct as variable, becase would be copy and re assigned in the same variable, thats why cant be a constant
var archer = Employee(name: "Archer", vacationRemaining: 14)
// Structs creates, silently, a init function, to create the object, using the parameter declared in the struct

archer.takeVacation(days: 5)
print(archer.vacationRemaining)

// You could provide a default value in the initializer by adding a default value in the variable declaration
struct Employeer {
    let name: String
    var vacationRemaining: Int = 30
    var employees: [Employee]
    
    func provideVacationToEmployee(at index: Int, for days: Int) {
        var employee = employees[index]
        employee.takeVacation(days: days)
    }
}

let employeer = Employeer(name: "General", employees: [Employee(name: "Employee", vacationRemaining: 14)])

employeer.provideVacationToEmployee(at: 0, for: 3)


// MARK: - How to compute property values dynamically

// Structs can have two kind of properties:
// STORED Properties which are variables or constants that hold a piece of data inside
// COMPUTED Properties which recalculates their value every time are accessed

struct Employeee {
    let name: String
    var vacation = 14
    var vacationTaken = 0
    
    // This property is recalculated every time is accessed
//    var vacationRemaining: Int {
//        vacation - vacationTaken
//    }
    var vacationRemaining: Int {
        get {
            vacation - vacationTaken
        }
        set {
            // The set comes with a newValue that was set
            vacation = vacationTaken + newValue
        }
    }
}

var employeee = Employeee(name: "Other Employeee")
//employeee.vacationTaken += 4
//print(employeee.vacationRemaining)
//employeee.vacationTaken += 3
//print(employeee.vacationRemaining)

// With getter and setter we could modify them directly in the computed property
employeee.vacationTaken += 4
employeee.vacationRemaining = 5
print(employeee.vacation)

// MARK: - How to take action when a property changes

// Swift let us observe a property's change, didSet when the value changed, and willSet, when the value is about to be changed

struct Game {
    var score = 0 {
        didSet {
            print("Score: \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score += 16

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value is: \(newValue)")
        }
        didSet {
            print("There are \(contacts.count) contacts")
            print("Old value was: \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian")
app.contacts.append("Allen")
app.contacts.append("M")

// NOTE: DO NOT OVERLOAD PROPERY OBERSERVERS FUNCTIONS


// MARK: - How to create custom initializers

struct Player {
    let name: String
    let number: Int
}
//  Swift calls this the memberwise initializer, which is a fancy way of saying an initializer that accepts each property in the order it was defined.
let player = Player(name: "Messi", number: 10)

struct Student {
    let name: String
    let className: String
    
    init(name: String, classNumber: Int) {
        self.name = name
        self.className = String(classNumber)
    }
}
