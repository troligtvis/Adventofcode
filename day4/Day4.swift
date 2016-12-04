//
//  Day4.swift
//  Adventofcode_day4
//
//  Created by Kj Drougge on 2016-12-04.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation


class Day4 {
    private let alphabet: [String] = "abcdefghijklmnopqrstuvwxyz".toLetters()
    private var input = [String]()
    private var sum: Int = 0
    
    private func readFile(){
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt") else { return }
        
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            let myStrings = data.components(separatedBy: .newlines)
            self.input = myStrings
        } catch {
            print(error)
        }
    }
    
    func getSumOfSectorIDs(){
        self.readFile()
        
        _ = input.map({ checkLine($0) })
        
        print("Sum of the legit Sector ID's is", sum)
    }
    
    private func checkLine(_ line: String){
        var m = matches(for: "\\w+", in: line)
        guard m.count > 0 else { return }
        
        let checkSum = m.removeLast()
        let sectorID = m.removeLast()
        let encryptedName = m.joined(separator: " ")
        
        let shiftedEncryptedName = m.joined(separator: " ").characters.map({ ceasarCipher(String.init($0), shift: Int(sectorID)!) }).joined()
        if shiftedEncryptedName == "northpole object storage" {
            print("Sector ID of the room where North Pole objects are stored:", sectorID)
        }
        
        let result = alphabet.map({ matches(for: $0, in: encryptedName) }).sorted(by: sortByLength).filter({ $0 != [] })
        guard result.count > 0 else { return }
        
        var list = [[String]]()
        for i in 0...result.count {
            let k = result.filter({ $0.count == i }).sorted(by: sortByValue)
            guard !k.isEmpty else { continue }
            list.insert(k.flatMap({ $0.first }), at: 0)
        }
        
        let mostCommonLetters = list.reduce([], +)[0..<5].joined()
        guard matches(for: "[\(checkSum)]", in: mostCommonLetters).count == 5 else { return }
        sum += Int(sectorID)!
    }
    
    private func ceasarCipher(_ letter: String, shift: Int) -> String{
        guard let index = alphabet.index(of: letter) else { return letter }
        
        let newIndex = (Int(index) + shift) % alphabet.count
        return alphabet[newIndex]
    }
    
    private func sortByLength(this: [String], that: [String]) -> Bool{
        return this.count > that.count
    }
    
    private func sortByValue(this: [String], that: [String]) -> Bool{
        guard let this = this.first, let that = that.first else { return false }
        return this < that
    }
    
    private func matches(for regex: String, in text: String) -> [String]{
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map({ nsString.substring(with: $0.range) })
        } catch let error {
            print("invalid regex:", error.localizedDescription)
            return []
        }
    }
}


extension String{
    func toLetters() -> [String]{
        return Array(self.unicodeScalars).map{String($0)}
    }
}
