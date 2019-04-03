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
    @IBOutlet weak var clearScoreButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    @IBOutlet weak var turnPhoneLabel: UILabel!
    
    let game = Game()
    
    private var player1Text = "Player 1:"
    private var player1ScoreValue = 0
    private var player2Text = "Player 2:"
    private var player2ScoreValue = 0
    
    private var gameCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.autolayoutButtons()
        self.autolayoutLines()
        self.styleButtons()
        self.styleLines()
        self.styleWinnerLabel()
        self.stylePlayerLabels()
        self.styleTurnPhoneLabel()
    }
    
    //MARK - Setup and Layout
    func autolayoutButtons() {
        let offset = self.gameView.frame.size.height / 3
        let size = offset - 20
        var tagCounter = 0
        var positionOffsetX = -offset
        var positionOffsetY = -offset
        
        for button in self.tics {
            button.tag = tagCounter
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addConstraints([
                NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size),
                NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size)
                ])
            tagCounter += 1
            
            button.centerXAnchor.constraint(equalTo: self.gameView.centerXAnchor, constant: positionOffsetX).isActive = true
            button.centerYAnchor.constraint(equalTo: self.gameView.centerYAnchor, constant: positionOffsetY).isActive = true
            
            if positionOffsetX < 0 { positionOffsetX = 0 }
            else if positionOffsetX == 0 { positionOffsetX = offset }
            else if positionOffsetX > 0 { positionOffsetX = -offset }
            if tagCounter == 3 { positionOffsetY = 0 }
            else if tagCounter == 6 { positionOffsetY = offset }
        }
    }
    
    func autolayoutLines() {
        let offset = self.gameView.frame.height / 6
        self.lines[0].centerXAnchor.constraint(equalTo: self.gameView.centerXAnchor, constant: -offset).isActive = true
        self.lines[1].centerXAnchor.constraint(equalTo: self.gameView.centerXAnchor, constant: offset).isActive = true
        self.lines[2].centerYAnchor.constraint(equalTo: self.gameView.centerYAnchor, constant: -offset).isActive = true
        self.lines[3].centerYAnchor.constraint(equalTo: self.gameView.centerYAnchor, constant: offset).isActive = true
    }
    
    func styleTurnPhoneLabel() {
        self.turnPhoneLabel.layer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.turnPhoneLabel.layer.cornerRadius = 10
        self.turnPhoneLabel.layer.borderColor = UIColor.black.cgColor
        self.turnPhoneLabel.layer.borderWidth = 0.5
        self.turnPhoneLabel.isHidden = true
    }
    
    func stylePlayerLabels() {
        self.player1Label.text = player1Text
        self.player1Label.font = UIFont.boldSystemFont(ofSize: 30)
        self.player1Score.text = String(player1ScoreValue)
        self.player1Score.font = UIFont.boldSystemFont(ofSize: 30)
        
        self.player2Label.text = player2Text
        self.player2Label.font = UIFont.boldSystemFont(ofSize: 30)
        self.player2Score.text = String(player2ScoreValue)
        self.player2Score.font = UIFont.boldSystemFont(ofSize: 30)
        self.player2Label.transform = CGAffineTransform(rotationAngle: .pi)
        self.player2Score.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func styleButtons() {
        let buttonCornerRadius = ((self.gameView.frame.size.height / 3) - 20) / 2
        for button in self.tics {
            button.backgroundColor = .white
            button.layer.cornerRadius = buttonCornerRadius
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
            button.setTitle("", for: .normal)
        }
        
        self.clearButton.layer.cornerRadius = 10
        self.clearButton.layer.borderWidth = 0.5
        self.clearButton.layer.borderColor = UIColor.black.cgColor
        
        self.clearScoreButton.layer.cornerRadius = 10
        self.clearScoreButton.layer.borderWidth = 0.5
        self.clearScoreButton.layer.borderColor = UIColor.black.cgColor
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
    
    //MARK - IBActions
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
        if self.game.checkStates() != FieldState.E {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.switchLabels()
            }
        }
        self.game.clear()
    }
    
    @IBAction func clearScores(_ sender: Any) {
        self.player1ScoreValue = 0
        self.player2ScoreValue = 0
        self.gameCounter = 0
        self.updateScoreLabels()
    }
    
    //MARK - Helping Functions
    private func checkState() {
        //First Idea: IF IF IF --> Second Idea: magic Square (maybe implemented later or for bigger games)
        if self.game.checkStates() == FieldState.X {
            // Cross Wins!
            self.winnerLabel.text = " Cross Wins! "
            self.winnerLabel.isHidden = false
            self.player1ScoreValue += 1
            self.gameCounter += 1
            self.updateScoreLabels()
        } else if self.game.checkStates() == FieldState.O {
            // Circle Wins!
            self.winnerLabel.text = " Circle Wins! "
            self.winnerLabel.isHidden = false
            self.player2ScoreValue += 1
            self.gameCounter += 1
            self.updateScoreLabels()
        } else if self.game.checkStates() == FieldState.T {
            // Tie
            self.winnerLabel.text = " Tie "
            self.winnerLabel.isHidden = false
        }
    }
    
    private func updateScoreLabels() {
        self.player1Label.text = player1Text
        self.player1Score.text = String(player1ScoreValue)
        self.player2Label.text = player2Text
        self.player2Score.text = String(player2ScoreValue)
    }
    
    private func switchLabels() {
        self.turnPhoneLabel.alpha = 0
        self.turnPhoneLabel.isHidden = false
        UIView.animate(withDuration: 0.2, animations: { () -> Void in self.turnPhoneLabel.alpha = 1 }) { (Bool) -> Void in UIView.animate(withDuration: 0.2, delay: 1, options: .curveEaseOut, animations: { () -> Void in self.turnPhoneLabel.alpha = 0
            }, completion: nil)
        }
        if self.gameCounter % 2 == 0 {
            self.player1Label.text = player1Text
            self.player1Score.text = String(player1ScoreValue)
            self.player2Label.text = player2Text
            self.player2Score.text = String(player2ScoreValue)
        } else if self.gameCounter % 2 == 1 {
            self.player1Label.text = player2Text
            self.player1Score.text = String(player2ScoreValue)
            self.player2Label.text = player1Text
            self.player2Score.text = String(player1ScoreValue)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.turnPhoneLabel.isHidden = true
        })
    }
}
