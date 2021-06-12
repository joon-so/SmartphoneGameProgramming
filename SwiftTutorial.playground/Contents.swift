import UIKit

class TipCalculator {
    let total: Double
    let taxPct: Double
    let subtotal: Double
    
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
        subtotal = total / (taxPct + 1)
    }
    
    func calcTipWithTipPct(tipPct: Double) -> Double {
        return subtotal * tipPct
    }
    
    func returnPossibleTips()->[Int: Double] {
        let possibleTipsInferred: [Double] = [0.15, 0.18, 0.20]
        
        var retval = [Int: Double]()
        
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            
            retval[intPct] = calcTipWithTipPct(tipPct: possibleTip)
        }
        return retval
    }
    
    /*
    func printPossibleTips() {
        c
        let possibleTipsExplicit: [Double] = [0.15, 0.18, 0.20]
        
        for possibleTip in possibleTipsInferred {
            print("\(possibleTip*100)%: \(calcTipWithTipPct(tipPct: possibleTip))")
        }
        
        for i in 0..<possibleTipsExplicit.count {
            let possibleTip = possibleTipsExplicit[i]
            print("\(possibleTip*100)%: \(calcTipWithTipPct(tipPct: possibleTip))")
        }
    }
 */
 
}

let tipCalc = TipCalculator(total: 33.25, taxPct: 0.06)
//tipCalc.printPossibleTips()
tipCalc.returnPossibleTips()
