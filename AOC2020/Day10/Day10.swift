//
//  Day10.swift
//  AOC2020
//
//  Created by Jacob Bullock on 12/9/20.
//

import Foundation

class Day10: Day {
    override var name: String { "10" }
    
    override func part1() -> String {
        let list = input.integers.sorted()
        var lastInt = 0
        
        var c1 = 0
        var c3 = 0
        
        for i in list {
            let d = i - lastInt
            if d == 1 {
                c1 += 1
            } else if d == 3 {
                c3 += 1
            }
            
            lastInt = i
        }
        
        c3 += 1
        
        return "\(c1 * c3)"
    }
    
    override func part2() -> String {
        let list = input.integers.sorted()
        var lastInt = 0

        var singleJumps: [Int] = [0]
        var jumps: [[Int]] = []
        
        for i in list {
            let d = i - lastInt
            if d == 1 {
                if !singleJumps.contains(lastInt) {
                    singleJumps.append(lastInt)
                }
                singleJumps.append(i)
            } else if d == 3 {
                if (singleJumps.count > 0) {
                    jumps.append(singleJumps)
                    singleJumps = []
                }
            }
            
            lastInt = i
        }
        
        if (singleJumps.count > 0) {
            jumps.append(singleJumps)
        }
        
        print(jumps)
        
        let counts = jumps.map { arr -> Int in
            let c = arr.count
            if c == 1 || c == 4 {
                return c
            } else if c <= 3 {
                return c - 1
            } else {
                let d = c - 3
                return (d * 4) - (d-1)
            }
        }
        
       print(counts)
        
        return "\(counts.reduce(1, *))"
    }
}
