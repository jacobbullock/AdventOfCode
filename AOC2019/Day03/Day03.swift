//
//  Day03.swift
//  AOC2019
//
//  Created by Jacob Bullock on 12/7/20.
//

import Foundation

class Day03: Day {
    enum Direction: String {
        case U, D, L, R
    }
    override var name: String { "03" }
    
    override func part1() -> String {
        var sets: [Set<String>] = []
        for lines in input.lines {
            let route = lines.components(separatedBy: ",")
            
            var x = 0
            var y = 0
            
            var set: Set<String> = []

            for element in route {
                let direction = element.prefix(1)
                let count = Int(element.dropFirst())!
                
                var xd = 0
                var yd = 0
                
                switch Direction(rawValue: String(direction))! {
                case .R:
                    xd = 1
                case .L:
                    xd = -1
                case .U:
                    yd = 1
                case .D:
                    yd = -1
                }
                
                for _ in 0...count-1 {
                    x += xd
                    y += yd
                    
                    let key = "\(x),\(y)"
                    set.insert(key)
                }
                
            }
            
            sets.append(set)
        }
        
        let result = sets[0].intersection(sets[1]).map { value -> Int in
            let k = value.components(separatedBy: ",").map { Int($0)! }
            return abs(k[0]) + abs(k[1])
        }.sorted().first!

        return "\(result)"
    }

    override func part2() -> String {
        var stepsHash = [[String: Int]]()
        var sets: [Set<String>] = []
        
        for lines in input.lines {
            let route = lines.components(separatedBy: ",")
            var routeStepsHash = [String: Int]()
            var steps = 0
            var x = 0
            var y = 0
            
            var set: Set<String> = []

            for element in route {
                let direction = element.prefix(1)
                let count = Int(element.dropFirst())!
                
                var xd = 0
                var yd = 0
                
                switch Direction(rawValue: String(direction))! {
                case .R:
                    xd = 1
                case .L:
                    xd = -1
                case .U:
                    yd = 1
                case .D:
                    yd = -1
                }
                
                for _ in 0...count-1 {
                    x += xd
                    y += yd
                    steps += 1
                    
                    let key = "\(x),\(y)"
                    set.insert(key)
                    
                    if routeStepsHash[key] == nil {
                        routeStepsHash[key] = steps
                    }
                }
            }
            sets.append(set)
            stepsHash.append(routeStepsHash)

        }
        
        let result = sets[0].intersection(sets[1]).map {
            stepsHash[0][$0]! + stepsHash[1][$0]!
        }.sorted().first!

        return "\(result)"
    }
}
