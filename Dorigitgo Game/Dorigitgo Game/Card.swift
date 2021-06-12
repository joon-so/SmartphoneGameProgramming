//
//  Card.swift
//  BlackJack
//
//  Created by KPUGAME on 2021/05/25.
//

import Foundation
class Card {
    private var value: Int
    private var x: Int
    private var suit: String
    init(temp:Int) {  //생성자에게 0..51의 랜덤 숫자를 입력받아서 생성
        self.value = temp/4 + 1    //1..10 숫자
        self.x = temp % 4 + 1          //1,2,3,4
        self.suit = ""
    }
    
    func getVelue()->Int{
        return self.value
    }
    
    func getSuit()->String {//카드 무늬 suit 결정
        return self.suit
    }
    
    func getX()->Int {//카드 무늬 suit 결정
        return self.x
    }
    
    func filename()->String { //카드 이미지 파일 이름 확장자는 필요없음
        return String(self.value) + "." + String(self.x)
    }
}
