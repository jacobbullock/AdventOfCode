//
//  Day09.swift
//  AOC2020
//
//  Created by Jacob Bullock on 12/8/20.
//

import Foundation

class Day09: Day {
    override var name: String { "09" }
    
    override func part1() -> String {
        
        let len = 25
        var index = len
        var digits = Array(input.integers[0..<len])

        var running = true
        
        while running {
            
            if index == input.integers.count {
                running = false
                break
            }
            
            let target = input.integers[index]
            let result = twoSum(source: digits, target: target)
            
            if result.count == 0 {
                return "\(target)"
            }
            
            index += 1
            let s = index - len
            digits = Array(input.integers[s..<(s+len)])
            
            
        }
        
        return "error"
    }
    
    override func part2() -> String {
        let target = 1930745883
        
        var index = 1
        
        let length = input.integers.count
        for _ in input.integers {
            var nums: [Int] = []
            var count = input.integers[index - 1]
            
            for j in Array(input.integers[index..<length]) {
                count += j
                nums.append(j)
            
                if count == target {
                    nums.sort()
                    print(nums)
                    return "\(nums.first! + nums.last!)"
                }
            }
            
            index += 1
        }
        
        return "error"
    }
}
