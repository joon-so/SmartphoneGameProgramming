//
//  AudioController.swift
//  BlackJack
//
//  Created by KPUGAME on 2021/05/25.
//

import AVFoundation

let SoundFlip = "sounds/cardFlip1.wav"
let SoundAgain = "sounds/ding.wav"
let SoundLose = "sounds/wrong.wav"
let SoundWin = "sounds/win.wav"
let SoundChip = "sounds/chip.wav"
let AudioEffectFiles =  [SoundFlip, SoundAgain, SoundLose, SoundWin, SoundChip]

class AudioController {
    private var audio = [String: AVAudioPlayer]()
    
    var player: AVAudioPlayer?
    
    func preloadAudioEffects(audioFileNames: [String]) {
        for effect in AudioEffectFiles {
            let soundPath = Bundle.main.path(forResource: effect, ofType: nil)
            let soundURL = NSURL.fileURL(withPath: soundPath!)
            
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                guard let player = player else {
                    return
                }
                player.numberOfLoops = 0
                player.prepareToPlay()
                
                audio[effect] = player
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func playerEffect(name: String) {
        if let player = audio[name] {
            if player.isPlaying  {
                player.currentTime = 0
            } else {
                player.play()
            }
        }
    }
}
