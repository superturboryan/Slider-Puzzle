//
//  GridPiece.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-05-31.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

public enum Orientation {
    case Vertical, Horizontal, Single
}

public enum PieceType {
    case Square, Rect, BigSquare, Empty
}

struct Position {
    var x: Int
    var y: Int
}

class GamePiece: NSObject {
    
    var position: Position
    var type: PieceType
    var orientation: Orientation
    
    init(position:Position,type:PieceType,orientation:Orientation) {
        self.position = position
        self.type = type
        self.orientation = orientation
    }
    

}
