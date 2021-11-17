import Cocoa

// MARK: - Day 6

// MARK: - How to use a for loop for repeat work

let platforms = ["iOS", "macOS", "watchOS", "iPadOS", "tvOS"]

// Every time the platform advances to the next, starting for the first item, the block inside the for-in loop, will be triggered
for os in platforms {
    print(os)
}

// When using autocompletion code, with proper variable names, you could trigger a for-in completion code
for platform in platforms {
    print(platform)
}

// If you wanted to print a set of numbers, you could use a Range
for i in 1...12 {
    print("5 x \(i) = \(i * 5)")
}

// You could nest loops
for i in 1...10 {
    print("The \(i) table")
    for j in 1...10 {
        print(" \(i) x \(j) = \(i * j)")
    }
    print("--------------")
}

// Ranges could exclude the last number of a range, with closed range
for i in 0..<3 {
    print(i)
}


// MARK: - How to use a while loop to repeat work

var countdown = 10
// The while loop would be looping til it reaches the condition
while countdown > 0 {
    print(countdown)
    countdown -= 1
}
print("Kabunk!")


var roll = 0
while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}
print("Critical hit!")

// MARK: - How to skip loop items with break and continue

// When you use a continue keyword in a loop you specify that you want to stop the rest of the work inside the loop, but continue with the next iteration as normal
let filenames = ["some.jpg", "another.mp3", "finally.jpg"]
for filename in filenames {
    if !filename.hasSuffix(".jpg") {
        continue
    }
    print("Picture found: \(filename)")
}

// Unlike continue, break keyword indicates that you want to skip the work from the point you placed the break and exit immediately
let n1 = 4
let n2 = 14
var multiples = [Int]()
for number in 1...100_000 {
    if number.isMultiple(of: n1) && number.isMultiple(of: n2) {
        multiples.append(number)
        if multiples.count == 10 {
            break
        }
    }
}
print(multiples)

// MARK: - Summary: Conditions and loops

/*
 - We use if, else, and else if statements to check conditions
 - We cand combine contitions using || (or) and && (and)
 - Switch statements can be easier than if and Swift will check that are exhaustive
 - The ternary conditional operator let us check WTF: What?, True, Flase.
 - For loops let us loop over arrays, sets, dictionaries and ranges.
 - While loops create loops that continue running until a condition is false.
 - We can skip loop items using continue and break.
 */

// MARK: - Checkpoint 3

/*
 Fizz Buzz
 Loop from 1 to 100 and for each number:
 - If multiple of 3, print Fizz
 - If multiple of 5, print Buzz
 - If mutiple of 3 and 5, print Fizz Buzz
 - Otherwise, just print the number
 */

for number in 1...100 {
    if number.isMultiple(of: 3) && number.isMultiple(of: 5) {
        print("Fizz Buzz")
        continue
    }
    if number.isMultiple(of: 3) {
        print("Fizz")
        continue
    }
    if number.isMultiple(of: 5) {
        print("Buzz")
        continue
    }
    print(number)
}

for number in 1...100 {
    if number.isMultiple(of: 3) {
        if number.isMultiple(of: 5) {
            print("Fizz Buzz")
            continue
        }
        print("Fizz")
        continue
    }
    if number.isMultiple(of: 5) {
        print("Buzz")
        continue
    }
    print(number)
}
