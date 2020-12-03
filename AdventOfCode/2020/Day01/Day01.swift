//
//  Day1.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/1/20.
//

import Foundation

class Day01: Day {
    override var name: String { "01" }
    
    override func part1() -> String {
        let result = twoSum(source: inp.integers, target: 2020)
        return "\(result.reduce(1, *))"
    }

    override func part2() -> String {
        let result = threeSum(source: inp.integers.sorted(), target: 2020)
        return "\(result.reduce(1, *))"
    }
}
