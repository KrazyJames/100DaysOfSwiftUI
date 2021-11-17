import Cocoa

// MARK: - Day 1
// Simple data types, Part 1

// How to create variables and constants

// Variables allows you to declare a site to store a piece of data, but also allows you to change its content over time
var greeting = "Hello, world!"
greeting = "Hello there"
greeting = "General Kenobi"

// Constants also allows you to declare variables, but does not allow you to change its content, making it safer when you do not really want to change a constant
let pi = "3.1416"
// The following line shows an error: "Cannot assign to value: 'name' is a 'let' constant"
//pi = "Other value here"

// How to create Strings

// You could enter whatever string value you want to put in.
let quote = "Then he tapped a sign saying Believe and walked away."
let quoteWithDoubleQuoteMarks = "Then he tapped a sign saying \"Believe\" and walked away."
// This will print "Then he tapped a sign saying "Believe" and walked away."

// You could declare a string in multiple lines
let anotherQuote = """
You only live once,
but if you do it right,
once is enough.
"""

// Also lets you include emojis
let result = "You Win! 👌🏽"
// And lets you know how many characters it contains (spaces included)
let letters = result.count

// How to store whole numbers (Integers)

let number1 = 1

// You could use underscore to add readability, Swift ignores those underscores
let oneThousad = 1_000
let oneMillion = 1_000_000

// You can use the +, -, *, / operators in order to work with operations
let two = 1 + 1
let five = 10 - 5
let twenty = 2 * 10
let six = 12 / 2

// And if you want to store and assign a value from a opertion, use the compound assignment operators +=, -=, *=, /=
var counter = 0
counter += 2 // Counter is 2
counter -= 10 // Counter is -8
counter *= 8 // Counter is -64
counter /= 64 // Counter is -1

// You can use the Int functionalities
120.isMultiple(of: 3)

// How to store decimal numbers

// Floating point numbers such as 1.23 or the value of Pi, are handled by Float or Doubles values

var myDouble = 2.4

var floatPi = Float.pi

// Swift does not allow you to mix floating point numers and integers unless you say it
var sum = 1 + myDouble
var anotherSum = floatPi + Float(myDouble)
