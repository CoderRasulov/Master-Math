//
//  SelectLevel.swift
//  Master Math
//
//  Created by Asliddin Rasulov on 2/9/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//

import UIKit

class SelectLevels: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var type : String = ""
    var stars : Int = 0
    var correct : Int = 0
    var wrong : Int = 0
    var score : Int = 0
    var noPush : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.set(stars, forKey: "stars")
        UserDefaults.standard.set(correct, forKey: "correct")
        UserDefaults.standard.set(wrong, forKey: "wrong")
        UserDefaults.standard.set(score, forKey: "score")
    }
    @IBAction func back(_ sender: UIButton) {
        if isVoice {
            playSoundWith(fileName: "Click", fileExtinsion: "mp3")
        }
        dismiss(animated: true, completion: nil)
    }
    func marks(score : Int, markLabelsView : [UILabel]) {
        if score >= 900 && score < 1125 {
            stars += 1
            markLabelsView[0].textColor = .white
        } else
        if score >= 1125 && score < 1325 {
            stars += 2
            for i in 0...1 {
                markLabelsView[i].textColor = .white
            }
        } else
        if score >= 1325 {
            stars += 3
            for i in 0...2 {
                markLabelsView[i].textColor = .white
            }
        }
    }
}
extension SelectLevels: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as! LevelCell
        for i in 1...31 {
            if indexPath.row == i {
                if UserDefaults.standard.integer(forKey: "score\(type)\(indexPath.item)") >= 900 {
                    cell.blockView.isHidden = true
                    noPush = indexPath.row
                } else {
                    cell.blockView.isHidden = false
                }
            }
        }
        cell.pointLabelView.text = UserDefaults.standard.string(forKey: "score\(type)\(indexPath.item + 1)")
        cell.numLabelView.text = "\(indexPath.item + 1)"
        marks(score: UserDefaults.standard.integer(forKey: "score\(type)\(indexPath.item + 1)"), markLabelsView: cell.markLabelsView)
        correct += (UserDefaults.standard.integer(forKey: "score\(type)\(indexPath.item + 1)") / 100)
        if UserDefaults.standard.integer(forKey: "score\(type)\(indexPath.item + 1)") != 0 {
            wrong += 15 - (UserDefaults.standard.integer(forKey: "score\(type)\(indexPath.item + 1)") / 100)
        }
        score += UserDefaults.standard.integer(forKey: "score\(type)\(indexPath.item + 1)")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (0.9 * view.frame.width - 20) / 3 - 8
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row <= noPush {
            if isVoice {
                playSoundWith(fileName: "Click", fileExtinsion: "mp3")
            }
            let vc = storyboard?.instantiateViewController(identifier: "tests") as! Tests
            vc.level = indexPath.row + 1
            vc.type = type
            present(vc, animated: true, completion: nil)
        }
    }
}

