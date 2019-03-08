//
//  FirstViewController.swift
//  TicTacToe
//
//  Created by Henrik Peters on 04.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var gameView: UIView!
    
    // [top-left,    top-center,    top-right
    //  center-left, center-center, center-right
    //  bottom-left, bottom-center, bottom-right]
    @IBOutlet var tics: [UIButton]!
    @IBOutlet var lines: [UIView]!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    
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
    
    @IBAction func tick(sender: UIButton) {
        if self.game.getState(at: sender.tag, for: Player.X) == FieldState.E && self.game.getState(at: sender.tag, for: Player.O) == FieldState.E {
            let resultingPlayer = self.game.setField(at: sender.tag, value: true)
            sender.setTitle(resultingPlayer.rawValue, for: .normal)
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
        self.winnerLabel.isHidden = true
        self.game.clear()
    }
    
    private func checkState() {
        //First Idea: IF IF IF --> Second Idea: magic Square (maybe implemented later or for bigger games)
        if self.game.checkStates() == FieldState.X {
            // Cross Wins!
            self.winnerLabel.text = " Cross Wins! "
            self.winnerLabel.isHidden = false
            print("Cross Wins")
        } else if self.game.checkStates() == FieldState.O {
            // Circle Wins!
            self.winnerLabel.text = " Circle Wins! "
            self.winnerLabel.isHidden = false
            print("Circle Wins")
        } else if self.game.checkStates() == FieldState.T {
            // Tie
            self.winnerLabel.text = " Tie "
            self.winnerLabel.isHidden = false
        }
    }
}
