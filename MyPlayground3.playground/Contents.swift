import UIKit

class TestDateSource: NSObject, UITableViewDataSource {
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    var possibleTips = [Int: (tipAmt:Double, total:Double)]()
    
    var sortedKeys:[Int] = []
    
    override init() {
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sorted()
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: nil)
        
        let tipPct = sortedKeys[indexPath.row]
        
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total
        
        cell.textLabel?.text = "\(tipPct)%"
        cell.detailTextLabel?.text = String(format: "Tip: $%0,2f, total: $%0.2f", tipAmt,total)
        
        return cell
    }
}


class TipCalculatorModel {
    var total: Double
    var taxPct: Double
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }
    
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcTipWithTipPct(tipPct: Double) -> (tipAmt:Double, total:Double) {
        let tipAmt = subtotal * tipPct
        let finalTotal = total + tipAmt
        return (tipAmt, finalTotal)
    }
    
    func returnPossibleTips()->[Int: (tipAmt:Double, total:Double)] {
        let possibleTipsInferred: [Double] = [0.15, 0.18, 0.20]
        
        var retval = [Int: (tipAmt:Double, total:Double)]()
        
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            
            retval[intPct] = calcTipWithTipPct(tipPct: possibleTip)
        }
        return retval
    }
}


let testDateSource = TestDateSource()
let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 320), style: .plain)
tableView.dataSource = testDateSource
tableView.reloadData()
