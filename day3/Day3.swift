//
//  Day3.swift
//  Adventofcode_day3
//
//  Created by Kj Drougge on 2016-12-03.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation

class Day3 {
    private var input = [[String]]()
    private var validRowTriangles: Int = 0
    private var validColTriangles: Int = 0
    
    private func readFile(){
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt") else { return }
        
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            let myStrings = data.components(separatedBy: .newlines).map({ $0.replacingOccurrences(of: "  ", with: ",").components(separatedBy: ",").filter({ $0 != "" }).map({ $0.replacingOccurrences(of: " ", with: "") }) })
            
            input = myStrings
        } catch {
            print(error)
        }
    }
    
    func countValidTriangles(){
        readFile()
        
        byColumn()
        
        byRow()
        
        print(validRowTriangles, validColTriangles)
    }
    
    private func byRow(){
        _ = input.map({ triangleInequalityTheorem(triangle: $0) ? validRowTriangles += 1 : () })
    }
    
    private func byColumn(){
        for c in 0..<3 {
            for r in stride(from: 0, to: input.count, by: 3) {
                _ = triangleInequalityTheorem(triangle: [input[r][c], input[r + 1][c], input[r + 2][c]]) ? validColTriangles += 1 : ()
            }
        }
    }
    
    private func triangleInequalityTheorem(triangle t: [String]) -> Bool {
        let a = Int(t[0])!
        let b = Int(t[1])!
        let c = Int(t[2])!
        
        guard (a + b > c) && (a + c > b) && (b + c > a) else { return false }
        
        return true
    }
}
