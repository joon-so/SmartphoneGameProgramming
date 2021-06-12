//
//  ViewController.swift
//  Yahtzee
//
//  Created by KPUGAME on 2021/05/09.
//

import UIKit

class ViewController: UIViewController {
    var roll : Int = 0
    var round : Int = 0
    var dice : [Int] = [1, 1, 1, 1, 1]
    var scores : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var used : [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false]
    var BonusScore : Int = 0
    var upperBonus : Bool = false
    var yahtzeeBonus : Bool = false
    
    @IBOutlet weak var OutletRollDice: UIButton!
    @IBOutlet weak var OutletDice1: UIButton!
    @IBOutlet weak var OutletDice2: UIButton!
    @IBOutlet weak var OutletDice3: UIButton!
    @IBOutlet weak var OutletDice4: UIButton!
    @IBOutlet weak var OutletDice5: UIButton!
    
    @IBAction func ActionRollDice(_ sender: Any) {
        if(OutletRollDice.isEnabled) {
            rollDice()
            switch (roll) {
            case 0, 1:
                roll += 1
                OutletRollDice.setTitle("Roll Again", for: UIControl.State.normal)
                OutletGameMessage.text = "간직할 주사위를 선택한 후 Roll Again 버튼을 누르세요."
                break
            case 2:
                roll = 0
                OutletGameMessage.text = "이제 남아있는 Category를 선택하세요"
                OutletRollDice.isEnabled = false
                round += 1
                break
            default:
                break
            }
        }
    }
    @IBAction func ActionDice1(_ sender: Any) {
        if(roll != 0) {
            OutletDice1.backgroundColor = UIColor.gray
            OutletDice1.isEnabled = false
        }
    }

    @IBAction func ActionDice2(_ sender: Any) {
        if(roll != 0) {
            OutletDice2.backgroundColor = UIColor.gray
            OutletDice2.isEnabled = false
        }
    }
    @IBAction func ActionDice3(_ sender: Any) {
        if(roll != 0) {
            OutletDice3.backgroundColor = UIColor.gray
            OutletDice3.isEnabled = false
        }
    }
    @IBAction func ActionDice4(_ sender: Any) {
        if(roll != 0) {
            OutletDice4.backgroundColor = UIColor.gray
            OutletDice4.isEnabled = false
        }
    }
    @IBAction func ActionDice5(_ sender: Any) {
        if(roll != 0) {
            OutletDice5.backgroundColor = UIColor.gray
            OutletDice5.isEnabled = false
        }
    }
    
    @IBOutlet weak var OutletCategory1: UIButton!
    @IBOutlet weak var OutletCategory2: UIButton!
    @IBOutlet weak var OutletCategory3: UIButton!
    @IBOutlet weak var OutletCategory4: UIButton!
    @IBOutlet weak var OutletCategory5: UIButton!
    @IBOutlet weak var OutletCategory6: UIButton!
    @IBOutlet weak var OutletUpperTotal: UIButton!
    @IBOutlet weak var OutletUpperBonus: UIButton!
    @IBOutlet weak var OutletCategory7: UIButton!
    @IBOutlet weak var OutletCategory8: UIButton!
    @IBOutlet weak var OutletCategory9: UIButton!
    @IBOutlet weak var OutletCategory10: UIButton!
    @IBOutlet weak var OutletCategory11: UIButton!
    @IBOutlet weak var OutletCategory12: UIButton!
    @IBOutlet weak var OutletCategory13: UIButton!
    @IBOutlet weak var OutletLowerTotal: UIButton!
    @IBOutlet weak var OutletGrandTotal: UIButton!
    
