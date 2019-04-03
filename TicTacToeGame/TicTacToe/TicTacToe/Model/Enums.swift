//
//  Enums.swift
//  TicTacToe
//
//  Created by Henrik Peters on 06.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

enum FieldState: String {
    case X
    case O
    case E
    case T
}

enum Player {
    case X
    case O
}

enum Piece: String {
    case X = "X"
    case O = "O"
    case E = " "
    var opposite: Piece {
        switch self {
        case .X:
            return .O
        case .O:
            return .X
        case .E:
            return .E
        }
    }
    
}
