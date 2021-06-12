//
//  Shuffle.swift
//  BlackJack
//
//  Created by KPUGAME on 2021/05/25.
//

import Foundation

extension Array {
    mutating func shuffle() {
        if count < 2 {return}
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
}
