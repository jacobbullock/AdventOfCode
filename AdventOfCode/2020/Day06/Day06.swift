//
//  Day06.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/5/20.
//

import Foundation

class Day06: Day {
    override var name: String { "06" }
    
    override func part1() -> String {
        let groups = input.raw.components(separatedBy: "\n\n")

        var total = [Int]()
        for group in groups {
            var set = Set<Character>()
            
            let answers = group.filter { !$0.isWhitespace }
            for c in answers {
                set.insert(c)
            }
            total.append(set.count)
        }
        
        return "\(total.reduce(0, +))"
        
    }

    override func part2() -> String {
        let groups = input.raw.components(separatedBy: "\n\n")

        var total = [Int]()
        for group in groups {
            let answers = group.split(separator: "\n")
            var sets = answers.map { Set($0) }
            let start = sets.removeFirst()
            let set = sets.reduce(start, {
                $0.intersection($1)
            })

            total.append(set.count)
        }
        
        return "\(total.reduce(0, +))"
    }
}
