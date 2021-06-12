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
    var community: Player = Player(name: "community")   //딜러 객체
    
    var LCardsPlayer = [UIImageView]()              //플레이어 카드 이미지 배열
    var LCardsDealer = [UIImageView]()              //딜러 카드 이미지 배열
    var LCardsCommunity = [UIImageView]()
    
    var deck = [Int]()                              //카드 생성하기위한 0..51 숫자를 갖는 정수 배역
    var deckIndex = 0                               //덱에서 카드 인덱스 변수
    
    var VbetMoney: Int = 0                          //베팅 머리 정수 변수
    var VplayerMoney: Int = 1000                    //플레이어 머니 정수 변수
    var nState : Int = -1                            //딜링하고 카드 위치 정하기 위한 스테이트 변수 0,1,2,3,4
    
    @IBOutlet weak var dealerPts: UILabel!          //딜러 점수 라벨
    @IBOutlet weak var playerPts: UILabel!          //플레이어 점수 라벨
    @IBOutlet weak var betMoney: UILabel!           //베팅 머니 라벨
    @IBOutlet weak var playerMoney: UILabel!        //플레이어 머니 라벨
    @IBOutlet weak var status: UILabel!             //스테이터스 라벨

    @IBOutlet weak var Outlet_Check: UIButton!      //베팅50 버튼 아웃렛
    @IBOutlet weak var Outlet_BetX1: UIButton!      //베팅50 버튼 아웃렛
    @IBOutlet weak var Outlet_BetX2: UIButton!      //베팅50 버튼 아웃렛
    @IBOutlet weak var Outlet_Deal: UIButton!       //딜 버튼 아웃렛
    @IBOutlet weak var Outlet_Again: UIButton!      //어겐 버튼 아웃렛
    
    var audioController: AudioController
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
    
    @IBAction func Check(_ sender: Any) {
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
        Outlet_Check.isEnabled = false
        Outlet_BetX1.isEnabled = false
        Outlet_BetX2.isEnabled = false
        
        Outlet_Deal.isEnabled = true
        Outlet_Again.isEnabled = false
    }
    
    @IBAction func BetX1(_ sender: Any) {
        VbetMoney *= 2
        if(VbetMoney <= VplayerMoney) {
            betMoney.text = "$\(VbetMoney)"
            VplayerMoney -= (VbetMoney/2)
            playerMoney.text = "You have $\(VplayerMoney)"
            
            Outlet_Deal.isEnabled = true
            
            audioController.playerEffect(name: SoundChip)
        } else {
            VbetMoney /= 2
        }
        Outlet_Check.isEnabled = false
        Outlet_BetX1.isEnabled = false
        Outlet_BetX2.isEnabled = false
        
        Outlet_Deal.isEnabled = true
        Outlet_Again.isEnabled = false
    }
    
    @IBAction func BetX2(_ sender: Any) {
        VbetMoney *= 3
        if(VbetMoney <= VplayerMoney) {
            betMoney.text = "$\(VbetMoney)"
            VplayerMoney -= (VbetMoney / 3 * 2)
            playerMoney.text = "You have $\(VplayerMoney)"
            
            Outlet_Deal.isEnabled = true
            
            audioController.playerEffect(name: SoundChip)
        } else {
            VbetMoney /= 3
        }
        Outlet_Check.isEnabled = false
        Outlet_BetX1.isEnabled = false
        Outlet_BetX2.isEnabled = false
        
        Outlet_Deal.isEnabled = true
        Outlet_Again.isEnabled = false
    }
    
    @IBAction func Deal(_ sender: Any) {
        if(VbetMoney != 0){
            Outlet_Check.isEnabled = true
            Outlet_BetX1.isEnabled = true
            Outlet_BetX2.isEnabled = true
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = false
            Outlet_Again.tintColor = UIColor.gray
            
            //LCardsDealer.removeAll()
            //LCardsPlayer.removeAll()
            
            //player.reset()
            //dealer.reset()
            
            if(nState == -1){
                deal()
            } else if(nState == 5){
                LCardsDealer[0].image = UIImage(named: dealer.cards[0].filename())
                LCardsDealer[1].image = UIImage(named: dealer.cards[1].filename())
                checkWinner()
                Outlet_Check.isEnabled = false
                Outlet_BetX1.isEnabled = false
                Outlet_BetX2.isEnabled = false
                
                Outlet_Deal.isEnabled = false
                Outlet_Again.isEnabled = true
                nState = -1
            } else {
                hitCommunity(n: nState)
            }
            nState += 1
        }
    }
    
    @IBAction func Again(_ sender: Any) {
        Outlet_Check.isEnabled = true
        Outlet_BetX1.isEnabled = true
        Outlet_BetX2.isEnabled = true
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = false
        Outlet_Again.tintColor = UIColor.gray
        
        VbetMoney = 0
        
        for i in 0..<LCardsPlayer.count {
            LCardsPlayer[i].image = nil
        }
        for i in 0..<LCardsDealer.count {
            LCardsDealer[i].image = nil
        }
        for i in 0..<LCardsCommunity.count {
            LCardsCommunity[i].image = nil
        }
        
        LCardsDealer = []
        LCardsPlayer = []
        LCardsCommunity = []
        nState = -1
        
        deck.shuffle()
        deckIndex = 0

        player.reset()
        dealer.reset()
        
        playerPts.text = "Player:"
        dealerPts.text = "Dealer:"
        betMoney.text = "$"+String(VbetMoney)
        //playerPts.text = "Player: " + String(player.value())
        //dealerPts.text = "Dealer: " + String(player.value())
        status.text = "Please bet!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        //playerPts.text = "Player: " + String(player.value())
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
                newImageView.center = CGPoint(x: 150+n*75, y: 500)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
            },
            completion: nil
        )
        LCardsPlayer.append(newImageView)
        
        //playerPts.text = "Player: " + String(player.value())
        audioController.playerEffect(name: SoundFlip)
    }
    
    func hitCommunity(n: Int) {
        let newCard = Card(temp: deck[deckIndex])
        deckIndex += 1
        
        community.addCard(c: newCard)
        player.addCard(c: newCard)
        dealer.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename()))
        newImageView.center = CGPoint(x: 1000, y: 150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                newImageView.center = CGPoint(x: 250+n*75, y: 350)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
            },
            completion: nil
        )
        LCardsCommunity.append(newImageView)
        
        audioController.playerEffect(name: SoundFlip)
    }
    
    func hitDealer(n: Int) {
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
                newImageView.center = CGPoint(x: 150+n*75, y: 200)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
            },
            completion: nil
        )
        LCardsDealer.append(newImageView)
        
        //dealerPts.text = "Dealer: " + String(dealer.value())
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
                newImageView.center = CGPoint(x: 150, y: 200)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
            },
            completion: nil
        )
        LCardsDealer.append(newImageView)
        
        //dealerPts.text = "Dealer: " + String(dealer.value())
        audioController.playerEffect(name: SoundFlip)
    }

    func checkWinner() {
       if(dealer.value() < player.value()) {
            status.text = "You won!"
            VplayerMoney += VbetMoney * 2
            audioController.playerEffect(name: SoundWin)
        } else {
            status.text = "Sorry you lost!"
            audioController.playerEffect(name: SoundLose)
        }
        playerPts.text = "Player: \(player.getState())"
        dealerPts.text = "Dealer: \(dealer.getState())"
        
        VbetMoney = 0
        playerMoney.text = "You have $"+String(VplayerMoney)
        betMoney.text = "$"+String(VbetMoney)
        
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = true
        player.reset()
        dealer.reset()
    }
    
}

