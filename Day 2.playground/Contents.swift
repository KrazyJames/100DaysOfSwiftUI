import Cocoa

// MARK: - Day 2
// Simple data types, Part 2

// How to store truth with Booleans

let goodDogs = true
let gameOver = false

let isMultiple = 120.isMultiple(of: 3)

// To flip the boolean value with the exclamation mark ! to say "not"
var isAuthenticated = true
isAuthenticated = !isAuthenticated
// Now isAuthenticated is "not", in other words, the opposite to true, in this case, false

// How to join Strings together

// You can build strings from other strings
let firstPart = "Hello, "
let secondPart = "World!"
let fullGreeting = firstPart + secondPart
// In this case, the plus + symbol is used to concatenate the strings in one single string from the "addition" of the first two strings

// You could use "String interpolation" to insert a string into another when assigning it
let doubleQuotedPart = "Believe"
let quoteInterpolated = "Then he tapped a sign saying \"\(doubleQuotedPart)\" and walked away."
// This will print "Then he tapped a sign saying "Believe" and walked away."

// You could use both, the string interpolation and the concatenation
let apolloNumer = 11
let missionMessage = "Apollo " + "\(apolloNumer)" + " landed on the moon in 1969"
// But in that case would be more readable use the interpolation only
let interpolatedMissionMessage = "Apollo \(apolloNumer) landed on the moon in 1969"

// MARK: - Summary: Simple Data
/*
 - Swift let us create constants using "let", and variables using "var"
 - Swift's strings containt text
 - You create strings by using double quotes at the start and end
 - Swift calls its whole numbers "Integers" or "Int"
 - In Swift, decimal numbers are called "Double"
 - You can store a simple true or false using a Boolean or "Bool"
 - String interpolation lets us place data into strings directly
 */

// MARK: - Checkpoint 1
/*
 - Create a constant olding any temperature in Celsius
 - Converts that tempreature to Fahrenheit by multiplying by 9, dividing by 5, then adding 32
 - Prints the result, showing both, the Celsius and Fahrenheit values
 */

let celsius = 27.0

let fahrenheit = celsius * 9 / 5 + 32

print("\(celsius)℃ are \(fahrenheit)℉")
