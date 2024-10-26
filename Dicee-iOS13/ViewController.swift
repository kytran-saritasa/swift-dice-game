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
        initGame()
    }
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var rollTimesLabel: UILabel!
    @IBOutlet weak var diceImageViewOne: UIImageView!
    @IBOutlet weak var diceImageViewTwo: UIImageView!
    @IBOutlet weak var mainButton: UIButton!
    
    let dices = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]
    let scores = Array(1...6)
    
    var totalScore = 2
    var rollTimes = 0
    let winScore = 22
    var isPlaying = false
    var isSetting = false
    var isEndGame = false
    
    func changeTotalScoreLabel(totalScore: Int, winScore: Int? = nil) -> String {
        return "Score: \(totalScore)/\(winScore ?? self.winScore)"
    }
    
    func changeRollTimesLabel(rollTimes: Int) -> String {
        return "Roll times: \(rollTimes)"
    }
    
    func initGame() {
        totalScoreLabel.alpha = 0
        rollTimesLabel.alpha = 0
        diceImageViewOne.alpha = 0
        diceImageViewTwo.alpha = 0
        totalScoreLabel.text = changeTotalScoreLabel(totalScore: totalScore)
        rollTimesLabel.text = changeRollTimesLabel(rollTimes: rollTimes)
        diceImageViewOne.image = UIImage(named: "DiceOne")
        diceImageViewTwo.image = UIImage(named: "DiceOne")
        mainButton.setTitle("Start", for: .normal)
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
            self.rollTimesLabel.alpha = 1
            self.diceImageViewOne.alpha = 1
            self.diceImageViewTwo.alpha = 1
            self.isSetting = false
        }
    }
    
    func endGame() {
        isEndGame = true;
        totalScoreLabel.text = "You win 🎉"
        mainButton.setTitle("Restart", for: .normal)
    }
    
    func restartGame() {
        isEndGame = false
        totalScore = 2
        rollTimes = 0
        totalScoreLabel.text = changeTotalScoreLabel(totalScore: totalScore)
        rollTimesLabel.text = changeRollTimesLabel(rollTimes: rollTimes)
        diceImageViewOne.image = UIImage(named: "DiceOne")
        diceImageViewTwo.image = UIImage(named: "DiceOne")
    }
    
    func rollDice() {
        let leftIndex = Int.random(in: 0..<6)
        let rightIndex = Int.random(in: 0..<6)
        
        diceImageViewOne.image = UIImage(named: dices[leftIndex])
        diceImageViewTwo.image = UIImage(named: dices[rightIndex])
        totalScore += scores[leftIndex] + scores[rightIndex]
        totalScoreLabel.text = changeTotalScoreLabel(totalScore: totalScore)
        rollTimes += 1
        rollTimesLabel.text = changeRollTimesLabel(rollTimes: rollTimes)
        
        if totalScore >= winScore {
            endGame()
        }
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        if isSetting {
            return
        }
        if isEndGame {
            return restartGame()
        }
        if !isPlaying {
            return startGame()
        }
        rollDice()
    }
}

