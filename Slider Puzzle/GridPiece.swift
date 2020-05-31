//
//  GridPiece.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-05-31.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

class GridPiece: NSObject {
    
    var position: Position
    var type: PieceType
    var orientation: Orientation
    
    init(position:Position,type:PieceType,orientation:Orientation) {
        self.position = position
        self.type = type
        self.orientation = orientation
    }
    

}
