//
//  ViewController.swift
//  FarkleSwift
//
//  Created by Caleb Talbot on 6/9/16.
//  Copyright © 2016 Caleb Talbot. All rights reserved.
//

import UIKit
class ViewController: UIViewController, DieLabelDelegate {
    
    @IBOutlet var dice: [DieLabel]!
    @IBOutlet weak var potentialScoreLabel: UILabel!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    
    var currentPlayer: Player = Player(withName: "Current Player")
    var playerOne: Player = Player(withName: "player one")
    var playerTwo: Player = Player(withName: "player two")
    
    var currentScore = 0
    var potentialScore = 0
    var scoreForTurn = 0
    var scoreForFarkle = 0
    
    var heldDice:Array = [DieLabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for die in dice {
            die.delegate = self
            die.text = "✖︎"
        }
        
        currentPlayer = playerOne
        currentPlayerLabel.text = currentPlayer.name
        player1ScoreLabel.text = "player one: 0"
        player2ScoreLabel.text = "player two: 0"
        potentialScoreLabel.text = "score for turn: 0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRollPressed(sender: AnyObject) {
        
        for die in dice {
            if (die.held == false) {
                die.rollADie()
            }
        }
        
        for die in dice {
            if die.held == true {
                die.userInteractionEnabled = false
                die.outOfPlay = true
            }
        }
        
        farkleTest()
        
        currentPlayer.score = currentPlayer.score + scoreForTurn
        
        scoreForFarkle = scoreForTurn
        
        scoreForTurn = 0
        
        if currentPlayer == playerOne {
            player1ScoreLabel.text = "\(currentPlayer.name): \(currentPlayer.score)"
        } else {
            player2ScoreLabel.text = "\(currentPlayer.name): \(currentPlayer.score)"
        }
        
        potentialScoreLabel.text = "score for turn: \(potentialScore)"
        
    }
    
    func handleTapped(sender: UITapGestureRecognizer) {
        checkScore()
    }
    
    @IBAction func onCollectPointsTapped(sender: AnyObject) {
        
        for die in dice {
                die.resetDie()
        }
        
        currentPlayer.score = currentPlayer.score + scoreForTurn
        
        scoreForTurn = 0
        potentialScore = 0
        
        if currentPlayer == playerOne {
            player1ScoreLabel.text = "\(currentPlayer.name): \(currentPlayer.score)"
        } else {
            player2ScoreLabel.text = "\(currentPlayer.name): \(currentPlayer.score)"
        }
        
        potentialScoreLabel.text = "score for turn: \(potentialScore)"
        
        nextTurn()
    }
    
    func checkScore() {
        
        var sortedDiceLabelsForScore = [String]()
        var stringForCheckingScore = ""
        
        for die in dice {
            if die.held == true && die.outOfPlay == false {
                let letter = die.text
                sortedDiceLabelsForScore.append(letter!)
                sortedDiceLabelsForScore.sortInPlace() { (element1, element2) -> Bool in
                    return element1 < element2
                }
            }
        }
        
        for letter in sortedDiceLabelsForScore {
            stringForCheckingScore += letter
        }
        
        pointCalculation(stringForCheckingScore)
        
        // Update Score
        scoreForTurn = potentialScore
        
        potentialScoreLabel.text = "score for turn: \(potentialScore)"
        
        potentialScore = 0
        
    }
    
