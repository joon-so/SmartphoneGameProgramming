//
//  ViewController.swift
//  Stop Watch
//
//  Created by KPUGAME on 2021/03/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    
    var minute = 0
    var second = 0
    var tenthPart = 0
    
    var timer = Timer()
    
    func setupTimer() {
        minute = 0
        second = 0
        tenthPart = 0
        
        var mstr = String(format: "%02d", minute)
        var sstr = String(format: "%02d", second)
        
        timerLabel.text = "\(mstr):\(sstr):\(tenthPart)"
    }
    
    @IBAction func startButton() {
        if(!timer.isValid) {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.subtrackTime), userInfo: nil, repeats: true)
        }
    }

    @IBAction func stopButton() {
        timer.invalidate()
    }
    
    @IBAction func resetButton() {
        timer.invalidate()
        setupTimer()
    }
    
    @objc func subtrackTime() {
        tenthPart += 1
        
        if(tenthPart == 10){
            tenthPart = 0
            second += 1
        }
        
        if(second == 60){
            second = 0
            minute += 1
        }
        
        var mstr = String(format: "%02d", minute)
        var sstr = String(format: "%02d", second)
        
        timerLabel.text = "\(mstr):\(sstr):\(tenthPart)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTimer()
    }
}

