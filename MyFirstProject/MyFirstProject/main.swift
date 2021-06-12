//
//  main.swift
//  MyFirstProject
//
//  Created by KPUGAME on 2021/03/07.
//

import Foundation

var guess = 7

let answer = randomIntBetween(low: 1, high: 100)

while(true){
    //let answer = randomIntBetween(low: 1, high: 100)
    
    print("Enter a number between 1 and 100.")
    
    let userInput = input()
    
    let inputAsInput = Int(userInput)
    
    if let guess = inputAsInput {
        if(guess > answer){
            print("Lower!")
        } else if(guess < answer) {
            print("Higher!")
        } else {
            print("Correct! The number was \(answer).")
        }
    }
}
