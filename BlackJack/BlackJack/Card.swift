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
        self.value = temp%13 + 1    //1..13 숫자
        self.x = temp / 13          //0,1,2,3 카드 suit 를 결정
        self.suit = ""
    }
    
    func getVelue()->Int{
        if(self.value > 10){
            return 10
        }
        else {
            return self.value
        }
    }
    
    func getSuit()->String {//카드 무늬 suit 결정
        if(x==0) {
            self.suit = "Clubs"}
        else if(x==1) {
            self.suit = "Spades"}
        else if(x==2) {
            self.suit = "Hearts"}
        else {
            self.suit = "Diamonds"}
        return self.suit
    }
    
    func filename()->String { //카드 이미지 파일 이름 확장자는 필요없음
        return getSuit() + String(self.value)
    }
}
