//
//  SecondViewController.swift
//  TicTacToe
//
//  Created by Henrik Peters on 04.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    
    // [top-left,    top-center,    top-right
    //  center-left, center-center, center-right
    //  bottom-left, bottom-center, bottom-right]
    @IBOutlet var tics: [UIButton]!
    @IBOutlet var lines: [UIView]!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    
    var crossFlag = true // used to decide weather a X or O is written in the box
    var tickCount = 0
    let game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.autolayoutButtons()
        self.styleButtons()
        self.styleLines()
        self.styleWinnerLabel()
    }

    func autolayoutButtons() {
        let offset = self.gameView.frame.size.height / 3
        let size = offset - 20
        var tagCounter = 0
        
        for button in self.tics {
            button.tag = tagCounter
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addConstraints([
                NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size),
                NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size)
                ])
            tagCounter += 1
        }
    }
    
    func styleButtons() {
        for button in self.tics {
            button.backgroundColor = .white
            button.layer.cornerRadius = 40
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
            button.setTitle("", for: .normal)
        }
        self.clearButton.layer.cornerRadius = 10
        self.clearButton.layer.borderWidth = 0.5
        self.clearButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func styleLines() {
        for line in self.lines {
            line.backgroundColor = .clear
            line.layer.borderWidth = 2
            line.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    func styleWinnerLabel() {
        self.winnerLabel.layer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.winnerLabel.layer.cornerRadius = 10
        self.winnerLabel.layer.borderColor = UIColor.black.cgColor
        self.winnerLabel.layer.borderWidth = 0.5
    }
    
    @IBAction func ticked(sender: UIButton) {
        if sender.title(for: .normal) == "" {
            if self.crossFlag == true {
                sender.setTitle("X", for: .normal)
                self.game.setField(at: sender.tag, value: true, for: Player.X)
                crossFlag = false
            } else {
                sender.setTitle("O", for: .normal)
                self.game.setField(at: sender.tag, value: true, for: Player.O)
                crossFlag = true
            }
        } else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: sender.center.x - 7, y: sender.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: sender.center.x + 7, y: sender.center.y))
            
            sender.layer.add(animation, forKey: "position")
        }
        self.checkState()
    }
    
    @IBAction func clearGame(_ sender: Any) {
        for button in self.tics {
            button.setTitle("", for: .normal)
        }
        self.crossFlag = true
        self.winnerLabel.isHidden = true
        self.tickCount = 0
        self.game.clear()
    }
    
    private func checkState() {
        //First Idea: IF IF IF --> Second Idea: magic Square (maybe implemented later or for bigger games)
        if (self.game.ckeckStates() == FieldState.X) {
            // Cross Wins!
            self.winnerLabel.text = "Cross Wins!"
            self.winnerLabel.isHidden = false
            print("Cross Wins")
        } else if (self.game.ckeckStates() == FieldState.O) {
            // Circle Wins!
            self.winnerLabel.text = "Circle Wins!"
            self.winnerLabel.isHidden = false
            print("Circle Wins")
        }
        if self.tickCount == 9 {
            //Tie!
            print("Tie")
        }
    }
}
