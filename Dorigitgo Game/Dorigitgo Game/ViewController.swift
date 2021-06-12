//
//  ViewController.swift
//  Dorigitgo Game
//
//  Created by KPUGAME on 2021/06/11.
//

import UIKit

class ViewController: UIViewController {
    var player1: Player = Player(name: "player1")
    var player2: Player = Player(name: "player2")
    var player3: Player = Player(name: "player3")
    
    var dealer: Player = Player(name: "dealer")
    
    var LCardsPlayer1 = [UIImageView]()
    var LCardsPlayer2 = [UIImageView]()
    var LCardsPlayer3 = [UIImageView]()
    var LCardsDealer = [UIImageView]()
    
    var deck = [Int]()
    var deckIndex = 0
    var tern : Int = 0
    
    var betMoney1 : Int = 0
    var betMoney2 : Int = 0
    var betMoney3 : Int = 0
    var playerMoney : Int = 1000
    var nCards : Int = 0
    
    var Hwatoo1 = [UILabel]()       //플레이어1 화투5장 원숫자 배열
    var Hwatoo2 = [UILabel]()       //플레이어2 화투5장 원숫자 배열
    var Hwatoo3 = [UILabel]()       //플레이어3 화투5장 원숫자 배열
    var Hwatoo4 = [UILabel]()       //딜러 화투5장 원숫자 배열
    
    @IBOutlet weak var H10: UILabel!
    @IBOutlet weak var H11: UILabel!
    @IBOutlet weak var H12: UILabel!
    @IBOutlet weak var H13: UILabel!
    @IBOutlet weak var H14: UILabel!
    @IBOutlet weak var H20: UILabel!
    @IBOutlet weak var H21: UILabel!
    @IBOutlet weak var H22: UILabel!
    @IBOutlet weak var H23: UILabel!
    @IBOutlet weak var H24: UILabel!
    @IBOutlet weak var H30: UILabel!
    @IBOutlet weak var H31: UILabel!
    @IBOutlet weak var H32: UILabel!
    @IBOutlet weak var H33: UILabel!
    @IBOutlet weak var H34: UILabel!
    @IBOutlet weak var H40: UILabel!
    @IBOutlet weak var H41: UILabel!
    @IBOutlet weak var H42: UILabel!
    @IBOutlet weak var H43: UILabel!
    @IBOutlet weak var H44: UILabel!
    
    @IBOutlet weak var Outlet_playerPts1: UILabel!
    @IBOutlet weak var Outlet_playerPts2: UILabel!
    @IBOutlet weak var Outlet_playerPts3: UILabel!
    @IBOutlet weak var Outlet_dealerPts: UILabel!
    
    @IBOutlet weak var Outlet_betMoney1: UILabel!
    @IBOutlet weak var Outlet_betMoney2: UILabel!
    @IBOutlet weak var Outlet_betMoney3: UILabel!
    @IBOutlet weak var Outlet_playerMoney: UILabel!
    
    @IBOutlet weak var Outlet_Bet15: UIButton!
    @IBOutlet weak var Outlet_Bet11: UIButton!
    @IBOutlet weak var Outlet_Bet25: UIButton!
    @IBOutlet weak var Outlet_Bet21: UIButton!
    @IBOutlet weak var Outlet_Bet35: UIButton!
    @IBOutlet weak var Outlet_Bet31: UIButton!
    
    @IBOutlet weak var Outlet_status1: UILabel!
    @IBOutlet weak var Outlet_status2: UILabel!
    @IBOutlet weak var Outlet_status3: UILabel!
    @IBOutlet weak var Outlet_Deal: UIButton!
    @IBOutlet weak var Outlet_Again: UIButton!
    
    var audioController: AudioController
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
    
