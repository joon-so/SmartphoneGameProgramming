//
//  GameController.swift
//  Anagrams
//
//  Created by KPUGAME on 2021/04/25.
//  Copyright © 2021 Caroline. All rights reserved.
//

import Foundation
import UIKit

class GmaeController: TileDragDelegateProtocol {
    var gameView: UIView!
    var level: Level!
    var audioController: AudioController
    
    var tiles: [TileView]
    var targets: [TargetView]
    var hub: HUDView!
    
    private var seconsLeft: Int = 0
    private var timer: Timer? = nil
    
    var data = GameData()
    init() {
        tiles = []
        targets = []
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
    }
    
    func startWatch() {
        seconsLeft = level.timeToSolve
        hub.stopWatch.setSeconds(seconsLeft)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.tick(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func tick(_ timer: Timer) {
        seconsLeft -= 1
        hub.stopWatch.setSeconds(seconsLeft)
        if seconsLeft == 0 {
            self.stopWatch()
        }
    }
    
    func stopWatch() {
        timer?.invalidate()
        timer = nil
    }
    
    func tileView(tileView: TileView, didDragToPoint point: CGPoint) {
        var targetView: TargetView?
        
        for target in targets {
            if target.frame.contains(point) && !target.isMatched {
                targetView = target
                break
            }
        }
        
        if let tgv = targetView {
            if tgv.letter == tileView.letter {
                self.placeTile(tileView: tileView, targetView: tgv)
                
                data.points += level.pointsPerTile
                hub.gamePoints.setValue(newValue: data.points, duration: 0.5)
                
                audioController.playerEffect(name: SoundDing)
                
                self.checkForSuccess()
            } else {
                //print("Failure. Let the player know this tile doesn't belong here")
                tileView.randomize()
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0.0,
                    options: UIView.AnimationOptions.curveEaseOut,
                    animations: {
                        tileView.center = CGPoint(
                            x: tileView.center.x + CGFloat(randomNumber(minX: 0, maxX: 40) - 20),
                            y: tileView.center.y + CGFloat(randomNumber(minX: 20, maxX: 30)))
                    },
                    completion: nil)
            }
            data.points -= level.pointsPerTile / 2
            hub.gamePoints.setValue(newValue: data.points, duration: 0.5)
            audioController.playerEffect(name: SoundWrong)
        }
    }
    
    func placeTile(tileView: TileView, targetView: TargetView) {
        targetView.isMatched = true
        tileView.isMatched = true
        
        tileView.isUserInteractionEnabled = false
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: {
                tileView.center = targetView.center
                
            },
            completion: { (value: Bool) in
            tileView.transform = CGAffineTransform(rotationAngle: 0)
            targetView.isHidden = true
        })
        let explore = ExplodeView(frame: CGRect(x: tileView.center.x, y: tileView.center.y, width: 10, height: 10))
        tileView.superview?.addSubview(explore)
        tileView.superview?.sendSubviewToBack(explore)
    }
    func checkForSuccess()
    {
        for tgv in targets {
            if !tgv.isMatched {
                return
            }
        }
        self.stopWatch()
        audioController.playerEffect(name: SoundWin)
        
        let firstTarget = targets[0]
        let startX: CGFloat = 0
        let endX: CGFloat = ScreenWidth + 300
        let startY = firstTarget.center.y
        
        let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
        gameView.addSubview(stars)
        gameView.sendSubviewToBack(stars)
        
        UIView.animate(withDuration: 3.0,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                        stars.center = CGPoint(x: endX, y: startY)
                       },
                       completion: {(value: Bool) in
                        stars.removeFromSuperview()
                       })
    }
    
    func dealRandomAnagram() {
        assert(level.anagrams.count > 0, "No level loaded")
        
        self.startWatch()
        
        let randomIndex = randomNumber(minX: 0, maxX: UInt32(level.anagrams.count - 1))
        let anagramPair = level.anagrams[randomIndex]
        
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        
        let anagram1Length = anagram1.characters.count
        let anagram2Length = anagram2.characters.count
        
        print("phrase1[\(anagram1Length)]: \(anagram1)")
        print("phrase2[\(anagram2Length)]: \(anagram2)")
        
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1Length, anagram2Length))) - TileMargin
        
        var xOffset = (ScreenWidth - CGFloat(max(anagram1Length, anagram2Length)) * (tileSide + TileMargin)) / 2.0 + TileMargin / 2.0
        xOffset += tileSide / 2.0
        
        for (index, letter) in anagram2.characters.enumerated() {
            if letter != " " {
                let target = TargetView(letter: letter, sideLength: tileSide)
                
                target.center = CGPoint(x: xOffset + CGFloat(index) * (tileSide + TileMargin), y: ScreenHeight / 4)
                
                gameView.addSubview(target)
                targets.append(target)
            }
        }
        
        for (index, letter) in anagram1.characters.enumerated() {
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                
                tile.center = CGPoint(x: xOffset + CGFloat(index) * (tileSide + TileMargin), y: ScreenHeight / 4 * 3)
                
                tile.randomize()
                tile.dragDelegate = self
                
                gameView.addSubview(tile)
                tiles.append(tile)
            }
        }
    }
}
