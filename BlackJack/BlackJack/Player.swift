//
//  Player.swift
//  BlackJack
//
//  Created by KPUGAME on 2021/05/25.
//

import Foundation

class Player {
    var cards = [Card]()
    var total: Int = 0  //점수 변수
    var ace: Int = 0    //Ace 카드 개수 변수
    private var N: Int = 0
    private var name: String
    init(name: String) {
        self.name = name
    }
    
    func inHand()->Int{
        return self.N
    }
    
    func addCard(c: Card) {
        cards.append(c)
        self.N += 1
    }
    
    func reset() {
        self.N = 0
        cards.removeAll()
    }
    
    func value()->Int { //카드 점수 계산 Ace는 1혹은 11으로 모두 사용될 수 있음
                        //일단 11으로 계산한 후 21이 넘어가면 1로 다시 계산한다.
        while(ace > 0) {
            if((total + 11*ace) > 21){
                total += 1
                ace -= 1
            }
            else if((total + 11*ace) <= 21){
                break
            }
        }
        return total + 11 * ace
    }
}
