import UIKit

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
    }
    
    func printInfo() {
        print("First Name:  \(firstName)")
    }
}

var newPerson = Person()

newPerson.firstName = "준"
newPerson.lastName = "소"
newPerson.age = 25

newPerson.changeFirstName(newFirstName: "Joon")
