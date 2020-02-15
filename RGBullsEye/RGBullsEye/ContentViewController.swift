//
//  ContentViewController.swift
//  RGBullsEye
//
//  Created by Ryan Hernandez on 2/15/20.
//  Copyright © 2020 Ryan Hernandez. All rights reserved.
//

import SwiftUI

class ContentViewController : UIViewController {
    func getMessage(score: Int) -> String {
        var message = ""
        
        if (score == 100) { message = "Right on the money!" }
        else if (score > 97) { message = "So close!" }
        else if (score > 89) { message = "Nice!" }
        else if (score > 74) { message = "Getting there." }
        else { message = "Not good..." }
        
        return message
    }
    
    func computeScore(guesses: [Double], targets: [Double]) -> Int {
        let rDiff = guesses[0] - targets[0]
        let gDiff = guesses[1] - targets[1]
        let bDiff = guesses[2] - targets[2]
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        
        return Int((1.0 - diff) * 100.0 + 0.5)
    }
}
