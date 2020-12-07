//
//  Year.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/1/20.
//

import Foundation

struct Year {
    static var elapsedTime: CFTimeInterval = 0
    
    var name: String { "\(year)" }
    var year: Int
    var days: [Day]

    init(_ year: Int, _ days: [Day] = []) {
        self.year = year
        self.days = days
    }
    
    func run() {
        print("running year: \(name)")
        for day in days {
            day.run()
        }
        print("total time: \(Year.elapsedTime)")
    }
}
