//
//  Day02.swift
//  AOC2019
//
//  Created by Jacob Bullock on 12/7/20.
//

import Foundation

class Day02: Day {
    override var name: String { "02" }
    
    class IntCode {
        var source: [Int]
        var code: [Int] = []
        
        init(source: [Int]) {
            self.source = source
        }
        
        func reset(noun: Int, verb: Int) {
            code = source
            code[1] = noun
            code[2] = verb
        }
        
        func run(noun: Int = 12, verb: Int = 2) -> Int {
            reset(noun: noun, verb: verb)
            
            var running = true
            var index = 0
            while running {
                let opcode = code[index]
                var p: Array<Int> = []
                
                switch opcode {
                case 99:
                    running = false
                case 1:
                    p = Array(code[index+1...index+3])
                    code[p[2]] = code[p[0]] + code[p[1]]
                case 2:
                    p = Array(code[index+1...index+3])
                    code[p[2]] = code[p[0]] * code[p[1]]
                default:
                    print("error")
                }
                
                index += p.count + 1
            }
            
            return code[0]
        }
    }
    
    override func part1() -> String {
        let computer = IntCode(source: input.intArray)
        return "\(computer.run())"
    }

    override func part2() -> String {
        let computer = IntCode(source: input.intArray)
        
        for i in 0...99 {
            for j in 0...99 {
                let result = computer.run(noun: i, verb: j)
                if result == 19690720 {
                    return "\((100 * i) + j)"
                }
            }
        }
        return "error"
    }
}
