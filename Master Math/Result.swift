//
//  Result.swift
//  Master Math
//
//  Created by Asliddin Rasulov on 2/12/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit

class Result: UIViewController {

    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        starsLabel.text = "\(UserDefaults.standard.integer(forKey: "stars"))" + " / 810 ★"
        correctLabel.text = "\(UserDefaults.standard.integer(forKey: "correct"))" + " / 4050"
        wrongLabel.text = "\(UserDefaults.standard.integer(forKey: "wrong"))" + " / 4050"
        scoreLabel.text = "\(UserDefaults.standard.integer(forKey: "score"))" + " / 405000"
        progress.progress = Float(CGFloat(UserDefaults.standard.integer(forKey: "score") / 405000))
    }
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clear(_ sender: UIButton) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        dismiss(animated: true, completion: nil)
    }
}
