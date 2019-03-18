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
    @IBOutlet weak var clearScoreButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var botLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    
    @IBOutlet weak var difficultySlider: UISlider!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    let game = Botgame()
    private var playerScore = 0
    private var botScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.autolayoutButtons()
        self.autolayoutLines()
        self.styleButtons()
        self.styleLines()
        self.styleWinnerLabel()
        self.stylePlayerLabels()
        self.setDifficultyLabel()
    }

    func autolayoutButtons() {
        let offset = self.gameView.bounds.height / 3
        let size = offset - 20
        var tagCounter = 0
        var positionOffsetX = -offset
        var positionOffsetY = -offset
        
        for button in self.tics {
            button.tag = tagCounter
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: size).isActive = true
            button.heightAnchor.constraint(equalToConstant: size).isActive = true
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
    
    func stylePlayerLabels() {
        self.playerLabel.text = "Players Score: 0"
        self.botLabel.text = "Bots Score: 0"
    }
    
    func setDifficultyLabel() {
        if self.difficultySlider.value < 0.3 {
            self.difficultyLabel.text = "Easy"
        } else if self.difficultySlider.value >= 0.3 && self.difficultySlider.value < 0.7 {
            self.difficultyLabel.text = "Challenging"
        } else if self.difficultySlider.value >= 0.7 && self.difficultySlider.value != 1.0 {
            self.difficultyLabel.text = "Hard"
        } else if self.difficultySlider.value == 1.0 {
            self.difficultyLabel.text = "Unbeatable"
        }
    }
    
    @IBAction func tick(sender: UIButton) {
        if self.game.getState(at: sender.tag) == Piece.E && !self.game.isWin && !self.game.isDraw {
            self.game.move(location: sender.tag)
            if !self.game.isWin || !self.game.isDraw {
                self.game.moveBot(with: self.difficultySlider.value)
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
        self.updateUI()
    }
    
    @IBAction func clearGame(_ sender: Any) {
        for button in self.tics {
            button.setTitle(" ", for: .normal)
        }
        self.winnerLabel.isHidden = true
        self.game.clear()
    }
    
    @IBAction func clearScore(_ sender: Any) {
        self.clearGame(sender)
        self.playerScore = 0
        self.botScore = 0
        self.playerLabel.text = "Players Score: \(playerScore)"
        self.botLabel.text = "Bots Score: \(botScore)"
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        self.setDifficultyLabel()
    }
    
    private func updateUI() {
        for button in self.tics {
            button.setTitle(self.game.getPositions()[button.tag].rawValue, for: .normal)
        }
        
        if self.game.isWin {
            if self.game.getBoard().whoWon == .X {
                self.winnerLabel.text = " You Won! "
                self.winnerLabel.isHidden = false
                self.playerScore += 1
                self.playerLabel.text = "Players Score: \(playerScore)"
            } else if self.game.getBoard().whoWon == .O {
                self.winnerLabel.text = " The Bot Won! "
                self.winnerLabel.isHidden = false
                self.botScore += 1
                self.botLabel.text = "Bots Score: \(botScore)"
            }
        } else if self.game.isDraw {
            // Tie
            self.winnerLabel.text = " Tie "
            self.winnerLabel.isHidden = false
        }
    }
}
