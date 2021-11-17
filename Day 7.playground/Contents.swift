import Cocoa

// MARK: - Day 7
// Functions, Part 1

// MARK: - How to reuse code with functions

// Functions are chunks of code to reuse it with a name and receives parameters or arguments
func greeting() {
    print("Hello!")
}

greeting()

// You could ask for arguments in the parenthesis, which will be constants
func isOvenOrOdd(number: Int) {
    if number.isMultiple(of: 2) {
        print("Even")
    } else {
        print("Odd")
    }
}

isOvenOrOdd(number: 3)

// MARK: - How to return values from functions

// Some functions send you back values from the inside function using the return keyword
func rollDice() -> Int {
    return Int.random(in: 1...6)
}
let result = rollDice()

// When a function that returns a value, only has a single line, you could skip the return keyboard and Siwft will infere that the function is returning the result gotten
func containsSameLetters(word1: String, word2: String) -> Bool {
    word1.sorted() == word2.sorted()
}
let areEqual = containsSameLetters(word1: "", word2: "")

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(pow(a, 2) + pow(b, 2))
}
let c = pythagoras(a: 3, b: 4)


// MARK: - How to return multiple values from functions

// Swift has a solution when of returning multiple values from functions we talk, using Tuples
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Abel", lastName: "Tesfaye")
}
let user = getUser()
print("\(user.firstName) \(user.lastName)")

// Or you could use the destructuring version
let (firstName, lastName) = getUser()
print("\(firstName) \(lastName)")

// If you only want one single item from the tuple, you could use underscore to skip the ones you dont need
let (_, lastname) = getUser()
print(lastname)


// MARK: - How to customize parameter labels

// You could skip the label of a function
func printTableOf(_ number: Int) {
    for i in 1...10 {
        print("\(i) x \(number) = \(i * number)")
    }
}

printTableOf(5)

// Or you could provide a internal label (parameter name) and external label (argument label)
func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Jane")
