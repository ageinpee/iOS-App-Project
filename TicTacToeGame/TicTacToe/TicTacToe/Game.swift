//
//  Game.swift
//  TicTacToe
//
//  Created by Henrik Peters on 06.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

class Game {
    
    private var crossBoard = GameBoard()
    private var circleBoard = GameBoard()
    private var crossFlag = true //used switch between X and O
    private var tickCount = 0
    
    
    func checkStates() -> FieldState {
        if self.crossBoard.checkState() {return FieldState.X}
        else if self.circleBoard.checkState() {return FieldState.O}
        else if self.tickCount == 9 {return FieldState.T}
        else {return FieldState.E}
    }
    
    func setField(at index: Int, value: Bool, for player: Player) {
        if player == Player.X {
            self.crossBoard.setState(at: index, value: value)
        } else if player == Player.O {
            self.circleBoard.setState(at: index, value: value)
        }
    }
    
    func setField(at index: Int, value: Bool) -> FieldState {
        if self.crossFlag {
            self.crossBoard.setState(at: index, value: value)
            self.crossFlag = false
            self.tickCount += 1
            return FieldState.X
        } else {
            self.circleBoard.setState(at: index, value: value)
            self.crossFlag = true
            self.tickCount += 1
            return FieldState.O
        }
    }
    
    func clear() {
        self.crossBoard.clear()
        self.circleBoard.clear()
        self.crossFlag = true
        self.tickCount = 0
    }
    
    func getState(at index: Int, for player: Player) -> FieldState? {
        if player == Player.X {
            if crossBoard.getState(at: index)! {
                return FieldState.X
            } else {
                return FieldState.E
            }
        } else if player == Player.O {
            if circleBoard.getState(at: index)! {
                return FieldState.O
            } else {
                return FieldState.E
            }
        }
        return nil
    }
}
