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
    var labels = [UILabel]()
    var buttons = [UIButton]()
    var frameScoreLabels = [UILabel]()
    var lastButtonPress: Int!
    var sum: Int = 0
    
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
    
    /* Variables to refer to buttons */
    @IBOutlet weak var zeroBtn: UIButton!
    @IBOutlet weak var oneBtn: UIButton!
    @IBOutlet weak var twoBtn: UIButton!
    @IBOutlet weak var threeBtn: UIButton!
    @IBOutlet weak var fourBtn: UIButton!
    @IBOutlet weak var fiveBtn: UIButton!
    @IBOutlet weak var sixBtn: UIButton!
    @IBOutlet weak var sevenBtn: UIButton!
    @IBOutlet weak var eightBtn: UIButton!
    @IBOutlet weak var nineBtn: UIButton!
    @IBOutlet weak var strikeBtn: UIButton!
    @IBOutlet weak var foulBtn: UIButton!
    
    /* Variables for individual frame scores */
    @IBOutlet weak var f1Score: UILabel!
    @IBOutlet weak var f2Score: UILabel!
    @IBOutlet weak var f3Score: UILabel!
    @IBOutlet weak var f4Score: UILabel!
    @IBOutlet weak var f5Score: UILabel!
    @IBOutlet weak var f6Score: UILabel!
    @IBOutlet weak var f7Score: UILabel!
    @IBOutlet weak var f8Score: UILabel!
    @IBOutlet weak var f9Score: UILabel!
    @IBOutlet weak var f10Score: UILabel!
    

    /* Handles the new game button being tapped */
    @IBAction func newGameStart(_ sender: Any) {
        newGame = game.init()
        currentBall = 1
        scoreLabel.text = "0"
        sum = 0
        
        buttonsEnabled(startIndex: -1, enabled: true)
        buttonsHidden(hidden: false)
        for i in 0...20 {
            labels[i].text = ""
        }
        
        for j in 0...9 {
            frameScoreLabels[j].text = ""
        }
    }
    
    @IBAction func foulButtonTapped(_ sender: UIButton) {
        // lastButtonPress variable is only used to differentiate between
        // a 0 roll and a foul for labeling purpose
        lastButtonPress = foulBtn.tag
        addRollToGame(score: 0, ball: currentBall)
    }
    
    @IBAction func zeroButtonTapped(_ sender: UIButton) {
        // lastButtonPress variable is only used to differentiate between
        // a 0 roll and a foul for labeling purpose
        lastButtonPress = zeroBtn.tag
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
        if currentBall == 1 {
            addRollToGame(score: 10, ball: currentBall)
        }
        else if currentBall == 2{
            addRollToGame(score: 10 - newGame.frames[newGame.currentFrame].ballOne, ball: currentBall)
        }
        else if currentBall == 2{
            addRollToGame(score: 10 - newGame.frames[newGame.currentFrame].ballTwo!, ball: currentBall)
        }
    }
    
    /* Based on the button pressed, add the input to the game */
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
                
                if score == 10 {
                    newGame.frames[currFrame].isStrike = true
                }
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
            else {
                if currFrame < 9 {
                    newGame.frames[currFrame].doneUpdating = true
                    frameScoreLabels[currFrame].text = String(newGame.calculateTotal())
                }
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
                newGame.frames[currFrame].doneUpdating = true
                frameScoreLabels[currFrame].text = String(newGame.calculateTotal())

                newGame.gameOver = true
            }
        case 3:
            // Add score to the frame
            newGame.frames[currFrame].ballThree = score
            newGame.frames[currFrame].frameTotal += score
            
            // Indicate that the game has ended
            
            newGame.frames[currFrame].doneUpdating = true
            frameScoreLabels[currFrame].text = String(newGame.calculateTotal())

            newGame.gameOver = true
        default:
            break
        }
        // Enables/disables buttons based on current score and ball
        manageButtons(score: score, ball: currentBall)

        // Updates the total score
        scoreLabel.text = String(newGame.calculateTotal())
        
        // Handles the game ending
        if newGame.gameOver {
            gameOver()
        }
        
    }
    
    /* Previous frames must be update if they were strikes or spares */
    func updatePreviousFrames(score: Int, ball: Int) {
        let previousFrame = newGame.currentFrame - 1
        let currentFrameTotal = newGame.frames[newGame.currentFrame].frameTotal
        
        if newGame.currentFrame == 0 { /* Do nothing, no previous frame to update */ }
        else if newGame.currentFrame == 1 {
            // If we're in the second frame, check first frame for X
            if newGame.frames[previousFrame].isStrike {
                newGame.frames[previousFrame].frameTotal += score
                if ball == 2 {
                    newGame.frames[previousFrame].doneUpdating = true
                    frameScoreLabels[previousFrame].text = String(newGame.calculateTotal())

                }
            }
            // If there was no strike and we're on the first ball, check for /
            else if newGame.frames[previousFrame].isSpare && ball == 1 {
                newGame.frames[previousFrame].frameTotal += score
                newGame.frames[previousFrame].doneUpdating = true
                frameScoreLabels[previousFrame].text = String(newGame.calculateTotal())

            }
            else { /* Do nothing, no strike or spare means no frame to update */ }
        }
        else if newGame.currentFrame < 9 {
            // If we're in the between frames 3 and 9, check previous frame for X
            if newGame.frames[previousFrame].isStrike {
                // If previous frame had a X and we're on ball 1, check for XX
                if newGame.frames[previousFrame - 1].isStrike && ball == 1{
                    newGame.frames[previousFrame - 1].frameTotal += score
                    newGame.frames[previousFrame - 1].doneUpdating = true
                    frameScoreLabels[previousFrame - 1].text = String(newGame.calculateTotal() - currentFrameTotal - newGame.frames[previousFrame].frameTotal)

                }
                newGame.frames[previousFrame].frameTotal += score
                if ball == 2 {
                    newGame.frames[previousFrame].doneUpdating = true
                    frameScoreLabels[previousFrame].text = String(newGame.calculateTotal() - currentFrameTotal)
                }
            }
            else if newGame.frames[previousFrame].isSpare && ball == 1 {
                // If there was no X and we're on the first ball, check for /
                newGame.frames[previousFrame].frameTotal += score
                newGame.frames[previousFrame].doneUpdating = true
                frameScoreLabels[previousFrame].text = String(newGame.calculateTotal())

            }
            else {/* Do nothing, no strike or spare means no frame to update */}
        }
        else if newGame.currentFrame == 9 {
            // If we're in frame 10 and our we aren't on ball 3, check previous frame for X
            if newGame.frames[8].isStrike && ball < 3 {
                // If previous frame had a X and we're on ball 1, check for XX
                if newGame.frames[7].isStrike && ball == 1 {
                    newGame.frames[7].frameTotal += score
                    newGame.frames[7].doneUpdating = true
                    frameScoreLabels[7].text = String(newGame.calculateTotal() - currentFrameTotal - newGame.frames[previousFrame].frameTotal)
                }
                newGame.frames[8].frameTotal += score
                if ball == 2 {
                    newGame.frames[8].doneUpdating = true
                    frameScoreLabels[8].text = String(newGame.calculateTotal() - currentFrameTotal)
                }
            }
            else if newGame.frames[previousFrame].isSpare && ball == 1 {
                // If there was no X and we're on the first ball, check for /
                newGame.frames[previousFrame].frameTotal += score
                newGame.frames[previousFrame].doneUpdating = true
                frameScoreLabels[previousFrame].text = String(newGame.calculateTotal())

            }
            else {/* Do nothing, no strike or spare means no frame to update */}
        }
    }
    
    /* Manages if buttons able to be tapped or not */
    func manageButtons(score: Int, ball: Int) {
        let currentFrame = newGame.currentFrame
        
        // This is used to determine what index to start disabling buttons.
        // EX. User gets a 3, 11 - 3 is 8 so we disable 8, 9, X buttons for
        // second ball.
        let startRange = 11 - score

        // Ball one should show all buttons
        if ball == 1 || score == 0 {
            buttonsEnabled(startIndex: -1, enabled: true)
        }
        // Ball two should hide buttons based on ball one roll
        else if ball == 2 && newGame.frames[currentFrame].ballOne != 10 {
            buttonsEnabled(startIndex: startRange, enabled: false)
        }
        // Ball three only occurs in 10th frame
        else if ball == 3 {
            // If user got a X on the first ball and a non-X on second ball, hide buttons based on secore
            if newGame.frames[currentFrame].ballOne == 10 && newGame.frames[currentFrame].ballTwo != 10 {
                buttonsEnabled(startIndex: startRange, enabled: false)
            }
            // If the user got a / at the beginning of the tenth, then all buttons should be enabled
            else if newGame.frames[currentFrame].isSpare {
                buttonsEnabled(startIndex: -1, enabled: true)
            }
        }
    }
    
    /* Iterates through button array to enable/disable specific buttons */
    func buttonsEnabled(startIndex: Int, enabled: Bool) {
        
        // We need to always start at index 2 so foul and zero button are always available.
        let begin = startIndex + 1
        
        for i in begin...11 {
            buttons[i].isEnabled = enabled
        }
    }
    
    /* Iterates through the buttons array and hides buttons */
    func buttonsHidden(hidden: Bool) {
        for i in 0...11 {
            buttons[i].isHidden = hidden
        }
    }
    
    /* Handles updating the labels to display the user score */
    func updateFrameLabel(score: Int, ball: Int) {
        let currentFrame = newGame.currentFrame
        var stringScore = String(score)
        
        /* Handling for proper labeling of X or / */
        if currentFrame < 9 {
            // If the user got a 10, mark as an X
            if stringScore == "10" && ball == 1{
                stringScore = "X"
            }
                
            // If ball one and ball two add to 10, mark as a /
            else if ball == 2 && score + newGame.frames[currentFrame].ballOne == 10 {
                stringScore = "/"
            }
        }
        else {
            switch ball {
            case 1:
                if stringScore == "10" {
                    stringScore = "X"
                }
            case 2:
                if newGame.frames[currentFrame].ballOne == 10 {
                    if stringScore == "10" {
                        stringScore = "X"
                    }
                }
                else if score + newGame.frames[currentFrame].ballOne == 10 {
                    stringScore = "/"
                }
            case 3:
                if newGame.frames[currentFrame].isStrike {
                    if newGame.frames[currentFrame].ballTwo != 10 {
                        if score + newGame.frames[currentFrame].ballTwo! == 10 {
                            stringScore = "/"
                        }
                    }
                    else if stringScore == "10" {
                        stringScore = "X"
                    }
                }
                else if newGame.frames[currentFrame].isSpare {
                    if stringScore == "10" {
                        stringScore = "X"
                    }
                }
            default:
                break
            }
        }
        
        // If the user got a 0, mark as a -
        if stringScore == "0" {
            if lastButtonPress == -1 {
                stringScore = "F"
            }
            else {
                stringScore = "-"
            }
        }
        
        // Modifies the label based on the score the user has input
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
    
    /* Handles the game ending */
    func gameOver() {
        buttonsHidden(hidden: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frameScoreLabels = [f1Score, f2Score,
                            f3Score, f4Score,
                            f5Score, f6Score,
                            f7Score, f8Score,
                            f9Score, f10Score]
        
        
        // Puts our score labels into an array so as the game goes on
        // we can keep track of what label to update
        labels = [f1b1Label, f1b2Label,
                  f2b1Label, f2b2Label,
                  f3b1Label, f3b2Label,
                  f4b1Label, f4b2Label,
                  f5b1Label, f5b2Label,
                  f6b1Label, f6b2Label,
                  f7b1Label, f7b2Label,
                  f8b1Label, f8b2Label,
                  f9b1Label, f9b2Label,
                  f10b1Label, f10b2Label, f10b3Label]
        
        // Puts our buttons into an array so we can enable/disable them
        // to only allow proper score entry ie no score > 10 per frame
        buttons = [foulBtn, zeroBtn, oneBtn,
                   twoBtn, threeBtn, fourBtn,
                   fiveBtn, sixBtn, sevenBtn,
                   eightBtn, nineBtn, strikeBtn]
        
        // Sets all buttons to initially be disabled. Clicking the start
        // button will enable the buttons.
        buttonsEnabled(startIndex: -1, enabled: false)

    }
}
