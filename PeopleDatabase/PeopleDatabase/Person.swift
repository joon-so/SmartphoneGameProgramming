//
//  Person.swift
//  PeopleDatabase
//
//  Created by KPUGAME on 2021/03/08.
//

import Foundation

class Person {
    var firstName = ""
    var lastName = ""
    var age = 0
    
    //키보드 입력을 박아서 String으로 변환
    func input() -> String {
      let keyboard = FileHandle.standardInput
      let inputData = keyboard.availableData
      let rawString = NSString(data: inputData, encoding:String.Encoding.utf8.rawValue)
      if let string = rawString {
        return string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
      } else {
        return "Invalid input"
      }
    }
    
    func changeFirstName(newFirstName: String) {
        firstName = newFirstName
    }
    
    func enterInfo() {
        print("What is the first name?")
        firstName = input()
        print("What is \(firstName)'s last name?")
        lastName = input()
        print("How old is \(firstName) \(lastName)")
        let userInput = Int(input())
        if let number = userInput {
            age = number
        }
    }
    
    func printInfo() {
        print("\(firstName) \(lastName) is \(age) years old.")
    }
}
