import Cocoa

// MARK: - Day 14: Optionals

// MARK: - How to handle missing data with optionals

// Swift likes to be predictible, optionals ara basically whether there is a value or not

let opposites = ["Mario": "Wario", "Luigi": "Waluigi"]
let peachOpposite = opposites["Peach"]

// Any kind of data could be optinal, so we could get a String? which is optional, because might not be there, resulting on a nil (Swift's null)

// If the optional has a value in it, it will execute the body
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

var username: String?

if let unwrappedName = username {
    print("User: \(unwrappedName)")
} else {
    print("Optional was empty")
}

func square(number: Int) -> Int {
    number * number
}

var number: Int?

// Maybe could be a little confusing, but Swift is capable of differentiate the unwrapped variable or constant and use it inside the unwrapping block, it is called, SHADOWING
if let number = number {
    print(square(number: number))
}

// MARK: - How to unwrap optionals with guard

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }
    // The next line would be executed only if the guard unwrapping success
    print(number * number)
}

/*
 - Siwft requires you to use return if a guard check fails
 - If the optional you're unwrapping has a value, you can use it after the guard code.
 */

// MARK: - How to unwrap optionals with nil coalescing

let capitans = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

// With nil coalescing we could provide a default value
let new = capitans["Serenity"] ?? "N/A"

let tvShows = ["What if...?", "TWD"]
let favorite = tvShows.randomElement() ?? "None"

struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "Some title", author: nil)
let author = book.author ?? "Anonymous"
print(author)

// MARK: - How to handle multiple optionals using optional chaining

let names = ["Rogers", "Barnes", "Carter", "Stark"]
// This will try to apply some sort of action in an optional, if exists, but if not, you have a nil coalescing
let chosen = names.randomElement()?.uppercased() ?? "No one"
print(chosen)

let book2: Book? = nil
let author2 = book2?.author?.first?.uppercased() ?? "A"
print(author2)

// MARK: - How to handle function failure with optionals

enum UserError: Error {
    case badID, networkError
}

func getUser(id: Int) throws -> String {
    throw UserError.networkError
}

// If an error is thrown, it will be a nil, so it will try to unwrap it, but you wont be able to know what error was thrown
if let user = try? getUser(id: 23) {
    print(user)
}

// MARK: - Summary: Optionals

/*
 - Optionals let us represent the absence of data
 - Anything that is not optional, definitely has a value
 - Unwrapping an optional is the process of looking inside the optional to determine if there is a value or nil
 - We can use if let to run some code if the optional has a value, or guard let to run some code if the optional does not have a value
 - The nil coalescing operator, ??, unwraps and returns an optional’s value, or uses a default value instead
 - Optional chaining lets us read an optional inside another optional with a convenient syntax
 - If a function might throw errors, you can convert it into an optional using try? – you’ll either get back the function’s return value, or nil if an error is thrown
 */

// MARK: - Checkpoint 9

/*
 Write a function in one line that
 - accepts an optional array of integers, and
 - returns one randomly.
 - If the array is missing or empty, return a random number in the range 1 through 100.
 */

func randomNumber(from numbers: [Int]?) -> Int {
    numbers?.randomElement() ?? Int.random(in: 1...100)
}

let randomNumber1 = randomNumber(from: nil)
let randomNumber2 = randomNumber(from: [])
let randomNumber3 = randomNumber(from: [1, 2, 3, 4])
