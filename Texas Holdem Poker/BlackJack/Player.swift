//
//  Player.swift
//  BlackJack
//
//  Created by KPUGAME on 2021/05/25.
//

import Foundation

class Player {
    var cards = [Card]()
    var state: String = ""
    var shape : [Int] = [0, 0, 0, 0]
    var countCard : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var arr : [[Int]] = Array(repeating: Array(repeating: 0,count:13 ), count: 4)
    private var N: Int = 0
    private var name: String
    init(name: String) {
        self.name = name
    }
    
    func inHand()->Int{
        return self.N
    }
    
    func getState()->String{
        return self.state
    }
    
    func addCard(c: Card) {
        cards.append(c)

        if(c.getSuit() == "Spades") {
            shape[0] += 1
            arr[0][c.getVelue()-1] = 1
        } else if(c.getSuit() == "Diamonds") {
            shape[1] += 1
            arr[1][c.getVelue()-1] = 1
        } else if(c.getSuit() == "Hearts") {
            shape[2] += 1
            arr[2][c.getVelue()-1] = 1
        } else {
            shape[3] += 1
            arr[3][c.getVelue()-1] = 1
        }
        countCard[c.getVelue()-1] += 1
        self.N += 1
    }
    
    func reset() {
        self.N = 0
        shape.removeAll()
        countCard.removeAll()
        arr.removeAll()
        cards.removeAll()
        shape = [0, 0, 0, 0]
        countCard = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        arr = Array(repeating: Array(repeating: 0,count:13 ), count: 4)
    }
    
    func value()->Int { //카드 점수 계산 Ace는 1혹은 11으로 모두 사용될 수 있음
                        //일단 11으로 계산한 후 21이 넘어가면 1로 다시 계산한다.
        //로얄 스트레이트 플러쉬
        for i in 0...3 {
            if(arr[i][0] == 1 && arr[i][9] == 1 && arr[i][10] == 1 && arr[i][11] == 1 && arr[i][12] == 1) {
                print("로스플")
                state = "로스플"
                return 500 - i
            }
        }
        
        //백 스트레이트 플러쉬
        for i in 0...3 {
            if(arr[i][0] == 1 && arr[i][1] == 1 && arr[i][2] == 1 && arr[i][3] == 1 && arr[i][4] == 1) {
                print("백스플")
                state = "백스플"
                return 480 - i
            }
        }
        
        //스트레이트 플러쉬
        for i in 0...3 {
            for j in 1...8{
                if(arr[i][j] == 1 && arr[i][j+1] == 1 && arr[i][j+2] == 1 && arr[i][j+3] == 1 && arr[i][j+4] == 1) {
                    state = "스트플"
                    return 460 - i + j
                }
            }
        }
        
        //포카그
        for i in 0...12 {
            if(countCard[i] == 4) {
                print("포카드")
                state = "포카드"
                return 450 + i
            }
        }
        
        //풀하우스
        var threeCard:Bool = false
        var twoCard: Bool = false
        for i in 0...12 {
            if(countCard[i] == 3) {
                threeCard = true
            }
            if(countCard[i] == 2) {
                twoCard = true
            }
        }
        if(threeCard && twoCard){
            state = "풀하우스"
            print("풀하우스")
            return 400
        }
        
        //플러쉬
        for i in 0...3 {
            if(shape[i] >= 5) {
                state = "플러쉬"
                print("플러쉬")
                return 350 - i
            }
        }
        
        //백스트레이트
        if(countCard[0] >= 1 && countCard[1] >= 1 && countCard[2] >= 1 && countCard[3] >= 1 && countCard[4] >= 1) {
            print("백스트레이트")
            state = "백스트레이트"
            return 340
        }
        
        //스트레이트
        for i in 1...8{
            if(countCard[i] >= 1 && countCard[i+1] >= 1 && countCard[i+2] >= 1 && countCard[i+3] >= 1 && countCard[i+4] >= 1) {
                state = "스트레이트"
                return 320 + i
            }
        }
        
        //트리플
        for i in 0...12 {
            if(countCard[i] == 3) {
                print("트리플")
                state = "트리플"
                return 300 + i
            }
        }
        
        //투페어
        var twoCount : Int = 0
        var point : Int = 250
        for i in 0...12 {
            if(countCard[i] == 2) {
                twoCount += 1
                point += i
            }
            if(i == 12 && twoCount >= 2) {
                print("투페어")
                state = "투페어"
                return point
            }
        }
        
        //원페어
        for i in 0...12 {
            if(countCard[i] == 2) {
                print("원페어")
                state = "원페어"
                var total: Int = 0
                return 150 + i + total
            }
        }

        
        //노페어
        var total: Int = 0
        for i in 0...12 {
            total += (i+1) * countCard[i]
        }
        state = "노페어"
        print("노페어")
        return total
    }
}
