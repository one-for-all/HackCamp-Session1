//
//  ViewController.swift
//  HackCamp
//
//  Created by 迦南 on 4/12/17.
//  Copyright © 2017 迦南. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var endMessage: UILabel!
    
    var initialTime: Int = 10
    var user = User(name: "Sapien", age: 21)
    var timer = Timer()
    var running = false
    var time: Int = 0
    var lastHit = "r"
    var textFieldStatus = 0 //0 is name; 1 is age; 2 is time; 3 is null
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.default
        textField.placeholder = "Enter your name: "
        time = initialTime
        nameLabel.text = "NAME: \(user.name)"
        ageLabel.text = "AGE: \(user.age)"
        scoreLabel.text = "SCORE: \(user.score)"
        timeLabel.text = "TIME: \(time)"
        startButton.setTitle("Start", for: [])
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    func isInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    @IBAction func textField(_ sender: Any) {
        switch textFieldStatus {
        case 0:
            user.name = textField.text!
            textFieldStatus = 1
            textField.placeholder = "Enter your age: "
            textField.keyboardType = UIKeyboardType.numbersAndPunctuation
            textField.text = ""
            nameLabel.text = "NAME: \(user.name)"
            return
        case 1:

            if !isInt(string: textField.text!) {
                textField.placeholder = "Invalid number. Enter your age: "
                textField.text = ""
                return
            }
            user.age = Int(textField.text!)!
            textFieldStatus = 2
            textField.placeholder = "Enter the length of the game: "
            textField.text = ""
            ageLabel.text = "AGE: \(user.age)"
            return
        case 2:
            if !isInt(string: textField.text!) || Int(textField.text!)! <= 0 {
                textField.placeholder = "Invalid number. Enter the length of the game: "
                textField.text = ""
                return
            }
            initialTime = Int(textField.text!)!
            textField.text = "Alternatively hit left and right arrows to get points!"
            textFieldStatus = 3
            textField.isUserInteractionEnabled = false
            textField.keyboardType = UIKeyboardType.default
            timeLabel.text = "TIME: \(initialTime)"
            return
        default:
            break
        }
        return
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
            scoreLabel.text = "SCORE: \(user.score)"
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
            scoreLabel.text = "SCORE: \(user.score)"
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        if !running {
            textFieldStatus = 3
            textField.text = "Alternatively hit left and right arrows to get points!"
            textField.isUserInteractionEnabled = false
            user.score = 0
            scoreLabel.text = "SCORE: \(user.score)"
            time = initialTime
            timeLabel.text = "TIME: \(time)"
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            running = true
            startButton.setTitle("RESET", for: [])
        }
        else {
            textFieldStatus = 0
            textField.isUserInteractionEnabled = true
            textField.placeholder = "Enter your name: "
            textField.text = ""
            textField.keyboardType = UIKeyboardType.default
            user.score = 0
            scoreLabel.text = "SCORE: \(user.score)"
            time = initialTime
            timeLabel.text = "TIME: \(time)"
            timer.invalidate()
            startButton.setTitle("START", for: [])
            running = false
        }
    }
    
    func timerAction() {
        time -= 1
        timeLabel.text = "TIME: \(time)"
        if time == 0{
            let frequency: Float = Float(user.score)/Float(initialTime)
            timer.invalidate()
            running = false
            startButton.setTitle("START", for: [])
            endMessage.text = "Time's up! Your speed: \(frequency) times/sec. "
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

