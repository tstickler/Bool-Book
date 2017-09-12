//
//  gameViewController.swift
//  Bowl-Book
//
//  Created by Tyler Stickler on 9/8/17.
//  Copyright © 2017 tstick. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {
    var newGame: game!
    var currentBall: Int!
    
    /* Variables to refer to score labels */
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var f1b1Label: UILabel!
    @IBOutlet weak var f1b2Label: UILabel!
    @IBOutlet weak var f2b1Label: UILabel!
    @IBOutlet weak var f2b2Label: UILabel!
    @IBOutlet weak var f3b1Label: UILabel!
    @IBOutlet weak var f3b2Label: UILabel!
    @IBOutlet weak var f4b1Label: UILabel!
    @IBOutlet weak var f4b2Label: UILabel!
    @IBOutlet weak var f5b1Label: UILabel!
    @IBOutlet weak var f5b2Label: UILabel!
    @IBOutlet weak var f6b1Label: UILabel!
    @IBOutlet weak var f6b2Label: UILabel!
    @IBOutlet weak var f7b1Label: UILabel!
    @IBOutlet weak var f7b2Label: UILabel!
    @IBOutlet weak var f8b1Label: UILabel!
    @IBOutlet weak var f8b2Label: UILabel!
    @IBOutlet weak var f9b1Label: UILabel!
    @IBOutlet weak var f9b2Label: UILabel!
    @IBOutlet weak var f10b1Label: UILabel!
    @IBOutlet weak var f10b2Label: UILabel!
    @IBOutlet weak var f10b3Label: UILabel!

    /* Handles the new game button being tapped */
    @IBAction func newGameStart(_ sender: Any) {
        newGame = game.init()
        currentBall = 1
        scoreLabel.text = "0"
        
        buttonsVisible(startIndex: 0, visible: true)
    }
    
    @IBAction func foulButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 0, ball: currentBall)
    }
    @IBAction func oneButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 1, ball: currentBall)
    }
    @IBAction func twoButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 2, ball: currentBall)
    }
    @IBAction func threeButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 3, ball: currentBall)
    }
    
    @IBAction func fourButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 4, ball: currentBall)
    }
    
    @IBAction func fiveButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 5, ball: currentBall)
    }
    
    @IBAction func sixButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 6, ball: currentBall)
    }
    
    @IBAction func sevenButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 7, ball: currentBall)
    }
    
    @IBAction func eightButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 8, ball: currentBall)
    }
    
    @IBAction func nineButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 9, ball: currentBall)
    }

    @IBAction func strikeButtonTapped(_ sender: UIButton) {
        addRollToGame(score: 10, ball: currentBall)
    }
    
    func addRollToGame(score: Int, ball: Int) {
        let currFrame = newGame.currentFrame
        updatePreviousFrames(score: score, ball: ball)
        updateFrameLabel(score: score, ball: ball)
        
        switch ball{
        case 1:
            // Add the score to the frame
            newGame.frames[currFrame].ballOne = score
            newGame.frames[currFrame].frameTotal += score
            
            // If we didn't get a strike OR we're in the final frame go to the next ball
            if score != 10 || currFrame == 9 {
                currentBall = 2
            }
            else {
                // If we got a strike, go to the next frame
                newGame.frames[currFrame].isStrike = true
                newGame.currentFrame += 1
            }
        case 2:
            // Add the score to the frame
            newGame.frames[currFrame].ballTwo = score
            newGame.frames[currFrame].frameTotal += score
            
            // If our two balls total 10, set spare flag
            if newGame.frames[currFrame].ballOne + score == 10 {
                newGame.frames[currFrame].isSpare = true
            }
            
            // If we aren't in the last frame switch back to ball 1 and go to the next frame
            if newGame.currentFrame != 9 {
                currentBall = 1
                newGame.currentFrame += 1
            }
            // The only time we get a third ball is if we've already got a mark in the tenth.
            // This occurs with either a XX, X-, or -/. So anything totaling >= 10 gets 
            // us a third ball in the tenth.
            else if newGame.frames[9].ballOne + newGame.frames[9].ballTwo! >= 10 {
                currentBall = 3
            }
            else {
                newGame.gameOver = true
            }
        case 3:
            // Add score to the frame
            newGame.frames[currFrame].ballThree = score
            newGame.frames[currFrame].frameTotal += score
            
            // Indicate that the game has ended
            newGame.gameOver = true
        default:
            break
        }
        manageButtons(score: score, ball: currentBall)

        // Breaks the app when game is over
        if newGame.gameOver {
            buttonsVisible(startIndex: 0, visible: false)
        }
        
        scoreLabel.text = String(newGame.calculateTotal())
    }
    
    func updatePreviousFrames(score: Int, ball: Int) {
        let previousFrame = newGame.currentFrame - 1
        
        if newGame.currentFrame == 0 { /* Do nothing, no previous frame to update */ }
        else if newGame.currentFrame == 1 {
            // If we're in the second frame, check first frame for X
            if newGame.frames[previousFrame].isStrike {
                newGame.frames[previousFrame].frameTotal += score
            }
            // If there was no strike and we're on the first ball, check for /
            else if newGame.frames[previousFrame].isSpare && ball == 1 {
                newGame.frames[previousFrame].frameTotal += score
            }
            else { /* Do nothing, no strike or spare means no frame to update */ }
        }
        else if newGame.currentFrame < 9 {
            // If we're in the between frames 3 and 9, check previous frame for X
            if newGame.frames[previousFrame].isStrike {
                // If previous frame had a X and we're on ball 1, check for XX
                if newGame.frames[previousFrame - 1].isStrike && ball == 1{
                    newGame.frames[previousFrame - 1].frameTotal += score
                }
                newGame.frames[previousFrame].frameTotal += score
            }
            else if newGame.frames[previousFrame].isSpare && ball == 1 {
                // If there was no X and we're on the first ball, check for /
                newGame.frames[previousFrame].frameTotal += score
            }
            else {/* Do nothing, no strike or spare means no frame to update */}
        }
        else if newGame.currentFrame == 9 {
            // If we're in frame 10 and our we aren't on ball 3, check previous frame for X
            if newGame.frames[8].isStrike && ball < 3 {
                // If previous frame had a X and we're on ball 1, check for XX
                if newGame.frames[7].isStrike && ball == 1 {
                    newGame.frames[7].frameTotal += score
                }
                newGame.frames[8].frameTotal += score
            }
            else if newGame.frames[previousFrame].isSpare && ball == 1 {
                // If there was no X and we're on the first ball, check for /
                newGame.frames[previousFrame].frameTotal += score
            }
            else {/* Do nothing, no strike or spare means no frame to update */}
        }
    }
    
    func manageButtons(score: Int, ball: Int) {
        let currentFrame = newGame.currentFrame
        let startRange = 11 - score

        if ball == 1 {
            buttonsVisible(startIndex: 0, visible: true)
        }
        else if ball == 2 && newGame.frames[currentFrame].ballOne != 10 {
            buttonsVisible(startIndex: startRange, visible: false)
        }
        else if ball == 3 {
            if newGame.frames[currentFrame].ballOne == 10 && newGame.frames[currentFrame].ballTwo != 10 {
                buttonsVisible(startIndex: startRange, visible: false)

            }
            else if newGame.frames[currentFrame].isSpare {
                buttonsVisible(startIndex: 0, visible: true)

            }
        }
    }
    
    func buttonsVisible(startIndex: Int, visible: Bool) {
        for i in startIndex...12 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.isEnabled = visible
            }
        }
    }
    
    func updateFrameLabel(score: Int, ball: Int) {
        let currentFrame = newGame.currentFrame
        var stringScore = String(score)
        
        if stringScore == "10" {
            stringScore = "X"
        }
        else if stringScore == "0" {
            stringScore = "-"
        }
        else if ball == 2 && score + newGame.frames[currentFrame].ballOne == 10 {
            stringScore = "/"
        }
        
        switch currentFrame {
        case 0:
            if ball == 1 {
                f1b1Label.text = stringScore
            }
            else if ball == 2 {
                f1b2Label.text = stringScore
            }
        case 1:
            if ball == 1 {
                f2b1Label.text = stringScore
            }
            else if ball == 2 {
                f2b2Label.text = stringScore
            }
        case 2:
            if ball == 1 {
                f3b1Label.text = stringScore
            }
            else if ball == 2 {
                f3b2Label.text = stringScore
            }
        case 3:
            if ball == 1 {
                f4b1Label.text = stringScore
            }
            else if ball == 2 {
                f4b2Label.text = stringScore
            }
        case 4:
            if ball == 1 {
                f5b1Label.text = stringScore
            }
            else if ball == 2 {
                f5b2Label.text = stringScore
            }
        case 5:
            if ball == 1 {
                f6b1Label.text = stringScore
            }
            else if ball == 2 {
                f6b2Label.text = stringScore
            }
        case 6:
            if ball == 1 {
                f7b1Label.text = stringScore
            }
            else if ball == 2 {
                f7b2Label.text = stringScore
            }
        case 7:
            if ball == 1 {
                f8b1Label.text = stringScore
            }
            else if ball == 2 {
                f8b2Label.text = stringScore
            }
        case 8:
            if ball == 1 {
                f9b1Label.text = stringScore
            }
            else if ball == 2 {
                f9b2Label.text = stringScore
            }
        case 9:
            if ball == 1 {
                f10b1Label.text = stringScore
            }
            else if ball == 2 {
                f10b2Label.text = stringScore
            }
            else if ball == 3 {
                f10b3Label.text = stringScore
            }
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsVisible(startIndex: 0, visible: false)
    }
}
