//
//  GameBoards.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-05-31.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

class GameBoards: NSObject {
    
    static let boards: [[GridPiece]] = [
    
        // FIRST LEVEL:
        [
         GridPiece(position: Position(x: 0, y: 0), type: .Rect, orientation: .Vertical),
         GridPiece(position: Position(x: 1, y: 0), type: .BigSquare, orientation: .Single),
         GridPiece(position: Position(x: 3, y: 0), type: .Rect, orientation: .Vertical),
         GridPiece(position: Position(x: 0, y: 2), type: .Square, orientation: .Single),
         GridPiece(position: Position(x: 1, y: 2), type: .Square, orientation: .Single),
         GridPiece(position: Position(x: 2, y: 2), type: .Square, orientation: .Single),
         GridPiece(position: Position(x: 3, y: 2), type: .Square, orientation: .Single),
         GridPiece(position: Position(x: 0, y: 3), type: .Square, orientation: .Single),
         GridPiece(position: Position(x: 1, y: 3), type: .Rect, orientation: .Horizontal),
         GridPiece(position: Position(x: 3, y: 3), type: .Square, orientation: .Single),
         GridPiece(position: Position(x: 0, y: 4), type: .Square, orientation: .Single),
         GridPiece(position: Position(x: 3, y: 4), type: .Square, orientation: .Single),
        ],
        
        // SECOND LEVEL
        [
        
        ],
        
        // THIRD LEVEL
        [
        
        ],
        
        // FOURTH LEVEL
        [
        
        ],
        
        // END OF LEVELS
    ]
    
    
    
    static func getBoard(forLevel level:Int) -> [GridPiece] {
        return boards[level]
    }

}
