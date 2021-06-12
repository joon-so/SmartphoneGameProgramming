//
//  ViewController.swift
//  BlackJack
//
//  Created by KPUGAME on 2021/05/25.
//

import UIKit

class ViewController: UIViewController {
    var player: Player = Player(name: "player")     //플레이어 객체
    var dealer: Player = Player(name: "dealer")     //딜러 객체
    
    var LCardsPlayer = [UIImageView]()              //플레이어 카드 이미지 배열
    var LCardsDealer = [UIImageView]()              //딜러 카드 이미지 배열
    
    var deck = [Int]()                              //카드 생성하기위한 0..51 숫자를 갖는 정수 배역
    var deckIndex = 0                               //덱에서 카드 인덱스 변수
    
    var VbetMoney: Int = 0                          //베팅 머리 정수 변수
    var VplayerMoney: Int = 1000                    //플레이어 머니 정수 변수
    var nCardsDealer: Int = 0                       //딜러 카드 이미지 위치 변수
    var nCardsPlayer: Int = 0                       //플레이어 카드 이미지 위치 변수
    
    @IBOutlet weak var dealerPts: UILabel!          //딜러 점수 라벨
    @IBOutlet weak var playerPts: UILabel!          //플레이어 점수 라벨
    @IBOutlet weak var betMoney: UILabel!           //베팅 머니 라벨
    @IBOutlet weak var playerMoney: UILabel!        //플레이어 머니 라벨
    @IBOutlet weak var status: UILabel!             //스테이터스 라벨

    @IBOutlet weak var Outlet_Bet50: UIButton!      //베팅50 버튼 아웃렛
    @IBOutlet weak var Outlet_Bet25: UIButton!      //베팅50 버튼 아웃렛
    @IBOutlet weak var Outlet_Bet10: UIButton!      //베팅50 버튼 아웃렛
    @IBOutlet weak var Outlet_Hit: UIButton!        //힛 버튼 아웃렛
    @IBOutlet weak var Outlet_Stand: UIButton!      //스텐드 버튼 아웃렛
    @IBOutlet weak var Outlet_Deal: UIButton!       //딜 버튼 아웃렛
    @IBOutlet weak var Outlet_Again: UIButton!      //어겐 버튼 아웃렛
    
    var audioController: AudioController
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
    
    @IBAction func Bet50(_ sender: Any) {
        VbetMoney += 50
        if(VbetMoney <= VplayerMoney) {
            betMoney.text = "$\(VbetMoney)"
            VplayerMoney -= 50
            playerMoney.text = "You have $\(VplayerMoney)"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            VbetMoney -= 50
        }
    }
    
    @IBAction func Bet25(_ sender: Any) {
        VbetMoney += 25
        if(VbetMoney <= VplayerMoney) {
            betMoney.text = "$\(VbetMoney)"
            VplayerMoney -= 25
            playerMoney.text = "You have $\(VplayerMoney)"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            VbetMoney -= 25
        }
    }
    
    @IBAction func Bet10(_ sender: Any) {
        VbetMoney += 10
        if(VbetMoney <= VplayerMoney) {
            betMoney.text = "$\(VbetMoney)"
            VplayerMoney -= 10
            playerMoney.text = "You have $\(VplayerMoney)"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        } else {
            VbetMoney -= 10
        }
    }
    
    @IBAction func Hit(_ sender: Any) {
        nCardsPlayer += 1
        hitPlayer(n: nCardsPlayer)
        if(player.value() > 21) {
            checkWinner()
            Outlet_Bet50.isEnabled = false
            Outlet_Bet25.isEnabled = false
            Outlet_Bet10.isEnabled = false
            Outlet_Hit.isEnabled = false
            Outlet_Stand.isEnabled = false
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = true
        }
    }
    
    @IBAction func Stand(_ sender: Any) {
        LCardsDealer[0].image = UIImage(named: dealer.cards[0].filename())
        Outlet_Bet50.isEnabled = false
        Outlet_Bet25.isEnabled = false
        Outlet_Bet10.isEnabled = false
        Outlet_Hit.isEnabled = false
        Outlet_Stand.isEnabled = false
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = true
        Outlet_Again.tintColor = UIColor.gray
        checkWinner()
    }
    
    @IBAction func Deal(_ sender: Any) {
        if(VbetMoney != 0){
            Outlet_Bet50.isEnabled = false
            Outlet_Bet25.isEnabled = false
            Outlet_Bet10.isEnabled = false
            Outlet_Hit.isEnabled = true
            Outlet_Stand.isEnabled = true
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = false
            Outlet_Again.tintColor = UIColor.gray
            
            LCardsDealer.removeAll()
            LCardsPlayer.removeAll()
            
            player.total = 0
            dealer.total = 0
            player.reset()
            dealer.reset()
            
            deal()
        }
    }
    
