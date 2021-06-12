//
//  TargetView.swift
//  Anagrams
//
//  Created by KPUGAME on 2021/04/25.
//  Copyright © 2021 Caroline. All rights reserved.
//

import Foundation
import UIKit

class TargetView: UIImageView {
    var letter: Character
    var isMatched: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(letter:, sideLength:)")
    }
    
    init(letter: Character, sideLength: CGFloat) {
        self.letter = letter
        
        let image = UIImage(named: "slot")!
        super.init(image: image)
        
        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
    }
}
