//
//  Settings.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-05-31.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

class Settings: NSObject { // Interactor style object to access settings stored in NSUserDefaults
    
    static func highScore(forLevel level: Int) -> Int {
        return UserDefaults.standard.integer(forKey: "highScore\(level)")
    }
    
    static func setHighScore(forLevel level: Int, withNewValue value: Int) {
        UserDefaults.standard.set(value, forKey: "highScore\(level)")
    }
    
    

}
