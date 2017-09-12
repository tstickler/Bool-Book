//
//  game.swift
//  Bowl-Book
//
//  Created by Tyler Stickler on 9/8/17.
//  Copyright © 2017 tstick. All rights reserved.
//

import UIKit

class game {
    var totalScore: Int
    var currentFrame: Int
    var frames = [frame]()
    var gameOver: Bool
    
    init(){
        totalScore = 0
        currentFrame = 0
        gameOver = false
        
        for _ in 0...9 {
            frames.append(frame.init())
        }
    }
    
    func calculateTotal() -> Int {
        
        var temp  = 0
        for i in 0...9 {
            temp += frames[i].frameTotal
        }
        totalScore = temp
        return totalScore
    }
    
    func printFrameTotals() {
        for i in 0...9 {
            print(frames[i].frameTotal)
        }
    }
}
