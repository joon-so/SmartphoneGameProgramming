//
//  GameController.swift
//  Anagrams
//
//  Created by KIMYOUNG SIK on 2018. 2. 10..
//  Copyright © 2018년 Caroline. All rights reserved.
//

import UIKit

class GameController {
    var gameView: UIView!   //game elements를 표시하는 view
    var level: Level!       //현재 레벨의 anagram과 설정을 갖는 Level 객체
    
    //TileView 객체 배열, 스크린 하단에 tile들을 표시,
    //tile들은 초기 anagram을 가짐
    var tiles: [TileView]
    var targets: [TargetView]
    
    init() {
        //타일 빈 배열 생성
        tiles = []
        targets = []
    }
    //현재 레벨 anagram을 스크린에 표시하는 메소드
    //랜덤 anagram을 가져와서 letter tile 과 target 을 다룬다.
    func dealRandomAnagram() {
        //1. Level 객체 level이 제대로 로딩되는지 첵크한다.
        assert(level.anagrams.count > 0, "No level loaded")
        //2. anagram 램덤 인덱스 생성, randomNumber()함수는  Config.swift에 있음
        let randomIndex = randomNumber(minX: 0, maxX: UInt32(level.anagrams.count - 1))
        let anagramPair = level.anagrams[randomIndex]
        //3. 2개 anagram 어절을 가져옴
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        //4. 2개 어절의 길이를 가져옴, 2개 어절의 길이가 다를 수 있음.
        let anagram1Length = anagram1.characters.count
        let anagram2Length = anagram2.characters.count
        //5. 콘솔에 2개 어절을 써본다.
        print("phrase1[\(anagram1Length)]: \(anagram1)")
        print("phrase2[\(anagram2Length)]: \(anagram2)")
        //스크린의 90%를 사용하고 anagram 글자 길이에 따라서 tileSide 계산, TileMargin도 고려함
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1Length, anagram2Length))) - TileMargin
        //첫번째 타일 위치 계산
        var xOffset = (ScreenWidth - CGFloat(max(anagram1Length, anagram2Length)) * (tileSide + TileMargin)) / 2.0 + TileMargin / 2.0
        //타일의 위치는 타일의 중심으로 계산
        xOffset += tileSide / 2.0
        
        //targetView는 tileView와 유사하나 anagram2에서 가져옴
        for (index, letter) in anagram2.characters.enumerated() {
            if letter != " " {
                let target = TargetView(letter: letter, sideLength: tileSide)
                target.center = CGPoint(x: xOffset + CGFloat(index) * (tileSide + TileMargin), y: ScreenHeight / 4)
                
                gameView.addSubview(target)
                targets.append(target)
            }
        }

        //타일을 생성, enumerated()는 index/value tuple 생성
        for (index, letter) in anagram1.characters.enumerated() {
            //글자가 스페이스가 아니면 타일 생성
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                //글자 index에의해서 x 위치 결정, y는 스크린 3/4 위치
                tile.center = CGPoint(x: xOffset + CGFloat(index) * (tileSide + TileMargin), y: ScreenHeight / 4 * 3)
                //타일 slightly rotate
                tile.randomize() // rotate it
                //tile을 gameView에 추가
                gameView.addSubview(tile)
                //타일을 배열에 추가
                tiles.append(tile)
            }
        }
    }
}
