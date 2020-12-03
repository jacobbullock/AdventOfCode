//
//  Day.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/1/20.
//

import Foundation

class Day {
    var name: String { "" }
    
    var start: CFTimeInterval!
    var runtime: CFTimeInterval {
        CFAbsoluteTimeGetCurrent() - start
    }
    
    var inp: Input!
    
    init() {
        let base = URL(fileURLWithPath: "\(#file)").deletingLastPathComponent().deletingLastPathComponent()
        let file = base.appendingPathComponent("2020/Day\(name)/input.txt").path
        inp = Input(file: file)
    }

    func part1() -> String {
        return "need to implement"
    }

    func part2() -> String {
       return "need to implement"
    }

    func run() {
        print("running day: \(name)")

        start = CFAbsoluteTimeGetCurrent()
        print("\tpart 1:", part1())
        print("\t ", runtime)
        Year.elapsedTime += runtime

        start = CFAbsoluteTimeGetCurrent()
        print("\tpart 2:", part2())
        print("\t ", runtime)
        Year.elapsedTime += runtime
    }
}
