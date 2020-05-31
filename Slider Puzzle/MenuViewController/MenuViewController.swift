//
//  MenuViewController.swift
//  Slider Puzzle
//
//  Created by Ryan David Forsyth on 2020-05-31.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var selectedLevel: Int = 0
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
