//
//  botGame.swift
//  TicTacToe
//
//  Created by Henrik Peters on 15.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

typealias Move = Int

class Botgame {
    private var board = Botboard()
    var hardMode = false
    
    var isWin: Bool { return self.board.isWin }
    var isDraw: Bool { return self.board.isDraw }
    
    func move(location: Move) {
        self.board = self.board.move(location)
    }
    
    func getPositions() -> Array<Piece> {
        return self.board.position
    }
    
    func getBoard() -> Botboard {
        return self.board
    }
    
    func getState(at index: Int) -> Piece? {
        return self.board.position[index]
    }
    
    func clear() {
        self.board = Botboard()
    }
    
    func getTurn() -> Piece {
        return self.board.turn
    }
    
    func moveBot(with value: Float) {
        if value == 1.0 {
            self.board = self.board.move(self.board.findBestMove(self.board))
        } else {
            let randomFloat = Float.random(in: 0.0...1.0)
            if randomFloat < value {
                self.board = self.board.move(self.board.findBestMove(self.board))
            } else {
                if self.board.legalMoves.count != 0 {
                    self.board = self.board.move(self.board.legalMoves.randomElement()!)
                }
            }
        }
    }
}
