//
//  Day01.swift
//  AOC2019
//
//  Created by Jacob Bullock on 12/6/20.
//

import Foundation

class Day01: Day {
    override var name: String { "01" }
    
    override func part1() -> String {
        var total = 0
        for mass in input.integers {
            total += (mass / 3) - 2
        }
        
        return "\(total)"
    }

    override func part2() -> String {
        var total = 0
        for mass in input.integers {
            var fuel = (mass / 3) - 2
            total += fuel
            while fuel > 0 {
                fuel = (fuel / 3) - 2
                if fuel > 0 {
                    total += fuel
                }
            }
            
        }
        
        return "\(total)"
    }
}


/*
 For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
 For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
 For a mass of 1969, the fuel required is 654.
 For a mass of 100756, the fuel required is 33583.
 */
