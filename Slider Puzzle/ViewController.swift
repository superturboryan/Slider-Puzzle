//
//  ViewController.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-04-18.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

public enum Orientation {
    case Vertical, Horizontal
}

public enum Pieces {
    case Square, VRect, HRect, BigSquare, Empty
}

public enum PanDirection: Int {
    case up, down, left, right, undefined
    public var isVertical: Bool { return [.up, .down].contains(self) }
    public var isHorizontal: Bool { return !isVertical }
}

struct Position {
    var x: Int
    var y: Int
}

class ViewController: UIViewController {
    
    @IBOutlet weak var containerBorder: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moveCountLabel: UILabel!
    
    let separatorSize: CGFloat = 10
    var squareSize: CGFloat = 0
    
    let gridWidth: CGFloat = 4
    let gridHeight: CGFloat = 5
    
    var grid: [[Pieces]] = Array(repeating: Array(repeating: .Empty, count: 5), count: 4) // 4 x 5 matrix
    
    var moveCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGameBoard()
    }
    
    func setupView() {
        squareSize = (containerView.bounds.size.width - ((gridWidth-1)*separatorSize)) / gridWidth
        
        containerView.layer.cornerRadius = 10.0
        containerBorder.layer.cornerRadius = 10.0
    }
    
    func setupGameBoard() {
        self.addRect(toPosition: Position(x:0,y:0), withOrientation: .Vertical)
        self.addRect(toPosition: Position(x:3,y:0), withOrientation: .Vertical)
        self.addBigSquare(toPosition: Position(x:1,y:0))
        self.addSquare(toPosition: Position(x:0,y:2))
        self.addSquare(toPosition: Position(x:1,y:2))
        self.addSquare(toPosition: Position(x:2,y:2))
        self.addSquare(toPosition: Position(x:3,y:2))
        self.addSquare(toPosition: Position(x:0,y:3))
        self.addRect(toPosition: Position(x:1,y:3), withOrientation: .Horizontal)
        self.addSquare(toPosition: Position(x:3,y:3))
        self.addSquare(toPosition: Position(x:0,y:4))
        self.addSquare(toPosition: Position(x:3,y:4))
    }
    
    func getXCoordinateForPosition(_ pos: Position) -> CGFloat {
        return (CGFloat(pos.x) * squareSize) + (CGFloat(pos.x) * separatorSize)
    }
    
    func getYCoordinateForPosition(_ pos: Position) -> CGFloat {
        return (CGFloat(pos.y) * squareSize) + (CGFloat(pos.y) * separatorSize)
    }
    
    func getPositionFromView(_ view: UIView) -> Position {
        let originInContainer = containerView.convert(view.bounds.origin, from: view)
        let x = originInContainer.x / (squareSize + separatorSize)
        let y = originInContainer.y / (squareSize + separatorSize)
        
        return Position(x: Int(x), y: Int(y))
    }
    
    func addSquare(toPosition pos: Position) {
        let size = squareSize
        let x = getXCoordinateForPosition(pos)
        let y = getYCoordinateForPosition(pos)
        let square = UIView(frame: CGRect(x: x, y: y, width: size, height: size))
        square.backgroundColor = .systemGreen
        square.layer.cornerRadius = 10.0
        
        self.containerView.addSubview(square)
        
        addPieceToGrid(atPosition: pos, forType: .Square)
        
        let tapper = UITapGestureRecognizer(target: self, action:#selector(tappedView(_:)))
        square.addGestureRecognizer(tapper)
        
        let panner = UIPanGestureRecognizer(target: self, action: #selector(pannedView(_:)))
        square.addGestureRecognizer(panner)
    }

    func addRect(toPosition pos:Position, withOrientation ori:Orientation) {
        let width = ori == Orientation.Vertical ? squareSize : (2*squareSize) + separatorSize
        let height = ori == Orientation.Vertical ? (2*squareSize) + separatorSize : squareSize
        let x = getXCoordinateForPosition(pos)
        let y = getYCoordinateForPosition(pos)
        
        let rect = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        rect.backgroundColor = .systemRed
        rect.layer.cornerRadius = 10.0
        
        self.containerView.addSubview(rect)
        
        addPieceToGrid(atPosition: pos, forType: ori == .Vertical ? .VRect : .HRect)
        
        let tapper = UITapGestureRecognizer(target: self, action:#selector(tappedView(_:)))
        rect.addGestureRecognizer(tapper)
        
        let panner = UIPanGestureRecognizer(target: self, action: #selector(pannedView(_:)))
        rect.addGestureRecognizer(panner)
    }
    
    func addBigSquare(toPosition pos:Position) {
        let size = (2*squareSize) + separatorSize
        let x = getXCoordinateForPosition(pos)
        let y = getYCoordinateForPosition(pos)
        
        let square = UIView(frame: CGRect(x: x, y: y, width: size, height: size))
        square.backgroundColor = .systemBlue
        square.layer.cornerRadius = 10.0
        
        self.containerView.addSubview(square)
        
        addPieceToGrid(atPosition: pos, forType: .BigSquare)
        
        let tapper = UITapGestureRecognizer(target: self, action:#selector(tappedView(_:)))
        square.addGestureRecognizer(tapper)
        
        let panner = UIPanGestureRecognizer(target: self, action: #selector(pannedView(_:)))
        square.addGestureRecognizer(panner)
    }
    
    @objc func tappedView(_ tapper:UITapGestureRecognizer) {
        let position = getPositionFromView(tapper.view!)
        print(position.x,position.y)
    }
    
    @objc func pannedView(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            move(recognizer.view!, inDirection: recognizer.direction!)
            let newPosition = getPositionFromView(recognizer.view!)
            print("Moved to :", newPosition)
            break
        default:
            break
        }
    }

    func addPieceToGrid(atPosition pos:Position, forType type:Pieces) {
        switch(type) {
            case .Square:
                self.grid[pos.x][pos.y] = .Square
                break
            case .BigSquare:
                self.grid[pos.x][pos.y] = .BigSquare
                self.grid[pos.x+1][pos.y] = .BigSquare
                self.grid[pos.x][pos.y+1] = .BigSquare
                self.grid[pos.x+1][pos.y+1] = .BigSquare
                break
            case .VRect:
                self.grid[pos.x][pos.y] = .VRect
                self.grid[pos.x][pos.y+1] = .VRect
                break
            case.HRect:
                self.grid[pos.x][pos.y] = .HRect
                self.grid[pos.x+1][pos.y] = .HRect
                break
            default: break;
        }
    }
    
    func move(_ view:UIView, inDirection direction:PanDirection) {
        
        let newFrame = getNewFrameForView(view, withDirection:direction)
        
        if (moveIsAllowed(forView: view, withNewFrame: newFrame)) {
            incrementMoveCountLabel()
            animatePiece(view, toNewFrame: newFrame)
        }
    }
    
    func getNewFrameForView(_ view:UIView, withDirection direction:PanDirection) -> CGRect {
        var newX: CGFloat
        var newY: CGFloat
        let distance = squareSize + separatorSize
        switch (direction) {
        case .up:
            newX = view.frame.origin.x
            newY = view.frame.origin.y - distance
            break
        case .down:
            newX = view.frame.origin.x
            newY = view.frame.origin.y + distance
            break
        case .left:
            newX = view.frame.origin.x - distance
            newY = view.frame.origin.y
            break
        case .right:
            newX = view.frame.origin.x + distance
            newY = view.frame.origin.y
            break
        case .undefined:
            return view.frame // If undefined, return OG frame
        }
        return CGRect(x: newX,
                      y: newY,
                      width: view.frame.size.width,
                      height: view.frame.size.height)
    }
    
    func moveIsAllowed(forView view:UIView, withNewFrame newFrame:CGRect) -> Bool {
        var moveAllowed = true
                
        if (!containerView.frame.contains(containerView.convert(newFrame, to: nil))) { // Check container contains new frame
            print("Cannot move piece off board, aborting movement!")
            moveAllowed = false
        }
        
        containerView.subviews.forEach { (viewToCheck) in // Check that new frame does not overlap with any existing pieces
            if (viewToCheck.frame.intersects(newFrame) &&
                viewToCheck != view) {
                print("Pieces will overlap, aborting movement!")
                moveAllowed = false
            }
        }
        
        return moveAllowed
    }
    
    func animatePiece(_ view:UIView, toNewFrame newFrame:CGRect) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        view.frame = newFrame
        }, completion: nil)
    }
    
    func incrementMoveCountLabel() {
        moveCount += 1
        moveCountLabel.attributedText = NSAttributedString(string: "Move count: \n\(moveCount)")
    }
}

public extension UIPanGestureRecognizer {
    var direction: PanDirection? {
        let velocity = self.velocity(in: view)
        let isVertical = abs(velocity.y) > abs(velocity.x)
        switch (isVertical, velocity.x, velocity.y) {
        case (true, _, let y) where y < 0: return .up
        case (true, _, let y) where y > 0: return .down
        case (false, let x, _) where x > 0: return .right
        case (false, let x, _) where x < 0: return .left
        default: return .undefined
        }
    }
    
}
