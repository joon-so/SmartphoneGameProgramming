//
//  ViewController.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2014 Caroline. All rights reserved.
//
//Anagrams Part2 에서는 tile을 drag해서 target에 위치하도록 하고
//timer와 score를 갖는 heads-up-display(HUD)를 구현한다.

import UIKit

class ViewController: UIViewController {
    private let controller: GameController
    
    required init?(coder aDecoder: NSCoder) {
        controller = GameController()
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let level1 = Level(level: 1)
        // 스크린에 view layer 를 생성 추가하고 GameController 가 관리하게 한다.
        // ScreenWidth, ScreenHeight는 Config.swift에 있는 UI constants
        let gameView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(gameView)
        controller.gameView = gameView
        let hud = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hud)
        controller.hud = hud

        //controller.level = level1
        //controller.dealRandomAnagram()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func showLevelMenu() {
        //1.UIAlertController 생성
        let alertController = UIAlertController(title: "Choose Difficulty Level", message: nil, preferredStyle: .alert)
        //2.UIAlertAction  메뉴와 액션 메소드 showLevel() 연결
        let easy = UIAlertAction(title: "Easy-peasy", style: .default, handler: {
            (alert: UIAlertAction) in
            self.showLevel(1)
        })
        let hard = UIAlertAction(title: "Challenge accepted", style: .default, handler: {
            (alert: UIAlertAction) in
            self.showLevel(2)
        })
        let hardest = UIAlertAction(title: "I'm totally hard-core", style: .default, handler: {
            (alert: UIAlertAction) in
            self.showLevel(3)
        })
        alertController.addAction(easy)
        alertController.addAction(hard)
        alertController.addAction(hardest)
        
        self.present(alertController, animated: true, completion: nil)
    }
    //UIAlertAction 메소드
    func showLevel(_ level: Int) {
        controller.level = Level.init(level: level)
        controller.dealRandomAnagram()
    }
    //메뉴가 보이드록 함
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLevelMenu()
        //puzzle을 solve하면 메뉴를 다시 보이게 함
        controller.onAnagramSolved = self.showLevelMenu
    }
    
 }

