//
//  Tests.swift
//  Master Math
//
//  Created by Asliddin Rasulov on 2/10/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit

class Tests: UIViewController {

    @IBOutlet var borderViews: [UIView]!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet var answarsButtons: [UIButton]!
    @IBOutlet var progressView: [UIView]!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var answarsStackView: UIStackView!
    @IBOutlet weak var viewTrueFalse: UIView!
    @IBOutlet weak var playView: UIView!
    
    var calc = Calc()
    
    var level : Int = 0
    var type : String = ""
    var num1 : Int = 0
    var num2 : Int = 0
    var num3 : Int = 0
    var str1 : String = ""
    var str2 : String = ""
    var answars : [String]!
    var score : Int = 0
    var progress : Int = 0
    var min : Int = 0
    var max : Int = 0
    var avg : Int = -10
    var helps : Int = 3
    var isHelp : Bool = true
    var memoryLabel : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelLabel.text = "\(level)"
        typeLabel.text = type
        if typeLabel.text == ""{
            answarsStackView.isHidden = true
            playView.isHidden = false
            helpButton.isHidden = true
        } else {
            test()
        }
    }
    func test() {
        difficulty()
        
        if type == "÷" {
            num2 = getNumber(min: min, max: max)
            num1 = getNumber(min: min, max: min + 5) * num2
        } else {
            num1 = getNumber(min: min, max: max)
            num2 = getNumber(min: min, max: max)
        }
        if typeLabel.text == "±" {
            num3 = getNumber(min: min, max: max)
            testLabel.text = "\(num1)" + "  " + type + "  " + "\(num2)" + "  " + type + "  " + "\(num3)"
        } else
        if typeLabel.text == "⚖︎" {
            testLabel.text = "A : \(num1)" +
            """
            
            B : \(num2)
            """
        } else
        if typeLabel.text == "✓ ✘" {
            answarsStackView.isHidden = true
            viewTrueFalse.isHidden = false
            helpButton.isHidden = true
            let typ = ["+", "-"]
            str1 = "\(num1)" + "  " + typ.randomElement()! + " " + "\(num2)"
            num1 = getNumber(min: min, max: max)
            num2 = getNumber(min: min, max: max)
            str2 = "\(num1)" + "  " + typ.randomElement()! + "  " + "\(num2)"
            testLabel.text = str1 +
            """
                
            \(type)
            """
            +
            """
            
            \(str2)
            """
        } else
        if typeLabel.text == "" {
            
        } else {
            testLabel.text = "\(num1)" + "  " + type + "  " + "\(num2)"
        }
        if typeLabel.text == "✓ ✘" {
            answars = ["✓", "✘"]
        } else
        if typeLabel.text == "⚖︎" {
            answars = ["A > B", "A < B", "A = B"]
            answars.shuffle()
        } else {
            answars = [result(), "\(getNumber(min: Int(result())! - 10, max: Int(result())! - 1))", "\(getNumber(min: Int(result())! + 1, max: Int(result())! + 10))"]
            answars.shuffle()
        }
        if typeLabel.text != "✓ ✘" {
            for i in 0..<answarsButtons.count {
                answarsButtons[i].setTitle(answars[i], for: .normal)
            }
        }
    }
    func result() -> String {
        var result : String = ""
        if typeLabel.text == "" {
            do {
                result = try calc.compute(str: memoryLabel).result
            } catch { }
        } else
        if typeLabel.text == "✓ ✘" {
            do {
                str1 = try calc.compute(str: str1.replacingOccurrences(of: " ", with:  "")).result
                str2 = try calc.compute(str: str2.replacingOccurrences(of: " ", with:  "")).result
            } catch { }
            
            if Int(str1)! > Int(str2)! && type == ">" {
                result = "✓"
            } else
            if Int(str1)! > Int(str2)! && type != ">" {
                result = "✘"
            }
            if Int(str1)! < Int(str2)! && type == "<" {
                result = "✓"
            } else
            if Int(str1)! < Int(str2)! && type != "<" {
                result = "✘"
            }
            if Int(str1)! == Int(str2)! && type == "=" {
                result = "✓"
            } else
            if Int(str1)! == Int(str2)! && type != "=" {
                result = "✘"
            }
        } else
        if typeLabel.text == "⚖︎" {
            if num1 > num2 {
                result = "A > B"
            } else
            if num1 < num2 {
                result = "A < B"
            } else
            if num1 == num2 {
                result = "A = B"
            }
        } else {
            do {
                result = try calc.compute(str: testLabel.text!.replacingOccurrences(of: " ", with:  "")).result
            } catch { }
        }
        return result
    }
    
    func difficulty() {
        avg = level * 10 - 20
        
        type = randType()
        
        if type == "+" || type == "-" || type == "±" {
            min = level * (10 + avg) / 2
            max = level * (20 + avg)
        } else
        if typeLabel.text == "⚖︎" {
            max = level * abs(avg)
            min = max * (-1)
        } else {
            min = (level / 10) * 10
            max = level * 5
        }
    }
    func randType() -> String {
        if typeLabel.text == "MIX" {
            let operand = ["+", "-", "×", "÷"]
            type = operand.randomElement()!
        } else
        if typeLabel.text == "±" {
            let operand = ["+", "-"]
            type = operand.randomElement()!
        } else
        if typeLabel.text == "✓ ✘" {
            let operand = [">", "<", "="]
            type = operand.randomElement()!
        }
        return type
    }
    @IBAction func startTimerText(_ sender: UIButton) {
        playView.isHidden = true
        testLabel.font = UIFont(name: "Chalkboard SE", size: 100)
        timerTextAnimate()
    }
    func timerTextAnimate() {
        min = -5 * level
        max = 5 * level
        num1 = getNumber(min: self.min, max: self.max)
        
        UIView.transition(with: self.testLabel, duration: 2.5, options: .transitionFlipFromLeft, animations: {
            if self.num2 != 0 && self.num1 >= 0 {
                self.testLabel.text = "+" + "\(self.num1)"
            } else {
                self.testLabel.text = "\(self.num1)"
            }
            self.memoryLabel += self.testLabel.text!
            self.num2 += 1
        }, completion: { (finished: Bool) -> () in
            if self.level < 3 {
                self.memory(equal: 3)
            } else {
                self.memory(equal: self.level)
            }
            
        })
    }
    func memory(equal : Int) {
        if self.num2 == equal {
            self.testLabel.text = ""
            self.answarsStackView.isHidden = false
            self.helpButton.isHidden = false
            self.answars = [self.result(), "\(getNumber(min: Int(self.result())! - 10, max: Int(self.result())! - 1))", "\(getNumber(min: Int(self.result())! + 1, max: Int(self.result())! + 10))"]
            self.answars.shuffle()
            for i in 0..<self.answarsButtons.count {
                self.answarsButtons[i].setTitle(self.answars[i], for: .normal)
            }
            return
        } else {
            self.timerTextAnimate()
        }
    }
    
    @IBAction func pushAnswars(_ sender: UIButton) {
        for i in 0...2 {
            borderViews[i].layer.borderColor = UIColor.init(red: 30 / 255.0, green: 56 / 255.0, blue: 146 / 255.0, alpha: 1).cgColor
            answarsButtons[i].isHidden = false
        }
        
        if sender.currentTitle == result() {
            score += 100
            progressView[progress].backgroundColor = UIColor(red: 0, green: 130 / 255.0, blue: 62 / 255.0, alpha: 1)
            scoreLabel.text = "\(score)"
            test()
        } else {
            progressView[progress].backgroundColor = .red
            test()
        }
        progress += 1
        isHelp = true
        if typeLabel.text == "" {
            num2 = 0
            memoryLabel = ""
            answarsStackView.isHidden = true
            helpButton.isHidden = true
            timerTextAnimate()
        }
        if progress == 15 {
            let vc = storyboard?.instantiateViewController(identifier: "win") as! Win
            vc.type = typeLabel.text!
            vc.level = level
            vc.score = score
            present(vc, animated: true, completion: nil )
        }
    }
    @IBAction func back(_ sender: UIButton) {
        if isVoice {
            playSoundWith(fileName: "Click", fileExtinsion: "mp3")
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func helpButton(_ sender: UIButton) {
        if isHelp {
            for i in 0...2 {
                if answarsButtons[i].currentTitle != "\(result())" {
                    helps -= 1
                    borderViews[i].layer.borderColor = UIColor.white.cgColor
                    answarsButtons[i].isHidden = true ; break
                }
            }
            helpButton.setTitle("HELP (" + "\(helps)" + ")" , for: .normal)
            if helps == 0 {
                helpButton.isHidden = true
            }
            isHelp = false
        }
    }
}
func getNumbersInRange(min:Int, max:Int, count:Int) -> [Int] {
    var arr = [Int]()
    let getRandom = randomSequenceGenerator(min: min, max: max)
    for _ in 1...count {
        arr.append(getRandom())
    }
    return arr
}

func getNumber(min:Int, max:Int) -> Int {
    return randomSequenceGenerator(min: min, max: max)()
}

func randomSequenceGenerator(min: Int, max: Int) -> () -> Int {
    var numbers: [Int] = []
    return {
        if numbers.isEmpty {
            numbers = Array(min ... max)
        }
        let index = Int(arc4random_uniform(UInt32(numbers.count)))
            return numbers.remove(at: index)
    }
}
