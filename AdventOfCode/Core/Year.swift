//
//  Year.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/1/20.
//

import Foundation

struct Year {
    static var elapsedTime: CFTimeInterval = 0
    
    var name: String = "2020"
    var days = [Day01(), Day02(), Day03(), Day04(), Day05()]

    func run() {
        print("running year: \(name)")
        for day in days {
            day.run()
        }
        print("total time: \(Year.elapsedTime)")
    }
}
