//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        totalScoreLabel.alpha = 0
        mainButton.setTitle("Start", for: .normal)
    }
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var diceImageViewOne: UIImageView!
    @IBOutlet weak var diceImageViewTwo: UIImageView!
    @IBOutlet weak var mainButton: UIButton!
    
    let dices = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]
    let scores = Array(1...6)
    
    var totalScore = 2
    var isPlaying = false
    var isSetting = false
    
    func diceRandomize() {
        diceImageViewOne.image = UIImage(named: dices.randomElement()!)
        diceImageViewTwo.image = UIImage(named: dices.randomElement()!)
    }
    
    func startGame() {
        isPlaying = true
        isSetting = true
        mainButton.setTitle("Roll", for: .normal)
        
        UIView.animate(withDuration: 0.5) {
            self.mainButton.frame.origin.y = 575
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.totalScoreLabel.alpha = 1
            self.diceImageViewOne.image = UIImage(named: "DiceOne")
            self.diceImageViewTwo.image = UIImage(named: "DiceTwo")
            self.isSetting = false
        }
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        if isSetting {
            return
        }
        
        if !isPlaying {
            startGame()
        }
    }
}

