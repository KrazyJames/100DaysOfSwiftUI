import Cocoa

// MARK: - Day 9: Closures

// MARK: - How to create and use closures

// You could set a funtion into a variable
func greetUser() {
    print("Hi there!")
}
greetUser()
// When you assign the function, you dont call it, thats why there is no parenthesis
var greetCopy = greetUser
greetCopy()

// You can do it directly as well, put it inside the curly braces
let sayHello = { (name: String) -> String in
    "Hello, \(name)"
}
sayHello("Jhon")

// As other types like Int or String, function has its own type
// Where Void is just saying that you are not returning nothing, just the function itself
var someFunction: () -> Void = greetUser
// NOTE: Inside the parenthesis you can declare the parameter labels

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Abel Tesfaye"
    } else {
        return "Anonymous"
    }
}
let data: (Int) -> String = getUserData
let user = data(1989)
// There is no argument names for this kind of functions


let team = ["Gloria", "Rafael", "Luciano"]
let sortedTeam = team.sorted()
print(sortedTeam)
// As sorted has a version in which we could provide a sorting method as a function of type (String, String)->Bool, we could provide it as the following
func capitanFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Luciano" {
        return true
    } else if name2 == "Luciano" {
        return false
    }
    return name1 < name2
}

let capitanFirstTeam = team.sorted(by: capitanFirstSorted)
print(capitanFirstTeam)

// We could implement the closure inside the actual function
let sortedFirstCapitan = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Luciano" {
        return true
    } else if name2 == "Luciano" {
        return false
    }
    return name1 < name2
})

print(sortedFirstCapitan)


// MARK: - How to use trailing closures and shorthand syntax

// As the function requires a closure that has a specific syntax, you could omit the types, since those can be infered
let sortedTeamFirstCapitan = team.sorted { a, b in
    if a == "Luciano" {
        return true
    } else if b == "Luciano" {
        return false
    }
    return a < b
}

// Even shorter, you could omit the name of label with a shorthard syntax, using the arguments by position
let sortedTeamFirstCapitanShortHand = team.sorted {
    if $0 == "Luciano" {
        return true
    } else if $1 == "Luciano" {
        return false
    }
    return $0 < $1
}


let LOnly = team.filter { $0.hasPrefix("L") }
print(LOnly)

let upperCasedTeam = team.map { $0.uppercased() }
print(upperCasedTeam)


// MARK: - How to accept functions as parameters

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    return numbers
}

let newArray = makeArray(size: 50) {
    Int.random(in: 1...20)
}
print(newArray)

func numberGenerator() -> Int {
    Int.random(in: 1...20)
}

let rolls = makeArray(size: 50, using: numberGenerator)
print(rolls)


func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("First:")
    first()
    print("Second:")
    second()
    print("Third:")
    third()
}

doImportantWork {
    print("First work")
} second: {
    print("Second work")
} third: {
    print("Third work")
}

// MARK: - Summary: Closures
/*
 - You can copy function in Swift
 - Functions has a type
 - You can create closures directly by assigning to a constant o variable
 - Closure parameters and return value are declared inside their braces
 - Functions are able to accept other funcitons as parameters
 - Anywhere you can pass a function, you can also pass a closure
 - When passing a closure as a function parameter, you dont need to write out the types inside your closure if Swift can infere them.
 - If a function's final parameter are fuinctions, use trailing closure syntax
 - You can also use shorthand parameter names such as $0
 - You can make your own function that accept function as parameter
 */

// MARK: - Checkpoint 5
/*
 - Your input is an array of numbers
 - Your job is to filter out any numbers that are even
 - Sort ascending order
 - Map them to strings in format "7 is a lucky number"
 - Print the resulting array, one item per line
 */

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let results: [String] = luckyNumbers
    .filter {
        !$0.isMultiple(of: 2)
    }.sorted {
        $0 < $1
    }.map {
        "\($0) is a lucky number"
    }
for result in results {
    print(result)
}
