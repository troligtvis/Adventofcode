//
//  Direction.swift
//  Adventofcode
//
//  Created by Kj Drougge on 2016-12-01.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation

enum Direction {
    case left
    case right
    
    init(_ value: Character){
        switch value {
        case "L": self = .left
        case "R": self = .right
        default: self = .left
        }
    }
}
