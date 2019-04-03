//
//  Bot.swift
//  TicTacToe
//
//  Created by Henrik Peters on 08.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

class Bot {
    //    0 |  1  |  2
    //  ----------------
    //    3 |  4  |  5
    //  ----------------
    //    6 |  7  |  8
    
    //TODO - Lock field when Bot is choosing
    
    var game: Game
    let hardmode = true //at the moment only the hardmode is implemented
    
    var crossState: GameBoard
    var circleState: GameBoard
    
    init(for game: Game) {
        self.game = game
        self.crossState = self.game.getBoard(for: .X)!
        self.circleState = self.game.getBoard(for: .O)!
    }
    
    func set(game: Game) {
        self.game = game
        self.crossState = self.game.getBoard(for: .X)!
        self.circleState = self.game.getBoard(for: .O)!
    }
    
    func updateStates() {
        self.crossState = self.game.getBoard(for: .X)!
        self.circleState = self.game.getBoard(for: .O)!
    }
    
    func makeRandomChoice() -> Int? {
        let randomIndex = generateRandomIndex() ?? 9
        if randomIndex != 9 {
            self.game.setField(at: randomIndex, value: true, for: .O)
            return randomIndex
        } else {
            return 9
        }
    }
    
    private func generateRandomIndex() -> Int? {
        var indices = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        var toRemove = Array<Int>()
        for index in indices {
            if self.crossState.getState(at: index)! || self.circleState.getState(at: index)! {
                toRemove.append(index)
            }
        }
        for index in toRemove {
            indices = indices.filter { $0 != index }
        }
        return indices.randomElement() ?? nil
    }
}
