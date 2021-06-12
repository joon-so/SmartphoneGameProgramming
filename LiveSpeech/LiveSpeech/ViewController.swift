//
//  ViewController.swift
//  LiveSpeech
//
//  Created by KPUGAME on 2021/04/18.
//

import UIKit
import Speech

class ViewController: UIViewController {
    @IBOutlet weak var transcribeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    @IBAction func startTranscribing(_ sender: Any) {
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
    }
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            transcribeButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
    
    func startSession() throws {
        if let recognitionTask = speechRecognitionTask {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else
        { fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed")}
        
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest){
            result, error in
            var finished = false
            
            if let result = result {
                self.myTextView.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                self.transcribeButton.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            
            self.speechRecognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func authorizeSR() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition not autorized", for: .disabled)
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeSR()
        // Do any additional setup after loading the view.
    }


}

