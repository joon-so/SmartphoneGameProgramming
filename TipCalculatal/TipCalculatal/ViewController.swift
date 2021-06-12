//
//  ViewController.swift
//  TipCalculatal
//
//  Created by KPUGAME on 2021/03/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    var possibleTips = Dictionary<Int, (tipAmt:Double, total:Double)>()
    var sortedKeys:[Int] = []
    
    @IBAction func calculateTapped(sender : AnyObject) {
        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sorted()
        tableView.reloadData()
        
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func viewTapped(sender : AnyObject) {
        totalTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
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
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f, total: $%0.2f", tipAmt,total)
        
        return cell
    }
    
    func refreshUI() {
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%"
    }
}

