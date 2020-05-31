//
//  MenuViewController.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-05-31.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var darkModeSegmentControl: UISegmentedControl!
    
    var selectedLevel: Int = 0
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    func setupView() {
        
        self.darkModeSegmentControl.selectedSegmentIndex = self.traitCollection.userInterfaceStyle == .dark ? 1 : 0
        
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
    
}
