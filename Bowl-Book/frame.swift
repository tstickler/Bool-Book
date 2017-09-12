//
//  frame.swift
//  Bowl-Book
//
//  Created by Tyler Stickler on 9/8/17.
//  Copyright © 2017 tstick. All rights reserved.
//

import UIKit

class frame {
    var ballOne: Int!
    var ballTwo: Int?
    var ballThree: Int?
    var frameTotal: Int
    var isStrike: Bool
    var isSpare: Bool
    
    
    init(){
        isStrike = false
        isSpare = false
        frameTotal = 0
    }
}
