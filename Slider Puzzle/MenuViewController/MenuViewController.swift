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
    @IBOutlet weak var allDoneLabel: UILabel!
    @IBOutlet weak var darkModeSegmentControl: UISegmentedControl!
    
    var selectedLevel: Int = 0
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkForUnlockedLevels()
        
        self.checkForCompletedLevels()
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
            self.allDoneLabel.textColor = dark ? .white : .black
            
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
        if (button.title(for: .normal) == "🔒") {
            HapticsHelper.notification(withType: .warning)
            return;
        }
        self.selectedLevel = button.tag
        HapticsHelper.selection()
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    @IBAction func darkModeControlChanged(_ sender: Any) {
        HapticsHelper.impact(withType: .soft)
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
                butt.setTitle(locked.contains(button.tag) ? "🔒" : "\(butt.tag)" , for: .normal)
            }
        }
    }
    
    func checkForCompletedLevels() {
        
        var completed: [Int] = Array()
        for i in 1...9 {
            let highScore = Settings.highScore(forLevel: i)
            if highScore != 0 {
                completed.append(i)
            }
        }
        
        self.stackOfStackOfButtons.subviews.forEach { (stack) in
            let substack = stack as! UIStackView
            substack.subviews.forEach { (button) in
                let butt = button as! UIButton
                if (completed.contains(butt.tag) && butt.subviews.count == 1) {
                    let greencircle = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                    greencircle.backgroundColor = .systemGreen
                    greencircle.layer.cornerRadius = greencircle.frame.size.height/2
                    butt.addSubview(greencircle)
                }
            }
        }
        
        if (completed.count == 9) {
            self.allDoneLabel.isHidden = false;
        }
    }
}
