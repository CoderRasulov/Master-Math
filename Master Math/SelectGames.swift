//
//  ViewController.swift
//  Master Math
//
//  Created by Asliddin Rasulov on 2/9/20.
//  Copyright © 2020 Asliddin. All rights reserved.
//
import UIKit
import AudioToolbox
import AVFoundation

var audioPlayer: AVAudioPlayer!

func playSoundWith(fileName: String, fileExtinsion: String) -> Void {
    
    let audioSourceURL = Bundle.main.path(forResource: fileName, ofType: fileExtinsion)
    
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioSourceURL!))
    } catch {
        print(error)
    }
    audioPlayer.play()
}

let gameTitleNames = ["ADDITION", "SUBTRACTION", "PLUS MINUS", "MULTIPLICATION", "DIVISION", "MIX", "EQUALITY", "TRUE or FALSE", "MEMORY"]
let gameNames = ["+", "-", "±", "×", "÷", """
+ -
× ÷
""", "⚖︎", "✓ ✘", ""]

var isVoice: Bool = true

@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

class SelectGames: UIViewController {
    
    @IBOutlet weak var voiceImageView: UIImageView!
    @IBOutlet weak var vibrationImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func voice(_ sender: UIButton) {
        if sender.tag == 0 {
            isVoice = false
            voiceImageView.image = UIImage(named: "NOVOICE")
            sender.tag = 1
        } else {
            isVoice = true
            playSoundWith(fileName: "Click", fileExtinsion: "mp3")
            voiceImageView.image = UIImage(named: "VOICE")
            sender.tag = 0
        }
    }
    @IBAction func vibratiom(_ sender: UIButton) {
        if isVoice {
            playSoundWith(fileName: "Click", fileExtinsion: "mp3")
        }
        if sender.tag == 0 {
            vibrationImageView.image = UIImage(named: "NOVIBRATION")
            sender.tag = 1
        } else {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) 
            vibrationImageView.image = UIImage(named: "VIBRATION")
            sender.tag = 0
        }
    }
    @IBAction func goResult(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "result") as! Result
        present(vc, animated: true, completion: nil)
    }
}
extension SelectGames: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameTitleNames.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCell", for: indexPath) as! GamesCell
        if indexPath.row == 8 {
            let imageMemory = UIImageView(frame: CGRect(x: 0.3 * cell.frame.width, y: 0.2 * cell.frame.height, width: 0.4 * cell.frame.width, height: 0.4 * cell.frame.height))
            imageMemory.contentMode = .scaleAspectFill
            imageMemory.image = UIImage(named: "MEMORY")
            cell.addSubview(imageMemory)
        }
        cell.nameLabelView.text = gameNames[indexPath.row]
        cell.titleLabelView.text = gameTitleNames[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (0.9 * view.frame.width - 20) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isVoice {
            playSoundWith(fileName: "Click", fileExtinsion: "mp3")
        }
        let vc = storyboard?.instantiateViewController(identifier: "levels") as! SelectLevels
        if indexPath.row == 5 {
            vc.type = gameTitleNames[indexPath.row]
        } else {
            vc.type = gameNames[indexPath.row]
        }
        present(vc, animated: true, completion: nil)
    }
}

