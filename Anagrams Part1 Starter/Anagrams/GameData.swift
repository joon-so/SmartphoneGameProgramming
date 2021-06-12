//
//  GameData.swift
//  Anagrams
//
//  Created by KPUGAME on 2021/04/26.
//  Copyright © 2021 Caroline. All rights reserved.
//

import Foundation

class GameData {
    var points: Int = 0 {
        didSet {
            points = max(points, 0)
        }
    }
}
