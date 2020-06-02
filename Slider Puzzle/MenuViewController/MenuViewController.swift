//
//  MenuViewController.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-05-31.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chooseLevelLabel: UILabel!
    @IBOutlet weak var stackOfStackOfButtons: UIStackView!
    @IBOutlet weak var darkModeSegmentControl: UISegmentedControl!
    
    var selectedLevel: Int = 0
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.checkForUnlockedLevels()
    }
    
    //MARK: View setup
    func setupView() {
        
        self.setupStyleForDarkMode(Settings.tappedDarkToggle() ?
            Settings.darkMode() : // Use app local setting
            self.traitCollection.userInterfaceStyle == .dark) // Otherwise use setting from device
        
        self.darkModeSegmentControl.selectedSegmentIndex = Settings.tappedDarkToggle() ?
            (Settings.darkMode() ? 1 : 0) : // Use setting from App if switch has been toggled before
            (self.traitCollection.userInterfaceStyle == .dark ? 1 : 0) // Or default to setting from
        
        self.stackOfStackOfButtons.subviews.forEach { (stack) in
            let substack = stack as! UIStackView
            substack.subviews.forEach { (button) in
                button.layer.cornerRadius = 10.0
            }
        }
    }
    
    func setupStyleForDarkMode(_ dark:Bool) {
        
        UIView .animate(withDuration: 0.3) {
            self.view.backgroundColor = dark ? .black : .white
            self.titleLabel.textColor = dark ? .white : .black
            self.chooseLevelLabel.textColor = dark ? .white : .black
            
            self.stackOfStackOfButtons.subviews.forEach { (stack) in
                let substack = stack as! UIStackView
                substack.subviews.forEach { (button) in
                    let buttonInSubtack = button as! UIButton
                    buttonInSubtack.backgroundColor = dark ? .white : .gray
                    buttonInSubtack.setTitleColor(dark ? .gray : .white, for: .normal)
                }
            }
        }
    }
    
    //MARK: Actions
    @IBAction func tappedStartLevel(_ button: UIButton) {
        if (button.title(for: .normal) == "🔒") { return; }
        self.selectedLevel = button.tag
        HapticsHelper.selection()
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    @IBAction func darkModeControlChanged(_ sender: Any) {
        let dark = self.darkModeSegmentControl.selectedSegmentIndex == 1 ? true : false
        Settings.setTappedDarkModeToggle(true)
        Settings.setDarkMode(dark)
        self.setupStyleForDarkMode(dark)
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToGame") {
            let gameVC: GameViewController = segue.destination as! GameViewController
            gameVC.level = self.selectedLevel
        }
        
    }
    
    func checkForUnlockedLevels() {
     
        var locked: [Int] = Array()
        for i in 2...9 {
            let highScore = Settings.highScore(forLevel: i-1)
            if highScore == 0 {
                locked.append(i)
            }
        }
        
        self.stackOfStackOfButtons.subviews.forEach { (stack) in
            
            let substack = stack as! UIStackView
            substack.subviews.forEach { (button) in
                
                let butt = button as! UIButton
                if (locked.contains(button.tag)) {
                    butt.setTitle("🔒", for: .normal)
                }
                else {
                    butt.setTitle("\(butt.tag)", for: .normal)
                }
            }
        }
        
    }
}
