//
//  ViewController.swift
//  Tap Me
//
//  Created by KPUGAME on 2021/03/08.
//

import UIKit

class ViewController: UIViewController {
    //라벨 프라퍼티 선언
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    var count = 0
    
    var seconds = 0
    var timer = Timer()
    
    func setupGame() {
        seconds = 30
        count = 0
        
        timerLabel.text = "Time: \(seconds)"
        scoreLabel.text = "Score: \n\(count)"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.subtrackTime), userInfo: nil, repeats: true)
    }

    
    @objc func subtrackTime() {
        seconds -= 1
        timerLabel.text = "Time: \(seconds)"
        
        if(seconds == 0){
            timer.invalidate()
            
            let alert = UIAlertController(title: "Time is up!", message: "You scired \(count) points" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default, handler: {
                action in self.setupGame()
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    //버튼을 누르면 실행되는 메소드 추가
    @IBAction func buttonPressed() {
        count += 1
        
        scoreLabel.text = "Score \n\(count)"
        //NSLog("Button Pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupGame()
    }


}

