//
//  Win.swift
//  Master Math
//
//  Created by Asliddin Rasulov on 2/10/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit

class Win: UIViewController {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var markLabels: [UILabel]!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    var type : String = ""
    var level : Int = 0
    var score : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeLabel.text = type
        levelLabel.text = "Level " + "\(level)"
        scoreLabel.text = "\(score)"
        if score > UserDefaults.standard.integer(forKey: "score\(type)\(level)") {
            UserDefaults.standard.set(score, forKey: "score\(type)\(level)")
        }
    
        check()
    }
    func check() {
        if score >= 900 && score < 1125 {
            markLabels[0].textColor = UIColor.init(red: 30 / 255.0, green: 56 / 255.0, blue: 146 / 255.0, alpha: 1)
        } else
        if score >= 1125 && score < 1325 {
            for i in 0...1 {
                markLabels[i].textColor = UIColor.init(red: 30 / 255.0, green: 56 / 255.0, blue: 146 / 255.0, alpha: 1)
            }
        } else
        if score >= 1325 {
            for i in 0...2 {
                markLabels[i].textColor = UIColor.init(red: 30 / 255.0, green: 56 / 255.0, blue: 146 / 255.0, alpha: 1)
            }
        } else {
            nextView.isHidden = true
        }
    }
    @IBAction func retry(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "tests") as! Tests
        vc.type = type
        vc.level = level
        vc.score = 0
        present(vc, animated: true, completion: nil)
    }
    @IBAction func backMenu(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "levels") as! SelectLevels
        vc.type = type
        present(vc, animated: true, completion: nil)
    }
    @IBAction func next(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "tests") as! Tests
        vc.level = level + 1
        vc.type = type
        vc.score = 0
        present(vc, animated: true, completion: nil)
    }
    
}
