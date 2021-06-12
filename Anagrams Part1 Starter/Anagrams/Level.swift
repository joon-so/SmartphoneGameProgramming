//
//  Level.swift
//  Anagrams
//
//  Created by KPUGAME on 2021/04/25.
//  Copyright © 2021 Caroline. All rights reserved.
//

import Foundation

struct Level {
    // 1 레벨에 맞는 .plist 파일을 찾는다
    let pointsPerTile: Int
    let timeToSolve: Int
    let anagrams: [NSArray]
    
    init(level: Int) {
        let fileName = "level\(level)"
        let fileExts = "plist"
        let levelPath = Bundle.main.path(forResource: fileName, ofType: fileExts)
        
        // 2 .plist 파일 로딩
        let levelDictionary: NSDictionary? = NSDictionary(contentsOfFile: levelPath!)
        
        // 3 파일이 있는지 검증
        assert(levelDictionary != nil, "Level configuration file not found !")
        
        // 4 .plist dictionary에서 데이터 복사
        self.pointsPerTile = levelDictionary!["pointsPerTile"] as! Int
        self.timeToSolve = levelDictionary!["timeToSolve"] as! Int
        self.anagrams = levelDictionary!["anagrams"] as! [NSArray]
    }
}
