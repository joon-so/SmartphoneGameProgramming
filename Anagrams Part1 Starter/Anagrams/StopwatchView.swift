//
//  StopwatchView.swift
//  Anagrams
//
//  Created by KPUGAME on 2021/04/26.
//  Copyright © 2021 Caroline. All rights reserved.
//

import Foundation
import UIKit

class StopWatchView: UILabel {
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(fram: )")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.font = FontHUDBig
    }
    
    func setSeconds(_ seconds: Int) {
        self.text = String(format: " %02i : %02i", seconds / 60, seconds % 60)
    }
}
