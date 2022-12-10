//
//  Day.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/1/20.
//

import Foundation

class Day {
    static var year: String = ""
    var name: String { "" }
    
    var start: CFTimeInterval!
    var runtime: CFTimeInterval {
        CFAbsoluteTimeGetCurrent() - start
    }
    
    var input: Input!
    
    init() {
        let base = URL(fileURLWithPath: "\(#file)").deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
        let file = base.appendingPathComponent("AOC\(Day.year)/Day\(name)/input.txt").path
        input = Input(file: file)
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
    
    func runWithoutLogging() {
        start = CFAbsoluteTimeGetCurrent()
        _ = part1()
        Year.elapsedTime += runtime

        start = CFAbsoluteTimeGetCurrent()
        _ = part2()
        Year.elapsedTime += runtime
    }
}
