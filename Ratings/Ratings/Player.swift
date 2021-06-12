//
//  Player.swift
//  Ratings
//
//  Created by KPUGAME on 2021/03/23.
//

import UIKit

struct Player {
    var name: String?
    var game: String?
    var rating: Int
    
    init(name: String?, game: String?, rating: Int) {
        self.name = name
        self.game = game
        self.rating = rating
    }
}
