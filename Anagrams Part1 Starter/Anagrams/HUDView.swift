//
//  HUDView.swift
//  Anagrams
//
//  Created by KPUGAME on 2021/04/26.
//  Copyright © 2021 Caroline. All rights reserved.
//

import Foundation
import UIKit

class HUDView: UIView {
    var stopWatch: StopWatchView
    var gamePoints: CounterLabelView
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(frame: )")
    }
    
    override init(frame: CGRect) {
        self.stopWatch = StopWatchView(frame: CGRect(x: ScreenWidth / 2 - 150, y: 0, width: 300, height: 100))
        self.stopWatch.setSeconds(0)
        
        self.gamePoints = CounterLabelView(font: FontHUD!, frame: CGRect(x: ScreenWidth - 200, y: 30, width: 200, height: 70))
        self.gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
        self.gamePoints.value = 0
        
        super.init(frame: frame)
        self.addSubview(self.stopWatch)
        self.addSubview(self.gamePoints)
        
        let pointLabel = UILabel(frame: CGRect(x: ScreenWidth - 340, y: 30, width: 140, height: 70))
        pointLabel.backgroundColor = UIColor.clear
        pointLabel.font = FontHUD
        pointLabel.text = " Points:"
        self.addSubview(pointLabel)
        
        self.isUserInteractionEnabled = false
    }
}
