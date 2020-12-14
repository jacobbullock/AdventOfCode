//
//  Day13.swift
//  AOC2020
//
//  Created by Jacob Bullock on 12/13/20.
//

import Foundation

class Day13: Day {
    override var name: String { "13" }
    
    override func part1() -> String {
        let timestamp = Int(input.lines[0])!
        let startTimes = input.lines[1].components(separatedBy: ",").filter { $0 != "x" }.map { Int($0)! }
        
        let times = startTimes.map {
            ($0, Int( ceil( Double(timestamp) / Double($0)) ) * $0)
        }

        let nearest = times.sorted {
            $0.1 < $1.1
        }.first!
        
        return "\((nearest.1 - timestamp) * nearest.0)"
    }

    override func part2() -> String {
        let ids = input.lines[1].components(separatedBy: ",")
        
        var offset = 0
        var data = ids.compactMap { s -> (Int, Int)? in
            let r: (Int, Int)? = s == "x" ? nil : (Int(s)!, offset)
            offset += 1
            return r
        }
        
        let start = data.removeFirst()
        var increment = start.0
        var t = start.0
        
        var loops = 1
        var increments: [Int: [Int]] = [:]
        
        print("")
        print("increment: \(increment)")
        
        while true {
            var correct = true
            
            var bussesFound = [Int]()
            
            for bus in data {
                let target = t + bus.1

                if target >= bus.0 && target % bus.0 == 0 {
                    if increments[bus.0] == nil {
                        increments[bus.0] = [loops]
                    } else if increments[bus.0]!.count == 1 {
                        
                        let d = loops - increments[bus.0]![0]
                        increments[bus.0]!.append(d)
                        
                        bussesFound.append(bus.0)
                    }
                } else {
                    correct = false
                }
            }
            
            if correct {
                print("")
                print("num loops: \(loops)")
                print("increment: \(increment)")
                return "\(t)"
            }
            
            if increments.filter({ $0.value.count == 2 }).count == data.count {
                //print("all buses found: \(increments)")

                let highest = increments[bussesFound.first!]![1]
                
                increment = increment * highest
                
                increments = [:]
                
                print("increment: \(increment) :: \(loops)")
            }

            t += increment
            loops += 1
        }
    }
}
