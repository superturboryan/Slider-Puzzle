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
    
    static func tappedDarkToggle() -> Bool {
        return UserDefaults.standard.bool(forKey: "tappedDarkToggle")
    }
    
    static func setTappedDarkModeToggle(_ val:Bool) {
        UserDefaults.standard.set(val, forKey: "tappedDarkToggle")
    }
    
    static func setDarkMode(_ val:Bool) {
        UserDefaults.standard.set(val, forKey: "darkMode")
    }
    
    static func darkMode() -> Bool {
        return UserDefaults.standard.bool(forKey: "darkMode")
    }

}