    @IBAction func Again(_ sender: Any) {
        Outlet_Bet50.isEnabled = true
        Outlet_Bet25.isEnabled = true
        Outlet_Bet10.isEnabled = true
        Outlet_Hit.isEnabled = false
        Outlet_Stand.isEnabled = false
        Outlet_Deal.isEnabled = true
        Outlet_Again.isEnabled = false
        Outlet_Again.tintColor = UIColor.gray
        
        VbetMoney = 0
        
        for i in 0..<LCardsPlayer.count {
            LCardsPlayer[i].image = nil
        }
        for i in 0..<LCardsDealer.count {
            LCardsDealer[i].image = nil
        }
        
        LCardsDealer = []
        LCardsPlayer = []
        nCardsDealer = 0
        nCardsPlayer = 0
        
        deck.shuffle()
        deckIndex = 0
        
        player.total = 0
        player.ace = 0
        dealer.total = 0
        dealer.ace = 0
        player.reset()
        dealer.reset()
        
        betMoney.text = "$"+String(VbetMoney)
        playerPts.text = "Player: " + String(player.value())
        dealerPts.text = "Dealer: " + String(player.value())
        status.text = "Please bet!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Outlet_Hit.isEnabled = false
        Outlet_Stand.isEnabled = false
        Outlet_Deal.isEnabled = true
        Outlet_Again.isEnabled = false
        Outlet_Again.tintColor = UIColor.gray
        
        for i in 0...51 {
            deck.append(i)
        }
        // Do any additional setup after loading the view.
    }
    
    func deal() {
        deck.shuffle()
        deckIndex = 0
        
        player.reset()
        dealer.reset()
        
        hitPlayer(n:0)
        hitPlayer(n:1)
        hitDealerDown()
        hitDealer(n:1)
        nCardsPlayer = 1
        nCardsDealer = 1
        
        playerPts.text = "Player: " + String(player.value())
    }
    
    func hitPlayer(n: Int) {
        let newCard = Card(temp: deck[deckIndex])
        deckIndex += 1
        
        player.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename()))
        newImageView.center = CGPoint(x: 1000, y: 150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                newImageView.center = CGPoint(x: 300+n*50, y: 450)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
            },
            completion: nil
        )
        LCardsPlayer.append(newImageView)
        if(newCard.getVelue() != 1){
            player.total += newCard.getVelue()
        } else {
            player.ace += 1
        }
        
        playerPts.text = "Player: " + String(player.value())
        audioController.playerEffect(name: SoundFlip)
        
    }
    
    func hitDealer(n: Int) {
        let newCard = Card(temp: deck[deckIndex])
        deckIndex += 1
        
        dealer.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename()))
        newImageView.center = CGPoint(x: 1000, y: 150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                newImageView.center = CGPoint(x: 300+n*50, y: 250)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
            },
            completion: nil
        )
        LCardsDealer.append(newImageView)
        
        dealerPts.text = "Dealer: " + String(dealer.value())
        audioController.playerEffect(name: SoundFlip)
        
    }
    
    func hitDealerDown() {
        let newCard = Card(temp: deck[deckIndex])
        deckIndex += 1
        
        dealer.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: "b2fv"))
        newImageView.center = CGPoint(x: 1000, y: 150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                newImageView.center = CGPoint(x: 300, y: 250)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
            },
            completion: nil
        )
        LCardsDealer.append(newImageView)
        
        dealerPts.text = "Dealer: " + String(dealer.value())
        audioController.playerEffect(name: SoundFlip)
    }

    func checkWinner() {
        LCardsDealer[0].removeFromSuperview()
        let newImageView = UIImageView(image: UIImage(named: dealer.cards[0].filename())!)
        newImageView.center = CGPoint(x:300,y:250)
        
        self.view.insertSubview(newImageView, belowSubview: LCardsDealer[1])
        LCardsDealer[0] = newImageView
        
        if(player.value() <= 21) {
            for i in 0...dealer.cards.count - 1{
                if(dealer.cards[i].getVelue() != 1){
                    dealer.total += dealer.cards[i].getVelue()
                } else {
                    dealer.ace += 1
                }
            }
        
            while(dealer.value() < 17){
                nCardsDealer += 1
                hitDealer(n: nCardsDealer)

                if(dealer.cards[nCardsDealer].getVelue() != 1){
                    dealer.total += dealer.cards[nCardsDealer].getVelue()
                } else {
                    dealer.ace += 1
                }
            }
        }
        
        dealerPts.text = "Dealer: " + String(dealer.value())
        
        if(player.value() > 21) {
            status.text = "Player Busts"
            audioController.playerEffect(name: SoundLose)
        } else if(dealer.value() > 21) {
            status.text = "Dealer Busts"
            VplayerMoney += VbetMoney * 2
            audioController.playerEffect(name: SoundWin)
        } else if(dealer.value() == player.value()) {
            status.text = "Push"
            VplayerMoney += VbetMoney
        } else if(dealer.value() < player.value()) {
            status.text = "You won!"
            VplayerMoney += VbetMoney * 2
            audioController.playerEffect(name: SoundWin)
        } else {
            status.text = "Sorry you lost!"
            audioController.playerEffect(name: SoundLose)
        }
        
        VbetMoney = 0
        playerMoney.text = "You have $"+String(VplayerMoney)
        betMoney.text = "$"+String(VbetMoney)
        
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = true
        player.reset()
        dealer.reset()
    }

}

