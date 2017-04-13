//
//  ViewController.swift
//  HackCamp
//
//  Created by 迦南 on 4/12/17.
//  Copyright © 2017 迦南. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    let initialTime: Int = 10
    var user = User(name: "Placeholder", age: 0)
    var timer = Timer()
    var running = false
    var time: Int = 0
    var lastHit = "r"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        user = User(name: "Sapien", age: 21)
        time = initialTime
        nameLabel.text = "Name: \(user.name)"
        ageLabel.text = "Age: \(user.age)"
        scoreLabel.text = "Score: \(user.score)"
        timeLabel.text = "Time: \(time)"
    }

    @IBAction func leftButton(_ sender: UIButton) {
        if running {
            if lastHit == "r" {
                user.score += 1
            }
            else {
                user.score = 0
            }
            lastHit = "l"
            scoreLabel.text = "Score: \(user.score)"
        }
    }
    
    @IBAction func rightButton(_ sender: UIButton) {
        if running {
            if lastHit == "l" {
                user.score += 1
            }
            else {
                user.score = 0
            }
            lastHit = "r"
            scoreLabel.text = "Score: \(user.score)"
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        if !running {
            user.score = 0
            scoreLabel.text = "Score: \(user.score)"
            time = initialTime
            timeLabel.text = "Time: \(time)"
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            running = true
        }
    }
    
    func timerAction() {
        time -= 1
        timeLabel.text = "Time: \(time)"
        if time == 0{
            timer.invalidate()
            running = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

