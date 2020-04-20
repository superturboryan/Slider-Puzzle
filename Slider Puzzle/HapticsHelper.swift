//
//  HapticsHelper.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-04-19.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

class HapticsHelper: NSObject {

    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    static func notification(withType type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    static func impact(withType type:UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.impactOccurred()
    }
    
}
