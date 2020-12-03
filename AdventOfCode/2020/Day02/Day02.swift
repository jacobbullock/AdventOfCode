//
//  Day02.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/2/20.
//

import Foundation

class Day02: Day {
    override var name: String { "02" }

    override func part1() -> String {
        var result = 0
        for line in inp.lines {
            let parts = line.components(separatedBy: " ")
            let range = parts[0].components(separatedBy: "-")
            let min = Int(range[0])!
            let max = Int(range[1])!
            let c: Character = parts[1][0]
            let pw = parts[2]
            
            let count = pw.filter{ $0 == c }.count
            
            if count >= min && count <= max {
                result += 1
            }
        }
        
        return "\(result)"
    }

    override func part2() -> String {
        var result = 0
        for line in inp.lines {
            let parts = line.components(separatedBy: " ")
            let range = parts[0].components(separatedBy: "-")
            let min = Int(range[0])!
            let max = Int(range[1])!
            let c: Character = parts[1][0]
            let pw = parts[2]
            
            let m1 = pw[min-1] == c
            let m2 = pw[max-1] == c
            
            if m1 ^ m2 {
                result += 1
            }
        }
        
        return "\(result)"
    }
}


