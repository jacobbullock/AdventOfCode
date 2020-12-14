//
//  Day04.swift
//  AOC2019
//
//  Created by Jacob Bullock on 12/7/20.
//

import Foundation

class Day04: Day {
    override var name: String { "04" }
    
    override func part1() -> String {
        let range = 256310...732736
        
        var count = 0
        for i in range {
            let a = String(i).map { Int("\($0)")! }
            var lastInt = -1
            var success = true
            var hash = [Int: Int]()
            
            for j in a {
                if j < lastInt {
                    success = false
                    break
                }
                
                if hash[j] == nil {
                    hash[j] = 1
                } else {
                    hash[j]! += 1
                }
                
                lastInt = j
            }
            
            let doublesFound = hash.filter {
                $0.value >= 2
            }.count > 0
            
            if success && doublesFound {
                count += 1
            }
        }
        
        return "\(count)"
    }
    
    override func part2() -> String {
        let range = 256310...732736
        
        var count = 0
        for i in range {
            let a = String(i).map { Int("\($0)")! }

            var lastInt = -1
            var success = true

            var hash = [Int: Int]()

            for j in a {
                if j < lastInt {
                    success = false
                    break
                }

                if hash[j] == nil {
                    hash[j] = 1
                } else {
                    hash[j]! += 1
                }

                lastInt = j
            }

            let doublesFound = hash.filter {
                $0.value == 2
            }.count > 0

            if success && doublesFound {
                count += 1
            }
        }
        
        return "\(count)"
    }
}
