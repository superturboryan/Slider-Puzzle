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
            GamePiece(position: Position(x: 0, y: 0), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 2, y: 0), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 1), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 2, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 3), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 1, y: 3), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 2, y: 3), type: .Rect, orientation: .Vertical),
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
            GamePiece(position: Position(x: 0, y: 4), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 4), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 4), type: .Rect, orientation: .Horizontal)
        ],
        
        // THIRD LEVEL
        [
            GamePiece(position: Position(x: 0, y: 0), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 1, y: 0), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 0), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 2, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 3), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 2, y: 3), type: .Rect, orientation: .Horizontal),
        ],
        
        // FOURTH LEVEL
        [
            GamePiece(position: Position(x: 0, y: 0), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 2, y: 0), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 2, y: 1), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 3, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 4), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 3), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 2, y: 4), type: .Rect, orientation: .Horizontal),
        ],
        
        // FIFTH
        [
            GamePiece(position: Position(x: 0, y: 1), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 2, y: 1), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 2, y: 2), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 0, y: 3), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 2, y: 3), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 0, y: 4), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 2, y: 4), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 4), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 4), type: .Square, orientation: .Single),
        ],
        
        // SIXTH
        [
            GamePiece(position: Position(x: 0, y: 0), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 0), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 2, y: 0), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 1), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 2), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 3, y: 2), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 4), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 3, y: 4), type: .Square, orientation: .Single),
        ],
        
        // SEVENTH ****
        [
            GamePiece(position: Position(x: 0, y: 0), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 1), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 0), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 2), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 4), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 4), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 3), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 2), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 2, y: 2), type: .Rect, orientation: .Vertical),
            GamePiece(position: Position(x: 3, y: 1), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 3), type: .Square, orientation: .Single),
        ],
        
        // EIGHTH
        [
            GamePiece(position: Position(x: 0, y: 0), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 0), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 0), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 2, y: 0), type: .Square, orientation: .Single),
            GamePiece(position: Position(x: 0, y: 3), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 3, y: 3), type: .Empty, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 2), type: .BigSquare, orientation: .Single),
            GamePiece(position: Position(x: 1, y: 4), type: .Rect, orientation: .Horizontal),
            GamePiece(position: Position(x: 0, y: 4), type: .Square, orientation: .Single),
        ],
        
        // NINTH
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
        
        // END OF LEVELS
    ]
    
    /*Board with all small squares
     [
     GamePiece(position: Position(x: 0, y: 0), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 1, y: 0), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 2, y: 0), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 3, y: 0), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 0, y: 1), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 1, y: 1), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 2, y: 1), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 3, y: 1), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 0, y: 2), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 1, y: 2), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 2, y: 2), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 3, y: 2), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 0, y: 3), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 1, y: 3), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 2, y: 3), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 3, y: 3), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 0, y: 4), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 1, y: 4), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 2, y: 4), type: .Square, orientation: .Single),
     GamePiece(position: Position(x: 3, y: 4), type: .Square, orientation: .Single),
     ]
     */
    
    
    
    public static func getBoard(forLevel level:Int) -> [GamePiece] {
        return boards[level]
    }

}
