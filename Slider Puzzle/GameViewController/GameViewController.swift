//
//  ViewController.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-04-18.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

public enum PanDirection: Int {
    case up, down, left, right, undefined
    public var isVertical: Bool { return [.up, .down].contains(self) }
    public var isHorizontal: Bool { return !isVertical }
}

class GameViewController: UIViewController {
    
    // UI Outlets + Views
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var containerBorder: UIView!
    @IBOutlet weak var gameContainerView: UIView!
    @IBOutlet weak var moveCountLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var bestLabel: UILabel!
 
    var kHighScore = "highScore" // Setup with level number in setupView
    
    let separatorSize: CGFloat = 15
    var squareSize: CGFloat = 0
    
    let gridWidthInSquares: CGFloat = 4
    let gridHeightInSquares: CGFloat = 5
    
    var level: Int = 1
    
    var moveCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGameBoard(withGridPieces: GameBoards.getBoard(forLevel: self.level))
    }
    
    func setupView() {
        
        squareSize = (gameContainerView.bounds.size.width - ((gridWidthInSquares+1)*separatorSize)) / gridWidthInSquares
        
        gameContainerView.layer.cornerRadius = 10.0
        containerBorder.layer.cornerRadius = 10.0
        resetButton.layer.cornerRadius = 5.0
        
        self.moveCountLabel.attributedText = NSAttributedString(string: "Moves: \n\(moveCount)")
        
        self.levelLabel.text = "Level \(self.level)"
        
        kHighScore = "highScore\(self.level)"
        
        updateBestLabel()
    }
    
    func setupGameBoard(withGridPieces pieces:[GamePiece]) {
        var delay: Double = 0.3
        
        for piece in pieces {
            switch (piece.type) {
                case .Rect: self.addRect(toPosition: piece.position, withOrientation: piece.orientation, andDelay: delay); break;
                case .BigSquare: self.addBigSquare(toPosition: piece.position, andDelay: delay); break;
                case .Square: self.addSquare(toPosition: piece.position, andDelay: delay); break;
                case .Empty: break;
            }
            
            delay += 0.3
        }
    }
    
    func getCGPointForPosition(_ pos:Position) -> CGPoint {
        return CGPoint(x: (CGFloat(pos.x) * squareSize) + (CGFloat(pos.x) * separatorSize) + separatorSize,
                       y: (CGFloat(pos.y) * squareSize) + (CGFloat(pos.y) * separatorSize) + separatorSize)
    }
    
    func getPositionFromView(_ view: UIView) -> Position {
        let originInContainer = gameContainerView.convert(view.bounds.origin, from: view)
        let x = originInContainer.x / (squareSize + separatorSize)
        let y = originInContainer.y / (squareSize + separatorSize)
        
        return Position(x: Int(x), y: Int(y))
    }
    
    //MARK: Add pieces
    func addSquare(toPosition pos: Position, andDelay delay:Double) {
        let size = squareSize
        let point = getCGPointForPosition(pos)
        let square = UIView(frame: CGRect(x: point.x,
                                          y: point.y,
                                          width: size,
                                          height: size))
        square.backgroundColor = .systemGreen
        square.layer.cornerRadius = 10.0
        
        addGestureRecognizersToPiece(square)
        
        square.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        
        self.gameContainerView.addSubview(square)
        
        UIView.animate(withDuration: 0.4,
                       delay: delay,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        
                        square.transform = CGAffineTransform.identity
                        
        }) { (success) in /* Add completion here */ }
    }

    func addRect(toPosition pos:Position, withOrientation ori:Orientation, andDelay delay:Double) {
        let width = ori == Orientation.Vertical ? squareSize : (2*squareSize) + separatorSize
        let height = ori == Orientation.Vertical ? (2*squareSize) + separatorSize : squareSize
        let point = getCGPointForPosition(pos)
        let rect = UIView(frame: CGRect(x: point.x,
                                        y: point.y,
                                        width: width,
                                        height: height))
        rect.backgroundColor = .systemRed
        rect.layer.cornerRadius = 10.0
        
        addGestureRecognizersToPiece(rect)
        
        rect.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        
        self.gameContainerView.addSubview(rect)
        
        UIView.animate(withDuration: 0.4,
                       delay: delay,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
            
            rect.transform = CGAffineTransform.identity
            
        }) { (success) in /* Add completion here */ }
    }
    
    func addBigSquare(toPosition pos:Position, andDelay delay:Double) {
        let size = (2*squareSize) + separatorSize
        let point = getCGPointForPosition(pos)
        let square = UIView(frame: CGRect(x: point.x,
                                          y: point.y,
                                          width: size,
                                          height: size))
        square.backgroundColor = .systemIndigo
        square.layer.cornerRadius = 10.0
        
        addGestureRecognizersToPiece(square)
        
        square.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        
        self.gameContainerView.addSubview(square)
        
        UIView.animate(withDuration: 0.4,
                       delay: delay,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        
                        square.transform = CGAffineTransform.identity
                        
        }) { (success) in /* Add completion here */ }
    }
    
    //MARK: Gesture Recognizers
    func addGestureRecognizersToPiece(_ piece:UIView) {
        let tapper = UITapGestureRecognizer(target: self, action:#selector(tappedView(_:)))
        piece.addGestureRecognizer(tapper)
        
        let panner = UIPanGestureRecognizer(target: self, action: #selector(pannedView(_:)))
        piece.addGestureRecognizer(panner)
    }
    
    @objc func tappedView(_ tapper:UITapGestureRecognizer) {
        let position = getPositionFromView(tapper.view!)
        print(position.x,position.y)
        shrinkExpandPiece(tapper.view!)
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
    
    func isBigSquare(_ view:UIView) -> Bool {
        return (view.frame.size.width == (2*squareSize) + separatorSize &&
                view.frame.size.height == (2*squareSize) + separatorSize)
    }

    //MARK: Movement
    func move(_ view:UIView, inDirection direction:PanDirection) {
        
        let newFrame = getNewFrameForView(view, withDirection:direction)
        
        if (isBigSquare(view) && // Check if we're moving winning piece from wining position
            getPositionFromView(view).x == 1 &&
            getPositionFromView(view).y == 3 &&
            direction == .down) {
            incrementMoveCountLabel()
            animateWinningPiece(view)
            userBeatLevel()
            return
        }
        
        if (moveIsAllowed(forView: view, withNewFrame: newFrame)) {
            incrementMoveCountLabel()
            animatePiece(view, toNewFrame: newFrame)
        }
        else { shrinkExpandPiece(view) }
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
    
    //MARK: Movement verification
    func moveIsAllowed(forView view:UIView, withNewFrame newFrame:CGRect) -> Bool {
        return isFrameInContainer(newFrame) &&
               !isPieceTouchingOtherPiece(view, ifMovedToNewFrame: newFrame)
    }
    
    func isFrameInContainer(_ frame:CGRect) -> Bool {
        if (!gameContainerView.frame.contains(gameContainerView.convert(frame, to: nil))) { // Check container contains new frame
            print("Cannot move piece off board, aborting movement!")
            return false
        }
        return true
    }
    
    func isPieceTouchingOtherPiece(_ piece:UIView, ifMovedToNewFrame newFrame:CGRect) -> Bool {
        var touching = false
        gameContainerView.subviews.forEach { (viewToCheck) in // Check that new frame does not overlap with any existing pieces
            if (viewToCheck.frame.intersects(newFrame) &&
                viewToCheck != piece) {
                print("Pieces will overlap, aborting movement!")
                touching = true
            }
        }
        return touching
    }
    
    //MARK: Movement animation
    func animatePiece(_ view:UIView, toNewFrame newFrame:CGRect) {
        
        UIView .animateKeyframes(withDuration: 0.4,
                                 delay: 0,
                                 options: .calculationModeCubic,
                                 animations: {

            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 1) {
                view.frame = newFrame // Move to new frame position
            }
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.7) {
                view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // Shrink
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7,
                               relativeDuration: 0.3) {
                view.transform = .identity // Back to og
            }
        }) { (finished) in
            HapticsHelper.impact(withType: .soft)
        }
    }
    
    func animateWinningPiece(_ view:UIView) {
        UIView.animateKeyframes(withDuration: 1.0,
                                 delay: 0,
                                 options: .calculationModeCubic,
                                 animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 1.0) {
                                view.frame = CGRect(x: view.frame.origin.x,
                                                    y: view.frame.origin.y + 300,
                                                    width: view.frame.size.width,
                                                    height: view.frame.size.height)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.2) {
                view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }) { (finished) in self.tappedReset(UIButton())}
    }
    
    func shrinkExpandPiece(_ view:UIView) {
        HapticsHelper.notification(withType: .warning)
        UIView.animate(withDuration: 0.25, delay: 0, options:.curveEaseOut, animations: {
            view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (done) in
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                view.transform = .identity
            }) { (done) in }
        }
    }
    
    //MARK: Complete level
    func userBeatLevel() {
        let currentBest = UserDefaults.standard.integer(forKey: kHighScore)
        if (moveCount < currentBest || currentBest == 0) {
            UserDefaults.standard.set(moveCount, forKey: kHighScore)
        }
        updateBestLabel()
    }
    
    func updateBestLabel() {
        bestLabel.attributedText = (UserDefaults.standard.integer(forKey: kHighScore) == 0) ?
            NSAttributedString(string: "Best: \n🚫😩") :
            NSAttributedString(string: "Best: \n\(UserDefaults.standard.integer(forKey: kHighScore))")
    }
    
    func incrementMoveCountLabel() {
        moveCount += 1
        moveCountLabel.attributedText = NSAttributedString(string: "Moves: \n\(moveCount)")
    }
    
    //MARK: Actions
    @IBAction func tappedReset(_ sender: UIButton) {
        if (moveCount == 0) {
            resetBestPopup()
            return
        }
        
        gameContainerView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        moveCount = -1
        incrementMoveCountLabel()
        setupGameBoard(withGridPieces: GameBoards.getBoard(forLevel: self.level))
    }
    
    @IBAction func tappedBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func resetBestPopup() {
        let alertVC = UIAlertController(title: "Reset best score", message: "Are you sure you want to do that?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            UserDefaults.standard.set(0, forKey: self.kHighScore)
            self.updateBestLabel()
            alertVC.dismiss(animated: true, completion: nil)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(yesAction); alertVC.addAction(noAction);
        present(alertVC, animated: true, completion: nil)
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