//
//  CounterLabelView.swift
//  Anagrams
//
//  Created by KPUGAME on 2021/04/27.
//  Copyright © 2021 Caroline. All rights reserved.
//

import Foundation
import UIKit

class CounterLabelView: UILabel {
    var value: Int = 0 {
        didSet {
            self.text = "\(value)"
        }
    }
    
    var endValue: Int = 0
    var timer: Timer? = nil
    
    @objc func updateValue(timer: Timer) {
        if (endValue < value) {
            value -= 1
        } else {
            value += 1
        }
        
        if(endValue == value) {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    func setValue(newValue: Int, duration: Float) {
        endValue = newValue
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        let delta = abs(endValue - value)
        if (delta != 0) {
            var interval = Double(duration / Float(delta))
            if interval < 0.01 {
                interval = 0.01
            }
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.updateValue(timer:)), userInfo: nil, repeats: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(font: frame: ")
    }
    
    init(font: UIFont, frame: CGRect) {
        super.init(frame: frame)
        self.font = font
        self.backgroundColor = UIColor.clear
    }
}
