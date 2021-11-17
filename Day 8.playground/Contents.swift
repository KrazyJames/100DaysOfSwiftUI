import Cocoa

// MARK: - Day 8
// Functions, Part 2

// MARK: - How to provide default values for parameters

// Swift let us provide default values for the parameter in a function's arguments
func printTableOf(for number: Int, end: Int = 10) {
    for i in 1...end {
        print("\(i) x \(number) = \(i * number)")
    }
}
printTableOf(for: 5)
printTableOf(for: 5, end: 12)

// For example, array's removeAll function use a default value of false to the keepingCapacity, which means that the array's capacity, in this case of 4, is kept in memory
var characters = ["Lana", "Pam", "Ray", "Starling"]
print(characters.count)
characters.removeAll(keepingCapacity: true)
print(characters.count)


// MARK: - How to handle error in functions

// This takes 3 steps:
/*
 1. Telling Swift about the possible errors that can happen
 2. Writing a function that can flag up errors if they happen
 3. Calling that function, and handling any errors that might happen
 */

// 1. We tell Swift the possible errors with the Error protocol
enum PasswordError: Error {
    case short, obvious
}

// 2. Write the function that flag up the errors
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 { throw PasswordError.short }
    if password == "12345" { throw PasswordError.obvious }
    if password.count < 8 {
        return "Ok"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent!"
    }
}

// 3. Call that function and handle the error, which involves 3 more steps:
/*
 1. Start a block of code that might throw errors using 'do' keyword
 2. Calling one or more throwing functions with 'try' keyword
 3. Handling any thrown errors using 'catch' keyword
 */

do {
    let result = try checkPassword("123")
    print(result)
} catch {
    print("Handle errors here")
}

// You could handle specific errors or multiple of them with more catch blocks or use the default case
do {
    let result = try checkPassword("1234")
    print(result)
} catch PasswordError.short {
    print("Password too short")
} catch PasswordError.obvious {
    print("Password too obvious")
} catch {
    print(error.localizedDescription)
}

// MARK: - Summary: Functions

/*
 - Functions let us reuse code by carving off chunks and giving it a name
 - Functions start with func keyword, followed by the function's name
 - Functions can accept parameters to control their behavoir
 - You can add custom external parameter names, or use underscore _ to skip them
 - Function parameters can have a default value for common scenarios
 - Functions can optionally return a value, but you can return multiple pieces of data from a function using a tuple, which you could provide variable names and it has a specific size in
 - Functions can throw errors, which can be defined with a enum, using do, try, and catch.
 */

// MARK: - Checkpoint 4

/*
 Write a function that accept an integet parameter from 1 through 10.000 and returns the integer square root of that number.
 - You cant use the built sqrt() func or similar, you need to find the square root yourself
 - If the number is less than 1 or greater than 10,000 you should throw an "out of bounds" error.
 - You should only consider integer square roots.
 - If you cant find the square root, throw a no root error
 */

// 1. We tell Swift the possible errors with the Error protocol
enum SquareRootError: Error {
    case outOfBounds, noRoot
}

// 2. Write the function that flags up the error
func getRoot(from number: Int) throws -> Int {
    if number < 1 || number > 10_000 {
        throw SquareRootError.outOfBounds
    }
    for i in 1...100 {
        let square = i * i
        if number == square {
            return i
        }
    }
    throw SquareRootError.noRoot
}

// 3. Call that function and handle the error
let numbers = [0, 5, 9, 10_001]
for number in numbers {
    do {
        let root = try getRoot(from: number)
        print("√\(number) = \(root)")
    } catch SquareRootError.outOfBounds {
        print("\(number) is less than 1 or greater than 10,000")
    } catch SquareRootError.noRoot {
        print("\(number) has not an integer square root")
    }
}
