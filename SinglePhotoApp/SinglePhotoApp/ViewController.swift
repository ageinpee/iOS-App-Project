//
//  ViewController.swift
//  SinglePhotoApp
//
//  Created by Henrik Peters on 28.02.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var songPicker: UIPickerView!
    @IBOutlet weak var pickerBackgroundView: UIView!
    
    let dataSource = [URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Dario", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Das Erbe der Könige", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Ein Dorf in Trümmern", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Willkommen in Cleycourt", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Das Heer aus dem Süden", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Die Festung im schnee", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Evelance", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Prophezeiungen", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Der Königliche Hof", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Im sicheren Hafen", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Reise gen Süden", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Norfolk", ofType: "mp3")!),
                      URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Der schwarze Ritter", ofType: "mp3")!),]
    let titles = ["Dario", "Das Erbe der Könige", "Ein Dorf in Trümmern", "Willkommen in Cleycourt", "Das Heer aus dem Süden", "Die Festung im Schnee", "Evelance", "Prophezeiungen", "Der Königliche Hof", "Im sicheren Hafen", "Reise gen Süden", "Norfolk", "Der schwarze Ritter"]
    var currentSelected = URL(fileURLWithPath: Bundle.main.path(forResource: "Die Siedler V Das Erbe der Könige OST- Dario", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupButtons()
        self.pickerBackgroundView.setGradientBackground(colorOne: UIColor.black.withAlphaComponent(0.0),
                                              colorTwo: UIColor.black.withAlphaComponent(0.7))
        
        currentSelected = dataSource[0]
        songPicker.delegate = self
        songPicker.dataSource = self
    }

    @IBAction func stopButtonAction(_ sender: Any) {
        audioPlayer.stop()
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: currentSelected)
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelected = dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: titles[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    func setupButtons() {
        self.playButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.playButton.layer.cornerRadius = 10
        self.playButton.layer.borderColor = UIColor.white.cgColor
        self.playButton.layer.borderWidth = 1
        self.playButton.setImage(UIImage(named: "icon_play") as! UIImage, for: .normal)
        self.playButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        self.stopButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.stopButton.layer.cornerRadius = 10
        self.stopButton.layer.borderColor = UIColor.white.cgColor
        self.stopButton.layer.borderWidth = 1
        self.stopButton.setImage(UIImage(named: "icon_stop") as! UIImage, for: .normal)
        self.stopButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}
