//
//  Botboard.swift
//  TicTacToe
//
//  Created by Henrik Peters on 15.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

struct Botboard {
    let position: [Piece]
    let turn: Piece
    let lastMove: Move
    
    init(position: [Piece] = [.E, .E, .E, .E, .E, .E, .E, .E, .E], turn: Piece = .X, lastMove: Int = -1) {
        self.position = position
        self.turn = turn
        self.lastMove = lastMove
    }
    
    func move(_ location: Move) -> Botboard {
        if location != -1 {
            var tempPosition = position
            tempPosition[location] = turn
            return Botboard(position: tempPosition, turn: turn.opposite, lastMove: location)
        } else {
            return self
        }
    }
    
    var legalMoves: [Move] {
        return position.indices.filter { position[$0] == .E }
    }
    
    var isWin: Bool {
        return
            position[0] == position[1] && position[0] == position[2] && position[0] != .E || // row 0
                position[3] == position[4] && position[3] == position[5] && position[3] != .E || // row 1
                position[6] == position[7] && position[6] == position[8] && position[6] != .E || // row 2
                position[0] == position[3] && position[0] == position[6] && position[0] != .E || // col 0
                position[1] == position[4] && position[1] == position[7] && position[1] != .E || // col 1
                position[2] == position[5] && position[2] == position[8] && position[2] != .E || // col 2
                position[0] == position[4] && position[0] == position[8] && position[0] != .E || // diag 0
                position[2] == position[4] && position[2] == position[6] && position[2] != .E // diag 1
    }
    
    var whoWon: Piece {
        if position[0] == .X && position[1] == .X && position[2] == .X ||
            position[3] == .X && position[4] == .X && position[5] == .X ||
            position[6] == .X && position[7] == .X && position[8] == .X ||
            position[0] == .X && position[3] == .X && position[6] == .X ||
            position[1] == .X && position[4] == .X && position[7] == .X ||
            position[2] == .X && position[5] == .X && position[8] == .X ||
            position[0] == .X && position[4] == .X && position[8] == .X ||
            position[2] == .X && position[4] == .X && position[6] == .X {
            return .X
        } else if position[0] == .O && position[1] == .O && position[2] == .O ||
            position[3] == .O && position[4] == .O && position[5] == .O ||
            position[6] == .O && position[7] == .O && position[8] == .O ||
            position[0] == .O && position[3] == .O && position[6] == .O ||
            position[1] == .O && position[4] == .O && position[7] == .O ||
            position[2] == .O && position[5] == .O && position[8] == .O ||
            position[0] == .O && position[4] == .O && position[8] == .O ||
            position[2] == .O && position[4] == .O && position[6] == .O {
            return .O
        } else {
            return .E
        }
    }
    
    var isDraw: Bool {
        return !isWin && legalMoves.count == 0
    }
    
    func minimax(_ board: Botboard, maximizing: Bool, originalPlayer: Piece) -> Int {
        // Terminating cases for Win, Loss, Draw
        if board.isWin && originalPlayer == board.turn.opposite { return 1 }
        else if board.isWin && originalPlayer != board.turn.opposite { return -1 }
        else if board.isDraw { return 0 }
        
        // Recursive cases for building the tree
        if maximizing {
            var bestEval = Int.min
            for move in board.legalMoves {
                let result = minimax(board.move(move), maximizing: false, originalPlayer: originalPlayer)
                bestEval = max(result, bestEval)
            }
            return bestEval
        } else {
            var worstEval = Int.max
            for move in board.legalMoves {
                let result = minimax(board.move(move), maximizing: true, originalPlayer: originalPlayer)
                worstEval = min(result, worstEval)
            }
            return worstEval
        }
    }
    
    func findBestMove(_ board: Botboard) -> Move {
        var bestEval = Int.min
        var bestMove = -1
        for move in board.legalMoves {
            let result = minimax(board.move(move), maximizing: false, originalPlayer: board.turn)
            if result > bestEval {
                bestEval = result
                bestMove = move
            }
        }
        return bestMove
    }
}
