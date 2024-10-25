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
    let winScore = 22
    var isPlaying = false
    var isSetting = false
    var isEndGame = false
    
    func changeTotalScoreLabel(totalScore: Int, winScore: Int? = nil) -> String {
        return "Score: \(totalScore)/\(winScore ?? self.winScore)"
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
            self.totalScoreLabel.text = self.changeTotalScoreLabel(totalScore: self.totalScore)
            self.diceImageViewOne.image = UIImage(named: "DiceOne")
            self.diceImageViewTwo.image = UIImage(named: "DiceOne")
            self.isSetting = false
        }
    }
    
    func endGame() {
        isEndGame = true;
        totalScoreLabel.text = "You win 🎉"
    }
    
    func rollDice() {
        let leftIndex = Int.random(in: 0..<6)
        let rightIndex = Int.random(in: 0..<6)
        
        diceImageViewOne.image = UIImage(named: dices[leftIndex])
        diceImageViewTwo.image = UIImage(named: dices[rightIndex])
        totalScore += scores[leftIndex] + scores[rightIndex]
        totalScoreLabel.text = changeTotalScoreLabel(totalScore: totalScore)
        
        if totalScore >= winScore {
            endGame()
        }
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        if isSetting || isEndGame {
            return
        }
        
        if !isPlaying {
            return startGame()
        }
        
        rollDice()
    }
}

