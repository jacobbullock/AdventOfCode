//
//  Day01.swift
//  AOC2015
//
//  Created by Jacob Bullock on 12/10/20.
//

import Foundation

class Day01: Day {
    override var name: String { "01" }
    
    override func part1() -> String {
        var f = 0
        for c in input.raw {
            if c == "(" {
                f += 1
            } else if c == ")" {
                f -= 1
            }
        }
        return "\(f)"
    }
    
    override func part2() -> String {
        var f = 0
        var i = 1
        
        for c in input.raw {
            if c == "(" {
                f += 1
            } else if c == ")" {
                f -= 1
            }
            
            if f == -1 {
                break
            }
            
            i += 1
        }
        return "\(i)"
    }
}
