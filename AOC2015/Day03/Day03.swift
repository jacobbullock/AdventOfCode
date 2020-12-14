//
//  Day03.swift
//  AOC2015
//
//  Created by Jacob Bullock on 12/11/20.
//

import Foundation

class Day03: Day {
    override var name: String { "03" }
    
   
    override func part1() -> String {
        
        var points: Set<Point> = []
        var curr = Point.zero
        
        points.insert(curr)
        for c in input.raw {
            //">^v<"
            
            switch c {
            case ">":
                curr.x += 1
            case "<":
                curr.x -= 1
            case "^":
                curr.y += 1
            case "v":
                curr.y -= 1
            default:
                { }()
            }
            
            points.insert(curr)
        }
        return "\(points.count)"
    }
    
    override func part2() -> String {
        var santaPoints: Set<Point> = []
        var roboPoints: Set<Point> = []
        
        var santaCurr = Point.zero
        var roboCurr = Point.zero
        
        santaPoints.insert(santaCurr)
        roboPoints.insert(roboCurr)
        
        var santa = true
        
        for c in input.raw {
            var curr = santa ? santaCurr : roboCurr
            
            switch c {
            case ">":
                curr.x += 1
            case "<":
                curr.x -= 1
            case "^":
                curr.y += 1
            case "v":
                curr.y -= 1
            default:
                { }()
            }
            
            if santa {
                santaPoints.insert(curr)
                santaCurr = curr
            } else {
                roboPoints.insert(curr)
                roboCurr = curr
            }
            
            santa = !santa
           
        }
        return "\(santaPoints.union(roboPoints).count)"
    }
}
