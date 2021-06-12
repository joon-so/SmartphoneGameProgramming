import UIKit

func randomIntBetween(low:Int, high:Int) -> Int {
    let range = high - (low - 1)
    return (Int(arc4random()) % range) + (low - 1)
}

let answer = randomIntBetween(low: 1, high: 100)

print("Enter a number between 1 and 100.")

var guess = 7

if(guess > answer){
    print("Lower!")
} else if(guess < answer) {
    print("Higher!")
} else {
    print("Correct! The number was \(answer).")
}
