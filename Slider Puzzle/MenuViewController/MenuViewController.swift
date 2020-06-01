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
    
    func setupView() {
        
        self.setupStyleForDarkMode(Settings.tappedDarkToggle() ?
            Settings.darkMode() : // Use app local setting
            self.traitCollection.userInterfaceStyle == .dark) // Otherwise use setting from device
        
        self.darkModeSegmentControl.selectedSegmentIndex = Settings.tappedDarkToggle() ?
            (Settings.darkMode() ? 1 : 0) : // Use setting from App if switch has been toggled before
            (self.traitCollection.userInterfaceStyle == .dark ? 1 : 0) // Or default to setting from
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

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToGame") {
            let gameVC: GameViewController = segue.destination as! GameViewController
            gameVC.level = self.selectedLevel
        }
    }
    
    @IBAction func tappedStartLevel(_ button: UIButton) {
        self.selectedLevel = button.tag
        
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    @IBAction func darkModeControlChanged(_ sender: Any) {
        let dark = self.darkModeSegmentControl.selectedSegmentIndex == 1 ? true : false
        Settings.setTappedDarkModeToggle(true)
        Settings.setDarkMode(dark)
        self.setupStyleForDarkMode(dark)
    }
    
    
}
