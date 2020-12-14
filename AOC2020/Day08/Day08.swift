//
//  Day08.swift
//  AOC2020
//
//  Created by Jacob Bullock on 12/6/20.
//

import Foundation

class Day08: Day {
    
    enum Command: String {
        case acc, jmp, nop
    }
    override var name: String { "08" }
    
    override func part1() -> String {
        var indecies: Set<Int> = []
        
        var index = 0
        
        var running = true
        let lines = input.lines
        var accumulator = 0
        
        while running {
            if indecies.contains(index) || index == lines.count {
                running = false
                break
            }
            indecies.insert(index)
            let cmd = lines[index].components(separatedBy: " ")
            let op = cmd[0]
            let dir = cmd[1].prefix(1) == "+" ? 1 : -1
            let c = Int(cmd[1].dropFirst())!
            
            var jump = 1
            switch Command(rawValue: op)! {
            case .acc:
                accumulator += (dir * c)
            case .jmp:
                jump = (dir * c)
            case .nop:
                jump = 1
            }
            
            index += jump
        }
        return "\(accumulator)"
    }

    func runProgram(lines: [String]) -> (Bool, Int) {
        var indecies: Set<Int> = []
        
        var index = 0
        var accumulator = 0
        
        while true {
            if indecies.contains(index) {
                return (false, accumulator)
            }
            
            if index == lines.count {
                return (true, accumulator)
            }
            
            indecies.insert(index)
            let cmd = lines[index].components(separatedBy: " ")
            let op = cmd[0]
            let dir = cmd[1].prefix(1) == "+" ? 1 : -1
            let c = Int(cmd[1].dropFirst())!
            
            var jump = 1
            switch Command(rawValue: op)! {
            case .acc:
                accumulator += (dir * c)
            case .jmp:
                jump = (dir * c)
            case .nop:
                jump = 1
            }

            index += jump
        }
    }
    
    override func part2() -> String {
        
        var possibleChanges: [Int] = []
        var index = 0
        for line in input.lines {
            let cmd = line.components(separatedBy: " ")[0]
            
            if cmd == "jmp" || cmd == "nop" {
                possibleChanges.append(index)
            }
            index += 1
        }
        
        for index in possibleChanges {
            let cmd = input.lines[index].components(separatedBy: " ")
            
            var lines = input.lines
            
            if cmd[0] == "jmp" {
                lines[index] = ["nop", cmd[1]].joined(separator: " ")
            } else if cmd[0] == "nop" {
                lines[index] = ["jmp", cmd[1]].joined(separator: " ")
            }
            
            let result = runProgram(lines: lines)
            
            if result.0 {
                return "\(result.1)"
            }
        }
        
        return "error"
    }
}
