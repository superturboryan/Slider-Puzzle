//
//  GameBoards.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-05-31.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

class GameBoards: NSObject {
    
    private static let boards: [[GamePiece]] = [
        
        [ /* Empty first array as levels are 1-indexed */ ],
    
        // FIRST LEVEL:
        [
            GamePiece(position: Position(x: 0, y: 0), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 1, y: 0), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 0), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 0, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 2, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 3), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 3, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 4), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 4), type: .Square, orientation: .Single),
        ],
        
        // SECOND LEVEL
        [
            GamePiece(position: Position(x: 0, y: 0), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 2), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 2, y: 2), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 0, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 2, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 4), type: .Rect, orientation: .Horizontal)
        ],
        
        // THIRD LEVEL
        [
        
        ],
        
        // FOURTH LEVEL
        [
        
        ],
        
        // FIFTH
        
        [
        
        ],
        
        // SIXTH
        
        [
        
        ],
        
        // SEVENTH
        
        [
        
        ],
        
        // EIGTH
        
        [
        
        ],
        
        // NINTH
        
        [
        
        ],
        
        // END OF LEVELS
    ]
    
    
    
    public static func getBoard(forLevel level:Int) -> [GamePiece] {
        return boards[level]
    }

}