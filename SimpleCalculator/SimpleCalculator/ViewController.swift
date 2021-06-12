//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by KPUGAME on 2021/03/14.
//

import UIKit

class ViewController: UIViewController {
    var printNum : Float = 0
    var calculateOrder : [String] = []
    var numOrder : [Float] = []
    var calProcess : String = ""
    var dotCheck = false
    var dotStack : Int = 0
    
    var parentheses = false
    var parenthesesStart = 0
    var parenthesesEnd = 0
    
    @IBOutlet var result: UILabel!
    @IBOutlet var process: UILabel!

    @IBAction func num0(_ sender: Any) { resultChange(0) }
    @IBAction func num1(_ sender: Any) { resultChange(1) }
    @IBAction func num2(_ sender: Any) { resultChange(2) }
    @IBAction func num3(_ sender: Any) { resultChange(3) }
    @IBAction func num4(_ sender: Any) { resultChange(4) }
    @IBAction func num5(_ sender: Any) { resultChange(5) }
    @IBAction func num6(_ sender: Any) { resultChange(6) }
    @IBAction func num7(_ sender: Any) { resultChange(7) }
    @IBAction func num8(_ sender: Any) { resultChange(8) }
    @IBAction func num9(_ sender: Any) { resultChange(9) }
    
    func resultChange(_ a: Int) {
        if(!dotCheck){
            printNum = printNum * 10 + Float(a)
        }
        else {
            dotStack += 1
            printNum = printNum + Float(Float(a) / Float(Int(pow(Double(10), Double(dotStack)))))
        }
        calProcess.append(String(a))
        process.text = calProcess
    }

    //var operation = 0 // +1, -2, *3, /4
        
    @IBAction func Plus(_ sender: Any) { CalculateOrder(0) }
    @IBAction func Subtrack(_ sender: Any) { CalculateOrder(1) }
    @IBAction func Multiple(_ sender: Any) { CalculateOrder(2) }
    @IBAction func Divide(_ sender: Any) { CalculateOrder(3) }
    @IBAction func Result(_ sender: Any) { CalculateOrder(4) }
    @IBAction func Dot(_ sender: Any) { CalculateOrder(5) }
    @IBAction func ParenthesesStart(_ sender: Any) { CalculateOrder(6) }
    @IBAction func ParenthesesEnd(_ sender: Any) { CalculateOrder(7) }
    
    func CalculateOrder(_ order: Int) {
        switch(order)
        {
        case 0: // +
            dotCheck = false
            dotStack = 0
            numOrder.append(printNum)
            printNum = 0
            calProcess.append("+")
            calculateOrder.append("+")
            process.text = calProcess
            break
        case 1: // -
            dotCheck = false
            dotStack = 0
            numOrder.append(printNum)
            printNum = 0
            calProcess.append("-")
            calculateOrder.append("-")
            process.text = calProcess
            break
        case 2: // *
            dotCheck = false
            dotStack = 0
            numOrder.append(printNum)
            printNum = 0
            calProcess.append("x")
            calculateOrder.append("x")
            process.text = calProcess
            break
        case 3: // /
            dotCheck = false
            dotStack = 0
            numOrder.append(printNum)
            printNum = 0
            calProcess.append("/")
            calculateOrder.append("/")
            process.text = calProcess
            break
        case 4: // =
            numOrder.append(printNum)
            while (calculateOrder.count > 0) {
                CalPriority()
            }
            
            dotCheck = false
            dotStack = 0
            
            parentheses = false
            parenthesesStart = 0
            parenthesesEnd = 0
            
            result.text = String(numOrder[0])
            break
        case 5: // .
            if(dotCheck) {
                if(calProcess[calProcess.index(before: calProcess.endIndex)] == "."){
                    dotCheck = false
                    dotStack = 0
                    calProcess.remove(at: calProcess.index(before:       calProcess.endIndex))
                }
            }
            else {
                dotCheck = true
                calProcess.append(".")
            }
            process.text = calProcess
            break
        case 6: // (
            if(!parentheses){
                parentheses = true
                parenthesesStart = calculateOrder.count
                calProcess.append("(")
                process.text = calProcess
            }
            break
        case 7: // )
            calProcess.append(")")
            parenthesesEnd = calculateOrder.count - 1
            process.text = calProcess
            break
        default:
            break
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        dotCheck = false
        dotStack = 0
        printNum = 0
        calProcess = ""
        calculateOrder.removeAll()
        numOrder.removeAll()
        result.text = "0"
        process.text = ""
    }
    
    func CalPriority() {
        if(!parentheses) {
            for i in 0...calculateOrder.count - 1 {
                if(calculateOrder[i] == "x"){
                    let cal = numOrder[i] * numOrder[i + 1]
                    numOrder[i] = cal
                    calculateOrder.remove(at: i)
                    numOrder.remove(at: i + 1)
                    return
                }
                else if(calculateOrder[i] == "/"){
                    let cal = numOrder[i] / numOrder[i + 1]
                    numOrder[i] = cal
                    calculateOrder.remove(at: i)
                    numOrder.remove(at: i + 1)
                    return
                }
            }
            
            for i in 0...calculateOrder.count - 1 {
                if(calculateOrder[i] == "+"){
                    let cal = numOrder[i] + numOrder[i + 1]
                    numOrder[i] = cal
                    calculateOrder.remove(at: i)
                    numOrder.remove(at: i + 1)
                    return
                }
                else if(calculateOrder[i] == "-"){
                    let cal = numOrder[i] - numOrder[i + 1]
                    numOrder[i] = cal
                    calculateOrder.remove(at: i)
                    numOrder.remove(at: i + 1)
                    return
                }
            }
        }
        else {
            if(parenthesesStart == parenthesesEnd){
                parentheses = false
            }
            
            for i in parenthesesStart...parenthesesEnd {
                if(calculateOrder[i] == "x"){
                    let cal = numOrder[i] * numOrder[i + 1]
                    numOrder[i] = cal
                    calculateOrder.remove(at: i)
                    numOrder.remove(at: i + 1)
                    parenthesesEnd -= 1
                    return
                }
                else if(calculateOrder[i] == "/"){
                    let cal = numOrder[i] / numOrder[i + 1]
                    numOrder[i] = cal
                    calculateOrder.remove(at: i)
                    numOrder.remove(at: i + 1)
                    parenthesesEnd -= 1
                    return
                }
            }
            
            for i in parenthesesStart...parenthesesEnd {
                if(calculateOrder[i] == "+"){
                    let cal = numOrder[i] + numOrder[i + 1]
                    numOrder[i] = cal
                    calculateOrder.remove(at: i)
                    numOrder.remove(at: i + 1)
                    parenthesesEnd -= 1
                    return
                }
                else if(calculateOrder[i] == "-"){
                    let cal = numOrder[i] - numOrder[i + 1]
                    numOrder[i] = cal
                    calculateOrder.remove(at: i)
                    numOrder.remove(at: i + 1)
                    parenthesesEnd -= 1
                    return
                }
            }
        }
    }
}