    func pointCalculation(stringToCheck: String) {
        
        if stringToCheck.containsString("111111") {
            potentialScore += 2000;
        } else if stringToCheck.containsString("11111") {
            potentialScore += 1200;
        } else if stringToCheck.containsString("1111") {
            potentialScore += 1100;
        } else if stringToCheck.containsString("111") {
            potentialScore += 1000;
        } else if stringToCheck.containsString("11") {
            potentialScore += 200;
        } else if stringToCheck.containsString("1") {
            potentialScore += 100;
        }
        
        if stringToCheck.containsString("555555") {
            potentialScore += 1000;
        } else if stringToCheck.containsString("55555") {
            potentialScore += 600;
        } else if stringToCheck.containsString("5555") {
            potentialScore += 550;
        } else if stringToCheck.containsString("555") {
            potentialScore += 500;
        } else if stringToCheck.containsString("55") {
            potentialScore += 100;
        } else if stringToCheck.containsString("5") {
            potentialScore += 50;
        }
        
        if stringToCheck.containsString("666") {
            potentialScore += 600;
        }
        
        if stringToCheck.containsString("444") {
            potentialScore += 400;
        }
        
        if stringToCheck.containsString("333") {
            potentialScore += 300;
        }
        
        if stringToCheck.containsString("222") {
            potentialScore += 200;
        }
    }
    
    
    func farkleTest() {
        
        // Check for Farkle
        var sortedDiceLabelsForFarkle = [String]()
        var stringToCheck = ""
        
        for die in dice {
            if die.held == false {
                let letter = die.text
                sortedDiceLabelsForFarkle.append(letter!)
                sortedDiceLabelsForFarkle.sortInPlace() {(element1, element2) -> Bool in
                    return element1 < element2
                }
                
            }
        }
        
        for letter in sortedDiceLabelsForFarkle {
            stringToCheck += letter
        }
        
        var farkleTestScore = 0
        
        if stringToCheck.containsString("111111") {
            farkleTestScore += 2000;
        } else if stringToCheck.containsString("11111") {
            farkleTestScore += 1200;
        } else if stringToCheck.containsString("1111") {
            farkleTestScore += 1100;
        } else if stringToCheck.containsString("111") {
            farkleTestScore += 1000;
        } else if stringToCheck.containsString("11") {
            farkleTestScore += 200;
        } else if stringToCheck.containsString("1") {
            farkleTestScore += 100;
        }
        
        if stringToCheck.containsString("555555") {
            farkleTestScore += 1000;
        } else if stringToCheck.containsString("55555") {
            farkleTestScore += 600;
        } else if stringToCheck.containsString("5555") {
            farkleTestScore += 550;
        } else if stringToCheck.containsString("555") {
            farkleTestScore += 500;
        } else if stringToCheck.containsString("55") {
            farkleTestScore += 100;
        } else if stringToCheck.containsString("5") {
            farkleTestScore += 50;
        }
        
        if stringToCheck.containsString("666") {
            farkleTestScore += 600;
        }
        
        if stringToCheck.containsString("444") {
            farkleTestScore += 400;
        }
        
        if stringToCheck.containsString("333") {
            farkleTestScore += 300;
        }
        
        if stringToCheck.containsString("222") {
            farkleTestScore += 200;
        }
        
        if farkleTestScore == 0 {
            
            if sortedDiceLabelsForFarkle.count == 0 {
                let alertController = UIAlertController(title: "Great Job!!!", message: "Great job, \(currentPlayer.name)!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Pass to next player", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alertController, animated: true, completion: {
                    
                    for die in self.dice {
                        die.resetDie()
                        die.resetDie()
                    }
                    
                    self.scoreForTurn = 0
                    
                    self.nextTurn()
                    
                return
            })
            } else {
            
            let alertController = UIAlertController(title: "Farkle!!!", message: "Uh oh. You lost all your points for this round, \(currentPlayer.name).", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Pass to next player", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alertController, animated: true, completion: { 
                
                for die in self.dice {
                    die.resetDie()
                    die.resetDie()
                }
                
                self.currentPlayer.score = self.currentPlayer.score - self.scoreForFarkle
                
                if self.currentPlayer == self.playerOne {
                    self.player1ScoreLabel.text = "\(self.currentPlayer.name): \(self.currentPlayer.score)"
                } else {
                    self.player2ScoreLabel.text = "\(self.currentPlayer.name): \(self.currentPlayer.score)"
                }
                
                self.scoreForTurn = 0
                self.scoreForFarkle = 0
                
                self.nextTurn()
                
            })
        }
        }
    }
    
    func nextTurn(){
        if currentPlayer == playerOne {
            currentPlayer = playerTwo
            currentPlayerLabel.text = playerTwo.name
        } else {
            currentPlayer = playerOne
            currentPlayerLabel.text = playerOne.name
        }
    }
    
}




