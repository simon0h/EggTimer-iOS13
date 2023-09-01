//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer: Timer?
    var totalTime: Float = 0.0
    var secondsLeft: Float = 0.0
    
    @IBOutlet weak var eggText: UILabel!
    @IBOutlet weak var timerProgressBar: UIProgressView!
    
    @objc func updateTimer () { //@objc is required because the Timer function is an Obj-C method
        secondsLeft -= 1
        timerProgressBar.progress = Float(secondsLeft/totalTime)
        print(timerProgressBar.progress)
        if (secondsLeft == 0.0) {
            eggText.text = "Done"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) { //_ means when this is called, "sender" keyword does not have to be used
        timer?.invalidate()
        let hardness = sender.currentTitle!
        totalTime = Float(eggTimes[hardness]!)
        secondsLeft = Float(eggTimes[hardness]!)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        //timeInterval is how long the wait is
        //Function passed to selector then gets called
    }
    
}
