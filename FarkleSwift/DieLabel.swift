//
//  DieLabel.swift
//  FarkleSwift
//
//  Created by Caleb Talbot on 6/9/16.
//  Copyright © 2016 Caleb Talbot. All rights reserved.
//

import UIKit

@objc protocol DieLabelDelegate {
    optional func handleTapped(sender: UITapGestureRecognizer)
    optional func rollADie()
    optional func resetDie()
    
}

class DieLabel: UILabel, UIGestureRecognizerDelegate {
    
    var delegate:DieLabelDelegate?
    
    var held: Bool?
    var outOfPlay = false
    
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tapgGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DieLabel.handleTapped(_:)))
        self.addGestureRecognizer(tapgGestureRecognizer)
        tapgGestureRecognizer.numberOfTapsRequired = 1
        tapgGestureRecognizer.delegate = self
        held = false
    }


func handleTapped(sender: UITapGestureRecognizer) {
    if (sender.state == .Ended) {
        if (held == false) {
            held = true
            self.backgroundColor = UIColor(red:0.90, green:0.30, blue:0.26, alpha:1.00)
            self.textColor = UIColor(red:0.18, green:0.24, blue:0.31, alpha:1.00)
        } else {
            held = false
            self.backgroundColor = UIColor(red:0.18, green:0.24, blue:0.31, alpha:1.00)
            self.textColor = UIColor(red:0.90, green:0.30, blue:0.26, alpha:1.00)

        }
        
       delegate?.handleTapped?(sender)
}
    }

    func rollADie() {
        let randomNumber = arc4random_uniform(6) + 1
        let numberOnDice = randomNumber
        self.text = "\(numberOnDice)"
}


    func resetDie() {
        self.userInteractionEnabled = true
        held = false
        outOfPlay = false
        self.text = "✖︎"
        self.backgroundColor = UIColor(red:0.18, green:0.24, blue:0.31, alpha:1.00)
        self.textColor = UIColor(red:0.90, green:0.30, blue:0.26, alpha:1.00)
    }
}

