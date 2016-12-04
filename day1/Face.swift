//
//  Direction.swift
//  Adventofcode
//
//  Created by Kj Drougge on 2016-12-01.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation

enum Face {
    case north 
    case east
    case south
    case west
}

extension Face {
    func next(_ clockwise: Bool = false) -> Face {
        return clockwise ? getNext() : getPrevious()
    }
    
    private func getNext() -> Face{
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        }
    }
    
    private func getPrevious() -> Face{
        switch self {
        case .north: return .west
        case .east: return .north
        case .south: return .east
        case .west: return .south
        }
    }
}
