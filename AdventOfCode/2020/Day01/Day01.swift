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
        let result = twoSum(source: input.integers, target: 2020)
        return "\(result.reduce(1, *))"
    }

    override func part2() -> String {
        let result = threeSum(source: input.integers.sorted(), target: 2020)
        return "\(result.reduce(1, *))"
    }
}
