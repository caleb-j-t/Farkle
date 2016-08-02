//
//  Player.swift
//  FarkleSwift
//
//  Created by Caleb Talbot on 6/11/16.
//  Copyright © 2016 Caleb Talbot. All rights reserved.
//

import UIKit

class Player: NSObject {
    
    var name = ""
    var score = 0
    
    init(withName playerName: String) {
        name = playerName
        score = 0
    }
}