    @IBAction func Deal(_ sender: Any) {
        if(tern == 0) {
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = false
            Outlet_Bet15.isEnabled = true
            Outlet_Bet11.isEnabled = true
            Outlet_Bet25.isEnabled = true
            Outlet_Bet21.isEnabled = true
            Outlet_Bet35.isEnabled = true
            Outlet_Bet31.isEnabled = true
            
            hitDealer(n: nCards)
            hitPlayer1(n: nCards)
            hitPlayer2(n: nCards)
            hitPlayer3(n: nCards)
            nCards += 1
        }
        else if(tern == 1) {
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = false
            Outlet_Bet15.isEnabled = true
            Outlet_Bet11.isEnabled = true
            Outlet_Bet25.isEnabled = true
            Outlet_Bet21.isEnabled = true
            Outlet_Bet35.isEnabled = true
            Outlet_Bet31.isEnabled = true
            
            hitDealer(n: nCards)
            hitPlayer1(n: nCards)
            hitPlayer2(n: nCards)
            hitPlayer3(n: nCards)
            nCards += 1
            hitDealer(n: nCards)
            hitPlayer1(n: nCards)
            hitPlayer2(n: nCards)
            hitPlayer3(n: nCards)
            nCards += 1
            hitDealer(n: nCards)
            hitPlayer1(n: nCards)
            hitPlayer2(n: nCards)
            hitPlayer3(n: nCards)
            nCards += 1
        }
        else if (tern == 2){
            hitDealer(n: nCards)
            hitPlayer1(n: nCards)
            hitPlayer2(n: nCards)
            hitPlayer3(n: nCards)
            
            LCardsDealer[0].image = UIImage(named: dealer.cards[0].filename())
            LCardsDealer[1].image = UIImage(named: dealer.cards[1].filename())
            LCardsDealer[2].image = UIImage(named: dealer.cards[2].filename())
            LCardsDealer[3].image = UIImage(named: dealer.cards[3].filename())
            LCardsDealer[4].image = UIImage(named: dealer.cards[4].filename())
        
            H40.text = String(dealer.cards[0].getVelue())
            H41.text = String(dealer.cards[1].getVelue())
            H42.text = String(dealer.cards[2].getVelue())
            H43.text = String(dealer.cards[3].getVelue())
            H44.text = String(dealer.cards[4].getVelue())
            
            Outlet_Deal.isEnabled = false
            Outlet_Bet15.isEnabled = false
            Outlet_Bet11.isEnabled = false
            Outlet_Bet25.isEnabled = false
            Outlet_Bet21.isEnabled = false
            Outlet_Bet35.isEnabled = false
            Outlet_Bet31.isEnabled = false
            Outlet_Again.isEnabled = true
            
            checkPlayer1()
            checkPlayer2()
            checkPlayer3()
            checkDealer()
            
            checkWin()
            Outlet_playerMoney.text = "\(playerMoney)만"
        }
        tern += 1
    }
    @IBAction func Again(_ sender: Any) {
        Outlet_Again.isEnabled = false
        Outlet_Deal.isEnabled = true
        
        for i in 0..<LCardsPlayer1.count {
            LCardsPlayer1[i].image = nil
        }
        for i in 0..<LCardsPlayer2.count {
            LCardsPlayer2[i].image = nil
        }
        for i in 0..<LCardsPlayer3.count {
            LCardsPlayer3[i].image = nil
        }
        for i in 0..<LCardsDealer.count {
            LCardsDealer[i].image = nil
        }
        
        LCardsDealer = []
        LCardsPlayer1 = []
        LCardsPlayer2 = []
        LCardsPlayer3 = []
        
        deck.shuffle()
        deckIndex = 0
        for i in 0..<5 {
            Hwatoo1[i].text = ""
            Hwatoo2[i].text = ""
            Hwatoo3[i].text = ""
            Hwatoo4[i].text = ""
            Hwatoo1[i].textColor = UIColor.white
            Hwatoo2[i].textColor = UIColor.white
            Hwatoo3[i].textColor = UIColor.white
            Hwatoo4[i].textColor = UIColor.white
        }
        
        player1.reset()
        player2.reset()
        player3.reset()
        dealer.reset()
        
        tern = 0
        nCards = 0
        betMoney1 = 0
        betMoney2 = 0
        betMoney3 = 0
        Outlet_betMoney1.text = "\(betMoney1)만"
        Outlet_betMoney2.text = "\(betMoney2)만"
        Outlet_betMoney3.text = "\(betMoney3)만"
        Outlet_status1.text = ""
        Outlet_status2.text = ""
        Outlet_status3.text = ""
        Outlet_playerPts1.text = ""
        Outlet_playerPts2.text = ""
        Outlet_playerPts3.text = ""
        Outlet_dealerPts.text = ""
    }
    
