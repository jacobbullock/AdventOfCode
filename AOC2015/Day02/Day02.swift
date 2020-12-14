//
//  Day02.swift
//  AOC2015
//
//  Created by Jacob Bullock on 12/10/20.
//

import Foundation

class Day02: Day {
    override var name: String { "02" }
    
    override func part1() -> String {
        var result = 0
        for line in input.lines {
            let m = line.components(separatedBy: "x").map { Int($0)! }
            
            let a = m[0] * m[1]
            let b = m[0] * m[2]
            let c = m[1] * m[2]
            
            let slack = [a,b,c].sorted().first!
            
            result += (2 * a) + (2 * b) + (2 * c) + slack

        }
        return "\(result)"
    }
    
    override func part2() -> String {
        var result = 0
        for line in input.lines {
            let m = line.components(separatedBy: "x").map { Int($0)! }
            
            let a = m[0]
            let b = m[1]
            let c = m[2]
            
            var d = [a,b,c].sorted()
            d.removeLast()
            
            result += (2 * d[0]) + (2 * d[1]) + (a * b * c)

        }
        return "\(result)"
    }
}

