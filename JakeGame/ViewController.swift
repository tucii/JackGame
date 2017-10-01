//
//  ViewController.swift
//  JakeGame
//
//  Created by Tuğçe Başkan on 30/09/2017.
//  Copyright © 2017 Tugce Baskan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var jack1: UIImageView!
    @IBOutlet weak var jack2: UIImageView!
    @IBOutlet weak var jack3: UIImageView!
    @IBOutlet weak var jack4: UIImageView!
    @IBOutlet weak var jack5: UIImageView!
    @IBOutlet weak var jack6: UIImageView!
    @IBOutlet weak var jack7: UIImageView!
    @IBOutlet weak var jack8: UIImageView!
    @IBOutlet weak var jack9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var jackArray = [UIImageView]()
    var hideTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore == nil {
            highscoreLabel.text = "0"
            
        }
        if let newScore = highScore as? Int {
            highscoreLabel.text = String(newScore)
        }
        
        scoreLabel.text = "Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.scoreIncrease))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.scoreIncrease))
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(ViewController.scoreIncrease))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.scoreIncrease))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.scoreIncrease))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.scoreIncrease))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.scoreIncrease))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.scoreIncrease))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.scoreIncrease))
        
        jack1.isUserInteractionEnabled = true
        jack2.isUserInteractionEnabled = true
        jack3.isUserInteractionEnabled = true
        jack4.isUserInteractionEnabled = true
        jack5.isUserInteractionEnabled = true
        jack6.isUserInteractionEnabled = true
        jack7.isUserInteractionEnabled = true
        jack8.isUserInteractionEnabled = true
        jack9.isUserInteractionEnabled = true
        
        jack1.addGestureRecognizer(recognizer1)
        jack2.addGestureRecognizer(recognizer2)
        jack3.addGestureRecognizer(recognizer3)
        jack4.addGestureRecognizer(recognizer4)
        jack5.addGestureRecognizer(recognizer5)
        jack6.addGestureRecognizer(recognizer6)
        jack7.addGestureRecognizer(recognizer7)
        jack8.addGestureRecognizer(recognizer8)
        jack9.addGestureRecognizer(recognizer9)
        
        
        //timers 
        
        counter = 20
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(ViewController.hideJack), userInfo: nil, repeats: true)
        
        //arrays
        
        jackArray.append(jack1)
        jackArray.append(jack2)
        jackArray.append(jack3)
        jackArray.append(jack4)
        jackArray.append(jack5)
        jackArray.append(jack6)
        jackArray.append(jack7)
        jackArray.append(jack8)
        jackArray.append(jack9)
        
        hideJack()
        
        
        
    }
    
    @objc func hideJack() {
        for jack in jackArray {
            jack.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(jackArray.count-1)))
        
        jackArray[random].isHidden = false
    }
    
    
    @objc func countDown(){
        
        counter = counter - 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > Int(highscoreLabel.text!)!{
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highscoreLabel.text = String(self.score)
            }
            
            let alertTime = UIAlertController(title: "Time", message: "Time is Up!", preferredStyle: UIAlertControllerStyle.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 20
                self.timeLabel.text =  "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(ViewController.hideJack), userInfo: nil, repeats: true)
                
            } )
        
        
            alertTime.addAction(replayButton)
            alertTime.addAction(okButton)
            self.present(alertTime, animated: true, completion: nil)
        }
    }
    
    @objc func scoreIncrease () {
        score = score+1
        scoreLabel.text = "Score: \(score)"
        
        
    }

    

}

