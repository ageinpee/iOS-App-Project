//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Henrik Peters on 06.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

struct GameBoard {
    private var state = [false, false, false,
                         false, false, false,
                         false, false, false]
    
    func checkState() -> Bool {
        return (self.state[0] && self.state[1] && self.state[2]) ||
            (self.state[3] && self.state[4] && self.state[5]) ||
            (self.state[6] && self.state[7] && self.state[8]) ||
            (self.state[0] && self.state[3] && self.state[6]) ||
            (self.state[1] && self.state[4] && self.state[7]) ||
            (self.state[2] && self.state[5] && self.state[8]) ||
            (self.state[0] && self.state[4] && self.state[8]) ||
            (self.state[2] && self.state[4] && self.state[6])
    }
    
    mutating func setState(at index: Int, value: Bool) {
        self.state[index] = value
    }
    
    mutating func clear() {
        self.state = [false, false, false,
                      false, false, false,
                      false, false, false]
    }
    
    func getState(at index: Int) -> Bool? {
        return state[index]
    }
}
