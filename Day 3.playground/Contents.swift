import Cocoa

// MARK: - Day 3
// Complex data types, Part 1

// MARK: - How to store ordered data in arrays

// You can store data in an array which allows you to gather data together in a single variable or constant
var beatles = ["John", "Paul", "George", "Ringo"]
// As you declared as a variable, you could mutate the actual state of the array by adding, removing or updating the value
beatles.append("Allen")

let numbers = [1, 2, 3, 4]
// numbers.append(5)
// This line will show an error due to it is a let (constant) and cannot be mutated

// You can access a given slot of the array if exists, just remember, in programming, it starts at 0
let one = numbers[0]

// You could update a value in a given index if exists
beatles[0] = "Jonh Lenon"
// Now we have the fist integrant updated with the name given

// You can remove a existing value from the array
let allen = beatles.remove(at: beatles.count - 1) // Count property returns the total number of items in the array
// OR
let ringo = beatles.popLast()
// In the ringo's case, as the array could be empty at some point, could be an optional,
// in other words, could not exists (safety first, thank you Swift!)

// You can insert a new integrant to the array at some given index
beatles.insert("Adrian", at: 1)
// Now the beatles have the following integrants: Jhon Lenon, Adrian, Paul and George

// If you want to know if some item is contained in the array, you use the contains() function
var cities = ["Florenze", "Rome", "Boston", "London", "La Habana"]

cities.contains("Rome")
// It will print true due to Rome IS contained in the array

// You can sort or get a sorted version of the array you are sorting
cities.sort()
// With shuffle we de organise the array again
cities.shuffle()
// NOTE: the two functions above only works with variables and not constants
let sortedCities = cities.sorted()
let suffledCities = sortedCities.shuffled()

// Or you could get a reverse version of the array, NOT SORTED, just inversed
cities.reverse()

// MARK: - How to store and find data in dictionaries

// A dictionary is a key-value storing data type that allows you to access a value with a given key if exist the key or the value, keep in mind that dictionaries unlike arrays, are unordered
let employee = [
    "name": "The Weeknd",
    "job": "Singer",
    "location": "Toronto"
]

// Due to the value or the key could not exist, the return type is an optional
let name = employee["name"]
let job = employee["job"]
let location = employee["location"]

let typoLocation = employee["locaton"]
// If you wanted to make it non-optional (not recomended) you could assign a default value
let typoName = employee["namee", default: "Uknown"]


// The keys could be of any type if that type conforms to Hashable in order to get a unique key
let olympics = [
    2008: "Beijing",
    2012: "London",
    2016: "Rio",
    2021: "Tokyo"
]

let tokyo = olympics[2021]

// By providing the key, you could update or delete a value from a dictionary
var alterEgos = [
    "Batman": "Bruce Wayne",
    "Superman": "Clark Kent",
    "Spiderman": "Peter Parker"
]

// Update
alterEgos["Spiderman"] = "Miles Morales"
// Delete
alterEgos["Superman"] = nil
// Now alterEgos dictionary contains ["Batman": "Bruce Wayne", "Spiderman": "Miles Morales"]


// MARK: - How to use sets for fast data lookup

// Similar to dictionaries and unlike arrays, sets are unordered, but makes sure that every item is unique
var actors = Set<String>()
actors.insert("Denzel")
actors.insert("Tom")
actors.insert("Nicolas")
actors.insert("Samuel")

// As the actors set contains unique items in it, you can use the item itself to perform variuos functions
let denzel = actors.remove("Denzel")
let isTomThere = actors.contains("Tom")
let isertedTomAgain = actors.insert("Tom")

// If you wanted a sorted version of the set, you can use the sorted method
// that returns you an array of the type that the set contains
let sortedActors = actors.sorted()

actors.removeAll()

actors = ["Tom", "Hanks", "Tom", "Holland"]
// As the set has to contain unique elements, the concurrent items will be discarted
// This set will be: ["Tom", "Hanks", "Holland"]


// MARK: - How to create and use enums

// Enumerations are sets of named values we can create
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}
// In this way you avoid issues like typos or unwanted changes by limiting the options you really care of,
// and it is more oprimize due to Weekday will be rather stored as a 0 for monday case,
// rather than keep in memory the whole M,o,n,d,a,y word.

var day = Weekday.monday
// Due to Swift type inferance, you could skip the explicit type
day = .friday
