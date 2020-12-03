//
//  Day03.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/2/20.
//

import Foundation

//
//  Day02.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/2/20.
//

import Foundation

class Day03: Day {
    override var name: String { "03" }

    override func part1() -> String {
        let hits = helper(right: 3, down: 1)
        return "\(hits)"
    }

    override func part2() -> String {
        var hits = [Int]()
        hits.append(helper(right: 1, down: 1))
        hits.append(helper(right: 3, down: 1))
        hits.append(helper(right: 5, down: 1))
        hits.append(helper(right: 7, down: 1))
        hits.append(helper(right: 1, down: 2))
        return "\(hits.reduce(1, *))"
    }
    
    func helper(right: Int, down: Int) -> Int {
        let lines = input.lines
        var hits = 0
        var x = right
        for i in stride(from: down, to: lines.count - 1, by: down) {
            let line = lines[i]
            let c = line[x % line.count]
            if c == "#" {
                hits += 1
            }
            x += right
        }
        return hits
    }
}