    @IBAction func Bet15(_ sender: Any) {
        betMoney1 += 50
        if(betMoney1 <= playerMoney) {
            Outlet_betMoney1.text = "\(betMoney1)만"
            playerMoney -= 50
            Outlet_playerMoney.text = "소유금: \(playerMoney)만"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            betMoney1 -= 50
        }
    }
    @IBAction func Bet11(_ sender: Any) {
        betMoney1 += 10
        if(betMoney1 <= playerMoney) {
            Outlet_betMoney1.text = "\(betMoney1)만"
            playerMoney -= 10
            Outlet_playerMoney.text = "소유금: \(playerMoney)만"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            betMoney1 -= 10
        }
    }
    @IBAction func Bet25(_ sender: Any) {
        betMoney2 += 50
        if(betMoney2 <= playerMoney) {
            Outlet_betMoney2.text = "\(betMoney2)만"
            playerMoney -= 50
            Outlet_playerMoney.text = "소유금: \(playerMoney)만"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            betMoney2 -= 50
        }
    }
    @IBAction func Bet21(_ sender: Any) {
        betMoney2 += 10
        if(betMoney2 <= playerMoney) {
            Outlet_betMoney2.text = "\(betMoney2)만"
            playerMoney -= 10
            Outlet_playerMoney.text = "소유금: \(playerMoney)만"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            betMoney2 -= 10
        }
    }
    @IBAction func Bet35(_ sender: Any) {
        betMoney3 += 50
        if(betMoney3 <= playerMoney) {
            Outlet_betMoney3.text = "\(betMoney3)만"
            playerMoney -= 50
            Outlet_playerMoney.text = "소유금: \(playerMoney)만"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            betMoney3 -= 50
        }
    }
    @IBAction func Bet31(_ sender: Any) {
        betMoney3 += 10
        if(betMoney3 <= playerMoney) {
            Outlet_betMoney3.text = "\(betMoney3)만"
            playerMoney -= 10
            Outlet_playerMoney.text = "소유금: \(playerMoney)만"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            betMoney3 -= 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Outlet_Bet15.isEnabled = false
        Outlet_Bet11.isEnabled = false
        Outlet_Bet25.isEnabled = false
        Outlet_Bet21.isEnabled = false
        Outlet_Bet35.isEnabled = false
        Outlet_Bet31.isEnabled = false
        
        Outlet_Again.isEnabled = false
        
        for i in 0...39 {
            deck.append(i)
        }
        Hwatoo1 = [H10,H11,H12,H13,H14]
        Hwatoo2 = [H20,H21,H22,H23,H24]
        Hwatoo3 = [H30,H31,H32,H33,H34]
        Hwatoo4 = [H40,H41,H42,H43,H44]
        
        deck.shuffle()
        deckIndex = 0
        for i in 0..<5 {
            Hwatoo1[i].text = ""
            Hwatoo2[i].text = ""
            Hwatoo3[i].text = ""
            Hwatoo4[i].text = ""
            Hwatoo1[i].textColor = UIColor.white
            Hwatoo2[i].textColor = UIColor.white
            Hwatoo3[i].textColor = UIColor.white
            Hwatoo4[i].textColor = UIColor.white
        }
        Outlet_status1.textColor = UIColor.orange
        Outlet_status2.textColor = UIColor.orange
        Outlet_status3.textColor = UIColor.orange
        //self.view.backgroundColor = UIColor(patternImage: UIImage(contentsOfFile: "table")!)
    }

    func hitPlayer1(n: Int) {
        let newCard = Card(temp: deck[deckIndex])
        deckIndex += 1
        
        player1.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename()))
        newImageView.center = CGPoint(x: 1000, y: 150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                newImageView.center = CGPoint(x: 75+n*40, y: 520)
                newImageView.transform = CGAffineTransform(rotationAngle: 6.28)
            },
            completion: nil
        )
        LCardsPlayer1.append(newImageView)
        if(n==0){
            H10.text = String(player1.cards[n].getVelue())
        } else if(n==1){
            H11.text = String(player1.cards[n].getVelue())
        } else if(n==2){
            H12.text = String(player1.cards[n].getVelue())
        } else if(n==3){
            H13.text = String(player1.cards[n].getVelue())
        } else {
            H14.text = String(player1.cards[n].getVelue())
        }
        audioController.playerEffect(name: SoundFlip)
    }
    func hitPlayer2(n: Int) {
        let newCard = Card(temp: deck[deckIndex])
        deckIndex += 1
        
        player2.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename()))
        newImageView.center = CGPoint(x: 1000, y: 150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                newImageView.center = CGPoint(x: 336+n*40, y: 520)
                newImageView.transform = CGAffineTransform(rotationAngle: 6.28)
            },
            completion: nil
        )
        LCardsPlayer2.append(newImageView)
        if(n==0){
            H20.text = String(player2.cards[n].getVelue())
        } else if(n==1){
            H21.text = String(player2.cards[n].getVelue())
        } else if(n==2){
            H22.text = String(player2.cards[n].getVelue())
        } else if(n==3){
            H23.text = String(player2.cards[n].getVelue())
        } else {
            H24.text = String(player2.cards[n].getVelue())
        }
        audioController.playerEffect(name: SoundFlip)
    }
    
    func hitPlayer3(n: Int) {
        let newCard = Card(temp: deck[deckIndex])
        deckIndex += 1
        
        player3.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename()))
        newImageView.center = CGPoint(x: 1000, y: 150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                newImageView.center = CGPoint(x: 592+n*40, y: 520)
                newImageView.transform = CGAffineTransform(rotationAngle: 6.28)
            },
            completion: nil
        )
        LCardsPlayer3.append(newImageView)
        if(n==0){
            H30.text = String(player3.cards[n].getVelue())
        } else if(n==1){
            H31.text = String(player3.cards[n].getVelue())
        } else if(n==2){
            H32.text = String(player3.cards[n].getVelue())
        } else if(n==3){
            H33.text = String(player3.cards[n].getVelue())
        } else {
            H34.text = String(player3.cards[n].getVelue())
        }
        audioController.playerEffect(name: SoundFlip)
    }
    
    func hitDealer(n: Int) {
        let newCard = Card(temp: deck[deckIndex])
        deckIndex += 1

        dealer.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: "cardback"))
        newImageView.center = CGPoint(x: 1000, y: 150)

        self.view.addSubview(newImageView)

        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                newImageView.center = CGPoint(x: 366+n*40, y: 275)
                newImageView.transform = CGAffineTransform(rotationAngle: 6.28)
            },
            completion: nil
        )
        LCardsDealer.append(newImageView)
        audioController.playerEffect(name: SoundFlip)

    }

    func checkPlayer1()
    {
        for i in 0...2 {
            for j in i+1...3 {
                for k in j+1...4 {
                    if(player1.cards[i].getVelue() + player1.cards[j].getVelue() + player1.cards[k].getVelue() == 10 ||
                        player1.cards[i].getVelue() + player1.cards[j].getVelue() + player1.cards[k].getVelue() == 20) {
                        Hwatoo1[i].textColor = UIColor.orange
                        LCardsPlayer1[i].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player1.changeUsed(n: i)
                        player1.addMade(n: player1.cards[i].getVelue())
                        
                        Hwatoo1[j].textColor = UIColor.orange
                        LCardsPlayer1[j].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player1.changeUsed(n: j)
                        player1.addMade(n: player1.cards[j].getVelue())
                        
                        Hwatoo1[k].textColor = UIColor.orange
                        LCardsPlayer1[k].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player1.changeUsed(n: k)
                        player1.addMade(n: player1.cards[k].getVelue())
                        
                        judge(player: player1)
                        calPoint(player: player1)
                        Outlet_playerPts1.text! += player1.state
                        return
                    }
                }
            }
        }
        Outlet_playerPts1.text = "노 메이드"
    }
    func checkPlayer2()
    {
        for i in 0...2 {
            for j in i+1...3 {
                for k in j+1...4 {
                    if(player2.cards[i].getVelue() + player2.cards[j].getVelue() + player2.cards[k].getVelue() == 10 ||
                        player2.cards[i].getVelue() + player2.cards[j].getVelue() + player2.cards[k].getVelue() == 20) {
                        Hwatoo2[i].textColor = UIColor.orange
                        LCardsPlayer2[i].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player2.changeUsed(n: i)
                        player2.addMade(n: player2.cards[i].getVelue())
                        
                        Hwatoo2[j].textColor = UIColor.orange
                        LCardsPlayer2[j].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player2.changeUsed(n: j)
                        player2.addMade(n: player2.cards[j].getVelue())
                        
                        Hwatoo2[k].textColor = UIColor.orange
                        LCardsPlayer2[k].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player2.changeUsed(n: k)
                        player2.addMade(n: player2.cards[k].getVelue())
                        
                        judge(player: player2)
                        calPoint(player: player2)
                        Outlet_playerPts2.text! += player2.state
                        return
                    }
                }
            }
        }
        Outlet_playerPts2.text = "노 메이드"
    }
    func checkPlayer3()
    {
        for i in 0...2 {
            for j in i+1...3 {
                for k in j+1...4 {
                    if(player3.cards[i].getVelue() + player3.cards[j].getVelue() + player3.cards[k].getVelue() == 10 ||
                        player3.cards[i].getVelue() + player3.cards[j].getVelue() + player3.cards[k].getVelue() == 20) {
                        
                        Hwatoo3[i].textColor = UIColor.orange
                        LCardsPlayer3[i].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player3.changeUsed(n: i)
                        player3.addMade(n: player3.cards[i].getVelue())
                        
                        Hwatoo3[j].textColor = UIColor.orange
                        LCardsPlayer3[j].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player3.changeUsed(n: j)
                        player3.addMade(n: player3.cards[j].getVelue())
                        
                        Hwatoo3[k].textColor = UIColor.orange
                        LCardsPlayer3[k].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        player3.changeUsed(n: k)
                        player3.addMade(n: player3.cards[k].getVelue())
                        
                        judge(player: player3)
                        calPoint(player: player3)
                        Outlet_playerPts3.text! += player3.state
                        return
                    }
                }
            }
        }
        Outlet_playerPts3.text = "노 메이드"
    }
    
    func checkDealer()
    {
        for i in 0...2 {
            for j in i+1...3 {
                for k in j+1...4 {
                    if(dealer.cards[i].getVelue() + dealer.cards[j].getVelue() +
                        dealer.cards[k].getVelue() == 10 ||
                        dealer.cards[i].getVelue() + dealer.cards[j].getVelue() +
                        dealer.cards[k].getVelue() == 20) {
                        Hwatoo4[i].textColor = UIColor.orange
                        LCardsDealer[i].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        dealer.changeUsed(n: i)
                        dealer.addMade(n: dealer.cards[i].getVelue())
                        
                        Hwatoo4[j].textColor = UIColor.orange
                        LCardsDealer[j].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        dealer.changeUsed(n: j)
                        dealer.addMade(n: dealer.cards[j].getVelue())
                        
                        Hwatoo4[k].textColor = UIColor.orange
                        LCardsDealer[k].transform = CGAffineTransform(translationX: 0, y: CGFloat(20))
                        dealer.changeUsed(n: k)
                        dealer.addMade(n: dealer.cards[k].getVelue())
                        
                        judge(player: dealer)
                        calPoint(player: dealer)
                        Outlet_dealerPts.text! += dealer.state
                        
                        return
                    }
                }
            }
        }
        Outlet_dealerPts.text = "노 메이드"
    }
    
    func checkWin() {
        if(dealer.getPoint() > player1.getPoint()) {
            Outlet_status1.text = "패"
        } else if(dealer.getPoint() < player1.getPoint()) {
            Outlet_status1.text = "승"
            playerMoney += betMoney1*2
        } else if(dealer.getPoint() == player1.getPoint()) {
            Outlet_status1.text = "비김"
            playerMoney += betMoney1
        }
        
        if(dealer.getPoint() > player2.getPoint()) {
            Outlet_status2.text = "패"
        } else if(dealer.getPoint() < player2.getPoint()) {
            Outlet_status2.text = "승"
            playerMoney += betMoney2*2
        } else if(dealer.getPoint() == player2.getPoint()) {
            Outlet_status2.text = "비김"
            playerMoney += betMoney2
        }
        
        if(dealer.getPoint() > player3.getPoint()) {
            Outlet_status3.text = "패"
        } else if(dealer.getPoint() < player3.getPoint()) {
            Outlet_status3.text = "승"
            playerMoney += betMoney3*2
        } else if(dealer.getPoint() == player3.getPoint()) {
            Outlet_status3.text = "비김"
            playerMoney += betMoney3
        }
    }
    
    func calPoint(player: Player) {
        for i in 0...4 {
            if(!player.used[i]) {
                player.value.append(player.cards[i])
            }
        }
        //38광땡
        if((player.value[0].filename() == "3.1" && player.value[1].filename() == "8.1") ||
                (player.value[0].filename() == "8.1" && player.value[1].filename() == "3.1")) {
            player.point = 500
            player.state += " 38광땡"
            return
        }
        //광땡
        else if((player.value[0].filename() == "1.1" && player.value[1].filename() == "3.1") ||
                (player.value[0].filename() == "1.1" && player.value[1].filename() == "8.1") ||
                (player.value[0].filename() == "3.1" && player.value[1].filename() == "1.1") ||
                (player.value[0].filename() == "8.1" && player.value[1].filename() == "1.1")) {
            player.point = 450
            player.state += " 광땡"
            return
        }
        //땡
        else if(player.value[0].getVelue() == player.value[1].getVelue()) {
            player.point = 430 + player.value[0].getVelue()
            player.state +=  " "+String(player.value[0].getVelue())+"땡"
            return
        }
        //끗
        else if((player.value[0].getVelue() + player.value[1].getVelue())%10 > 0) {
            player.point = 400 + (player.value[0].getVelue() + player.value[1].getVelue())%10
            player.state += " "+String((player.value[0].getVelue() + player.value[1].getVelue())%10)+"끗"
            return
        }
        //망통
        else if((player.value[0].getVelue() + player.value[1].getVelue())%10 == 0) {
            player.point = 350
            player.state += " 망통"
            return
        }
    }
    
    func judge(player: Player) {
        if(player.made[0] == 1 && player.made[1] == 1 && player.made[2] == 8) {
            player.state += "콩콩팔(1 1 8)"
        }
        else if(player.made[0] == 1 && player.made[1] == 2 && player.made[2] == 7) {
            player.state += "삐리칠(1 2 7)"
        }
        else if(player.made[0] == 1 && player.made[1] == 3 && player.made[2] == 6) {
            player.state += "물삼육(1 3 6)"
        }
        else if(player.made[0] == 1 && player.made[1] == 4 && player.made[2] == 5) {
            player.state += "빽새오(1 4 5)"
        }
        else if(player.made[0] == 1 && player.made[1] == 9 && player.made[2] == 10) {
            player.state += "삥구장(1 9 10)"
        }
        else if(player.made[0] == 2 && player.made[1] == 2 && player.made[2] == 6) {
            player.state += "니니육(2 2 6)"
        }
        else if(player.made[0] == 2 && player.made[1] == 3 && player.made[2] == 5) {
            player.state += "이삼오(2 3 5)"
        }
        else if(player.made[0] == 2 && player.made[1] == 8 && player.made[2] == 10) {
            player.state += "이판장(2 8 10)"
        }
        else if(player.made[0] == 3 && player.made[1] == 3 && player.made[2] == 4) {
            player.state += "심심새(3 3 4)"
        }
        else if(player.made[0] == 3 && player.made[1] == 7 && player.made[2] == 10) {
            player.state += "삼칠장(3 7 10)"
        }
        else if(player.made[0] == 3 && player.made[1] == 8 && player.made[2] == 9) {
            player.state += "삼빡구(3 8 9)"
        }
        else if(player.made[0] == 2 && player.made[1] == 4 && player.made[2] == 4) {
            player.state += "살살이(4 4 2)"
        }
        else if(player.made[0] == 4 && player.made[1] == 6 && player.made[2] == 10) {
            player.state += "사륙장(4 6 10)"
        }
        else if(player.made[0] == 4 && player.made[1] == 7 && player.made[2] == 9) {
            player.state += "사칠구(4 7 9)"
        }
        else if(player.made[0] == 5 && player.made[1] == 5 && player.made[2] == 10) {
            player.state += "꼬꼬장(5 5 10)"
        }
        else if(player.made[0] == 5 && player.made[1] == 6 && player.made[2] == 9) {
            player.state += "오륙구(5 6 9)"
        }
        else if(player.made[0] == 5 && player.made[1] == 7 && player.made[2] == 8) {
            player.state += "오리발(5 7 8)"
        }
        else if(player.made[0] == 6 && player.made[1] == 6 && player.made[2] == 8) {
            player.state += "쭉쭉팔(6 6 8)"
        }
        else if(player.made[0] == 6 && player.made[1] == 7 && player.made[2] == 7) {
            player.state += "철철육(7 7 6)"
        }
        else if(player.made[0] == 4 && player.made[1] == 8 && player.made[2] == 8) {
            player.state += "팍팍싸(8 8 4)"
        }
        else if(player.made[0] == 2 && player.made[1] == 9 && player.made[2] == 9) {
            player.state += "구구리(9 9 2)"
        }
    }
}

