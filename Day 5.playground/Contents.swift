import Cocoa

// MARK: - Day 5

// MARK: - How to check a condition is true or false

let score = 85

// IF statements accepts Booleans to check the condition, for that reason we use comparative operators

// Greater than
if score > 80 {
    print("Good job!")
}

// Less than
if score < 60 {
    print("You failed!")
}

// Greater than or equal to (here you INCLUDE the value you are comparing against to)
if score >= 101 {
    print("You are in 101 or above")
}

// Less than or equal to (here you INCLUDE the value as in the example above)
if score <= 100 {
    print("You are in the scale")
}


let city = "Rome"

// Equals to
if city == "Rome" {
    print("You are in Rome")
}

// Different to
if city != "Rome" {
    print("You are NOT in Rome")
}


// MARK: - How to check multiple conditions

let age = 16

// In order to avoid to check multiple conditions individually, you could group them with else statement
if age >= 18 {
    print("You can vote")
} else {
    print("You can not vote")
}

// If you wanted to include more scenarios, just nest them
let temp = 25

if temp > 20 {
    print("It's okey out there")
} else if temp < 15 {
    print("It's cold out there")
} else if temp < 0 {
    print("It's freezing out there")
}

// But if you want to combine conditions, you can use AND (&&) and OR (||) operators
if temp >= 20 && temp <= 30 {
    print("It's nice out there")
}

if temp <= 0 || temp >= 40 {
    print("It isn't a good day")
}

// You could use the same logic with enumerations
enum TransportOption {
    case airplane, helicopter, boat, submarine, vehicle, bicycle
}

let transport = TransportOption.airplane

if transport == .airplane || transport == .helicopter {
    print("Let's fly")
} else if transport == .boat || transport == .submarine {
    print("Let's go to the sea")
} else {
    print("Land option would be fine to me")
}

// MARK: - How to use switch statements to check multiple conditions

// You could avoid all the if-else statement nested with the using of Switch statement which will make sure you only check each case once and you can not skip them, switch should be exhaustive, you need to cover all cases
enum Weather {
    case sunny, rainny, windy, snowy, uknown
}

var forecast = Weather.sunny

switch forecast {
case .sunny:
    print("Have a nice day")
case .rainny:
    print("Maybe you should pick an umbrella")
case .windy:
    print("Wear something warm")
case .snowy:
    print("School is cancelled")
case .uknown:
    break
}
// Break statement breaks the switching action by returning nothing when a case is reached

// If you wanted to avoid to cover any of them, you could use a default statement, preferred to use at the very end, to cover real cases where you may need to cover.
switch forecast {
case .sunny:
    print("Nice day!")
default:
    break
}

// If you wanted to cover more than one case, you want to fall through them
forecast = .windy
switch forecast {
case .sunny:
    print("Have a nice day")
case .rainny:
    print("Maybe you should pick an umbrella")
case .windy:
    fallthrough
case .snowy:
    print("Wear something warm")
case .uknown:
    break
}

// Or you can cover multiple options with one action
switch forecast {
case .sunny:
    print("Have a nice day")
case .rainny:
    print("Maybe you should pick an umbrella")
case .windy, .snowy:
    print("Wear something warm")
case .uknown:
    break
}
// Its like making an OR between windy and snowy forecast, because both are resulting the same

// MARK: - How to use the ternary conditional operator for quick tests

// Gets the name ternary operator because it acts between 3 components
// Normally a operator like + acts between 2 component (like 2 + 5)

let canVote = age >= 18 ? true : false
// This can be read as What? True / False (or WTF)

let names = ["Jane", "Kayle"]

let namesCount = names.isEmpty ? "No one" : "\(names.count) people"

enum Theme {
    case light, dark, system
}

let theme = Theme.dark

let background = theme == .dark ? "black" : "white"
