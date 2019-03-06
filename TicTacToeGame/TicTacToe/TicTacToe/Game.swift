//
//  Game.swift
//  TicTacToe
//
//  Created by Henrik Peters on 06.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

class Game {
    
    var crossBoard = GameBoard()
    var circleBoard = GameBoard()
    
    func ckeckStates() -> FieldState {
        if crossBoard.checkState() {return FieldState.X}
        else if circleBoard.checkState() {return FieldState.O}
        else {return FieldState.E}
    }
    
    func setField(at index: Int, value: Bool, for player: FieldState) {
        if player == FieldState.X {
            self.crossBoard.setState(at: index, value: value)
        } else if player == FieldState.O {
            self.circleBoard.setState(at: index, value: value)
        }
    }
    
    func clear() {
        self.crossBoard.clear()
        self.circleBoard.clear()
    }
}
