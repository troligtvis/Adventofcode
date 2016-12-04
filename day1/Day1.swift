//
//  Day1.swift
//  Adventofcode
//
//  Created by Kj Drougge on 2016-12-01.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation

typealias Instruction = (direction: Direction, blocks: CGFloat)

class Day1 {
    private let input = "L2, L3, L3, L4, R1, R2, L3, R3, R3, L1, L3, R2, R3, L3, R4, R3, R3, L1, L4, R4, L2, R5, R1, L5, R1, R3, L5, R2, L2, R2, R1, L1, L3, L3, R4, R5, R4, L1, L189, L2, R2, L5, R5, R45, L3, R4, R77, L1, R1, R194, R2, L5, L3, L2, L1, R5, L3, L3, L5, L5, L5, R2, L1, L2, L3, R2, R5, R4, L2, R3, R5, L2, L2, R3, L3, L2, L1, L3, R5, R4, R3, R2, L1, R2, L5, R4, L5, L4, R4, L2, R5, L3, L2, R4, L1, L2, R2, R3, L2, L5, R1, R1, R3, R4, R1, R2, R4, R5, L3, L5, L3, L3, R5, R4, R1, L3, R1, L3, R3, R3, R3, L1, R3, R4, L5, L3, L1, L5, L4, R4, R1, L4, R3, R3, R5, R4, R3, R3, L1, L2, R1, L4, L4, L3, L4, L3, L5, R2, R4, L2".components(separatedBy: ", ")
    
    // Part 1
    private let test1 = ["R2", "L3"] // 5 blocks
    private let test2 = ["R2", "R2", "R2"] // 2 blocks
    private let test3 = ["R5", "L5", "R5", "R3"] // 12 blocks
    
    // Part 2
    private let test4 = ["R8", "R4", "R4", "R8"] // The first location you visit twice is 4 blocks away, due East
    
    private var currentFace: Face = .north
    private var instructions = [Instruction]()
    
    private var position: CGPoint = CGPoint.zero
    private var visitedPositions = [CGPoint]()
    private var secondVisit: Bool = false
    
    private func setupInstructions(){
        let instructions: [Instruction] = input.map({ instStr in
            let str = instStr.characters
            let direction = Direction(str.first!)
            let blocks = Int(String.init(str.dropFirst()))!
            return (direction: direction, blocks: CGFloat(blocks))
        })
        
        self.instructions = instructions
    }
    
    func getTotalBlocks(){
        setupInstructions()
        
        for instruction in instructions {
            if instruction.direction == .right {
                currentFace = currentFace.next()
            } else {
                currentFace = currentFace.next(true)
            }
    
            move(instruction.blocks)
        }
        
        position = CGPoint(x: abs(position.x), y: abs(position.y))
        print("Santa: (x:\(position.x), y:\(position.y)), blocks away: \(position.x + position.y)")
    }
    
    private func move(_ steps: CGFloat){
        var x = position.x
        var y = position.y
        
        for _ in 0..<Int(steps) {
            switch currentFace {
            case .north: y += 1
            case .east: x += 1
            case .south: y -= 1
            case .west: x -= 1
            }
            
            
            if !secondVisit {
                let newPos = CGPoint(x: x, y: y)
                if !visitedPositions.contains(newPos) {
                    visitedPositions.append(newPos)
                } else {
                    secondVisit = true
                    print("2nd time: (x:\(newPos.x), y:\(newPos.y)), blocks away: \((abs(newPos.x) + abs(newPos.y)))")
                }
            }
        }
        
        position = CGPoint(x: x, y: y)
    }
}
