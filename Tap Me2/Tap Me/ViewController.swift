//
//  ViewController.swift
//  Tap Me
//
//  Created by KPUGAME on 2021/03/08.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    //라벨 프라퍼티 선언
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    var buttonBeep : AVAudioPlayer?
    var secondBeep : AVAudioPlayer?
    var backgroundMusic : AVAudioPlayer?
    
    var count = 0
    
    var seconds = 0
    var timer = Timer()
    
    func setupGame() {
        seconds = 30
        count = 0
        
        timerLabel.text = "Time: \(seconds)"
        scoreLabel.text = "Score: \n\(count)"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.subtrackTime), userInfo: nil, repeats: true)
        
        backgroundMusic?.volume = 0.3
        backgroundMusic?.play()
    }

    
    @objc func subtrackTime() {
        seconds -= 1
        timerLabel.text = "Time: \(seconds)"
        
        secondBeep?.play()
        
        if(seconds == 0){
            timer.invalidate()
            
        }
    }
    
    //버튼을 누르면 실행되는 메소드 추가
    @IBAction func buttonPressed() {
        count += 1
        
        scoreLabel.text = "Score \n\(count)"
        //NSLog("Button Pressed")
    }
    
    func setupAudioPlalerWithFile(file:NSString, type:NSString) -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: file as String, ofType: type as String)
        let url = NSURL.fileURL(withPath: path!)
        
        var audioPlayer: AVAudioPlayer?
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print("Player not available")
        }
        return audioPlayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let buttonBeep = self.setupAudioPlalerWithFile(file: "ButtonTap", type: "wav"){
            self.buttonBeep = buttonBeep
        }
        if let secondBeep = self.setupAudioPlalerWithFile(file: "SecondBeep", type: "wav"){
            self.secondBeep = secondBeep
        }
        if let backgroundMusic = self.setupAudioPlalerWithFile(file: "HallOfTheMountainKing", type: "mp3") {
            self.backgroundMusic = backgroundMusic
        }
        
        // Do any additional setup after loading the view.
        setupGame()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_tile.png")!)
    
        scoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_score.png")!)
        timerLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_time.png")!)
    }


}