    @IBAction func ActionCategory1(_ sender: Any) {
        if(OutletCategory1.isEnabled) {
            scores[0] = upperScores(index: 1)
            used[0] = true
            OutletCategory1.setTitle(String(scores[0]), for: UIControl.State.normal)
            OutletCategory1.isEnabled = false
            OutletCategory1.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory2(_ sender: Any) {
        if(OutletCategory2.isEnabled) {
            scores[1] = upperScores(index: 2)
            used[1] = true
            OutletCategory2.setTitle(String(scores[1]), for: UIControl.State.normal)
            OutletCategory2.isEnabled = false
            OutletCategory2.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory3(_ sender: Any) {
        if(OutletCategory3.isEnabled) {
            scores[2] = upperScores(index: 3)
            used[2] = true
            OutletCategory3.setTitle(String(scores[2]), for: UIControl.State.normal)
            OutletCategory3.isEnabled = false
            OutletCategory3.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory4(_ sender: Any) {
        if(OutletCategory4.isEnabled) {
            scores[3] = upperScores(index: 4)
            used[3] = true
            OutletCategory4.setTitle(String(scores[3]), for: UIControl.State.normal)
            OutletCategory4.isEnabled = false
            OutletCategory4.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory5(_ sender: Any) {
        if(OutletCategory5.isEnabled) {
            scores[4] = upperScores(index: 5)
            used[4] = true
            OutletCategory5.setTitle(String(scores[4]), for: UIControl.State.normal)
            OutletCategory5.isEnabled = false
            OutletCategory5.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory6(_ sender: Any) {
        if(OutletCategory6.isEnabled) {
            scores[5] = upperScores(index: 6)
            used[5] = true
            OutletCategory6.setTitle(String(scores[5]), for: UIControl.State.normal)
            OutletCategory6.isEnabled = false
            OutletCategory6.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory7(_ sender: Any) {
        if(OutletCategory7.isEnabled) {
            scores[6] = scoreThreeOfAKind()
            used[6] = true
            OutletCategory7.setTitle(String(scores[6]), for: UIControl.State.normal)
            OutletCategory7.isEnabled = false
            OutletCategory7.backgroundColor = UIColor.gray
            self.toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory8(_ sender: Any) {
        if(OutletCategory8.isEnabled) {
            scores[7] = scoreFourOfAKind()
            used[7] = true
            OutletCategory8.setTitle(String(scores[7]), for: UIControl.State.normal)
            OutletCategory8.isEnabled = false
            OutletCategory8.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory9(_ sender: Any) {
        if(OutletCategory9.isEnabled) {
            scores[8] = fullHouse()
            used[8] = true
            OutletCategory9.setTitle(String(scores[8]), for: UIControl.State.normal)
            OutletCategory9.isEnabled = false
            OutletCategory9.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory10(_ sender: Any) {
        if(OutletCategory10.isEnabled) {
            scores[9] = smallStraight()
            used[9] = true
            OutletCategory10.setTitle(String(scores[9]), for: UIControl.State.normal)
            OutletCategory10.isEnabled = false
            OutletCategory10.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory11(_ sender: Any) {
        if(OutletCategory11.isEnabled) {
            scores[10] = largeStraight()
            used[10] = true
            OutletCategory11.setTitle(String(scores[10]), for: UIControl.State.normal)
            OutletCategory11.isEnabled = false
            OutletCategory11.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory12(_ sender: Any) {
        if(OutletCategory12.isEnabled) {
            scores[11] = yahtzee()
            used[11] = true
            OutletCategory12.setTitle(String(scores[11]), for: UIControl.State.normal)
            OutletCategory12.isEnabled = false
            OutletCategory12.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    @IBAction func ActionCategory13(_ sender: Any) {
        if(OutletCategory13.isEnabled) {
            scores[12] = sumDice()
            used[12] = true
            OutletCategory13.setTitle(String(scores[12]), for: UIControl.State.normal)
            OutletCategory13.isEnabled = false
            OutletCategory13.backgroundColor = UIColor.gray
            toDoAfterCategory()
        }
    }
    
    @IBOutlet weak var OutletGameMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func rollDice() {
        if(OutletDice1.isEnabled) {
            dice[0] = Int((arc4random() % 6) + 1)
            OutletDice1.setTitle(String(dice[0]), for: UIControl.State.normal)
        }
        if(OutletDice2.isEnabled) {
            dice[1] = Int((arc4random() % 6) + 1)
            OutletDice2.setTitle(String(dice[1]), for: UIControl.State.normal)
        }
        if(OutletDice3.isEnabled) {
            dice[2] = Int((arc4random() % 6) + 1)
            OutletDice3.setTitle(String(dice[2]), for: UIControl.State.normal)
        }
        if(OutletDice4.isEnabled) {
            dice[3] = Int((arc4random() % 6) + 1)
            OutletDice4.setTitle(String(dice[3]), for: UIControl.State.normal)
        }
        if(OutletDice5.isEnabled) {
            dice[4] = Int((arc4random() % 6) + 1)
            OutletDice5.setTitle(String(dice[4]), for: UIControl.State.normal)
        }
    }

    func upperScores(index: Int) -> Int {
        var sum : Int = 0
        for i in 0..<5 {
            if(dice[i] == index) {
                sum += index
            }
        }
        return sum
    }
    
    func scoreThreeOfAKind() -> Int {
        var sameNum : Int
        for i in 0..<3 {
            sameNum = 0
            for j in i+1..<5 {
                if(dice[i] == dice[j]) {
                    sameNum += 1
                }
            }
            if(sameNum >= 2){
                return sumDice()
            }
        }
        return 0
    }
    
    func scoreFourOfAKind() -> Int {
        var sameNum : Int
        for i in 0..<2 {
            sameNum = 0
            for j in i+1..<5 {
                if(dice[i] == dice[j]) {
                    sameNum += 1
                }
            }
            if(sameNum >= 3){
                return sumDice()
            }
        }
        return 0
    }
    
    func sumDice() -> Int {
        var sum : Int = 0
        for i in 0..<5 {
            sum += dice[i]
        }
        return sum
    }
    
    func fullHouse() -> Int{
        var sum : Int = dice[0]
        var num1 : Int = dice[0]
        var num2 : Int = 0

        for i in 1..<5 {
            if(num1 == dice[i]){
                sum += dice[i]
            }
            else {
                if (num2 == 0) {
                    num2 = dice[i]
                    sum += dice[i]
                }
                else if (num2 == dice[i]){
                    sum += dice[i]
                }
                else {
                    return 0
                }
            }
        }
        return 25
    }
    
    func smallStraight() -> Int {
        var diceNum : [Int] = [0, 0, 0, 0, 0, 0]
        for i in 0..<5 {
            diceNum[dice[i] - 1] += 1
        }
        if(diceNum[0] > 0 && diceNum[1] > 0 && diceNum[2] > 0 && diceNum[3] > 0){
            return 30
        }
        else if(diceNum[1] > 0 && diceNum[2] > 0 && diceNum[3] > 0 && diceNum[4] > 0){
            return 30
        }
        else if(diceNum[2] > 0 && diceNum[3] > 0 && diceNum[4] > 0 && diceNum[5] > 0){
            return 30
        }
        return 0
    }
    
    func largeStraight() -> Int {
        var diceNum : [Int] = [0, 0, 0, 0, 0, 0]
        for i in 0..<5 {
            diceNum[dice[i] - 1] += 1
        }
        if(diceNum[0] > 0 && diceNum[1] > 0 && diceNum[2] > 0 && diceNum[3] > 0 && diceNum[4] > 0){
            return 40
        }
        else if(diceNum[1] > 0 && diceNum[2] > 0 && diceNum[3] > 0 && diceNum[4] > 0 && diceNum[5] > 0){
            return 40
        }
        return 0
    }
    
    func yahtzee() -> Int {
        var firstDice = dice[0]
        for i in 1..<5{
            if(firstDice != dice[i]){
                return 0
            }
        }
        yahtzeeBonus = true
        return 50
    }
    
    func chance() -> Int {
        return sumDice()
    }
    
    func allUpperUsed() -> Bool {
        for i in 0..<6 {
            if(!used[i]){
                return false
            }
        }
        return true
    }
    
    func getUpperTotal() -> Int {
        var sum : Int = 0
        for i in 0..<6 {
            sum += scores[i]
        }
        return sum
    }
    
    func getUpperBonus() -> Int {
        if(getUpperTotal() > 63 && !upperBonus){
            BonusScore += 35
            upperBonus = true
            
        }
        if(yahtzeeBonus && yahtzee() == 50) {
            BonusScore += 100
        }
        return BonusScore
    }
    
    func allLowerUsed() -> Bool{
        for i in 6..<13 {
            if(!used[i]){
                return false
            }
        }
        return true
    }
    
    func getLowerTotal() -> Int {
        var sum : Int = 0
        for i in 6..<13 {
            sum += scores[i]
        }
        return sum
    }
    
    func toDoAfterCategory() {
        roll = 0
        if(allUpperUsed()) {
            OutletUpperTotal.setTitle(String(getUpperTotal()), for: UIControl.State.normal)
            OutletUpperBonus.setTitle(String(getUpperBonus()), for: UIControl.State.normal)
        }
        if(allLowerUsed()) {
            OutletLowerTotal.setTitle(String(getLowerTotal()), for: UIControl.State.normal)
        }
        if(allLowerUsed() && allUpperUsed()) {
            OutletGrandTotal.setTitle(String(getLowerTotal() + getUpperTotal() + getUpperBonus()), for: UIControl.State.normal)
        }
        
        OutletRollDice.isEnabled = true
        
        OutletDice1.isEnabled = true
        OutletDice1.setTitle("?", for: UIControl.State.normal)
        OutletDice1.backgroundColor = UIColor.blue
        
        OutletDice2.isEnabled = true
        OutletDice2.setTitle("?", for: UIControl.State.normal)
        OutletDice2.backgroundColor = UIColor.blue
        
        OutletDice3.isEnabled = true
        OutletDice3.setTitle("?", for: UIControl.State.normal)
        OutletDice3.backgroundColor = UIColor.blue
        
        OutletDice4.isEnabled = true
        OutletDice4.setTitle("?", for: UIControl.State.normal)
        OutletDice4.backgroundColor = UIColor.blue
        
        OutletDice5.isEnabled = true
        OutletDice5.setTitle("?", for: UIControl.State.normal)
        OutletDice5.backgroundColor = UIColor.blue
        
        OutletRollDice.setTitle("Roll Dice", for: UIControl.State.normal)
        OutletGameMessage.text = "Roll Dice 버튼을 누르세요!!"
    }
}

