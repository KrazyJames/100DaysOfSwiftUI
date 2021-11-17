import Cocoa

// MARK: - Day 4
// Complex data types, Part 2

// How to use Type annotations

// We were using type inferance, where Swiftt infere the type of data you are asigning to a variable or constant
let name = "Ezio"

// In this way, we explicitly tell to Swift what kind of data we want to store in a given variable or constant
var isMaster: Bool = false
var age: Int = 42

// The same can be applied to Collections such arrays, dictonaries or sets
var sodas: [String] = ["Coke", "Pepsi", "Dr. Pepper"]
var teams: [String] = []
var cities: [String] = [String]()

var styles: [String: String] = [
    "font": "Arial",
    "backgroundColor": "black",
    "fontColor": "white"
]

var actors: Set<String> = []

// Or enumerations
enum UIStyle {
    case light, dark, system
}

var currentStyle: UIStyle = .system

// In constants using type annotations, you could assign the value later, but you have to do it or compiler will complaint about that
let username: String
username = "typeAnnotation"
// And this will be allowed, but you are not able to reassign it again, it's a constant


// MARK: - Summary: Complex data
/*
 - Arrays store many values, and read them using indices
 - Dictionaries store many values, and read them using keys we specify, are unordered
 - Sets store many values, but we don't choose their order and should be unique
 - Enums create our own types to specify a range of acceptable values
 - Swift uses type inference to figure what data we're storing
 - It's also possible to use type annotation to force a particular type
 */

// MARK: - Checkpoint 2

/*
 - Create an array of strings, then write some code that prints the number of items in the array and also the number of unique items in the array.
 */

let places = ["Rome", "Boston", "Florence", "Rome", "London", "Tokyo", "Paris", "London"]
let uniquePlaces = Set(places)
print(places.count)
print(uniquePlaces.count)
