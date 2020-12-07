//
//  Day05.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/4/20.
//

import Foundation

class Day05: Day {
    
    
    enum Column: Character {
        case R = "R"
        case L = "L"
    }
    
    enum Row: Character {
        case F = "F"
        case B = "B"
    }
    
    override var name: String { "05" }
    
    var rowRange = 0...127
    var colRange = 0...7
    
    override func part1() -> String {
        return "\(seatIds.sorted().last!)"
    }

    override func part2() -> String {
        var ids: Set<Int> = []
        let seats = seatIds
        let high = seats.sorted().last!
        outerLoop: for r in 1...127 {
            for c in 0...(high/8) {
                let id = (r * 8) + c
                if id > high {
                    break outerLoop
                }
                ids.insert(id)
            }
        }
        
        let diff = ids.subtracting(Set(seats))

        for i in diff {
            if seats.contains(i+1) && seats.contains(i-1) {
                return "\(i)"
            }
        }

        return "Answer not found"
    }
    
    var seatIds: [Int] {
        var ids = [Int]()
        
        for line in input.lines {
            var seatRow = 0
            var seatCol = 0
            
            var seatRowRange = rowRange
            var seatColRange = colRange
            
            let columns = line.dropLast(3)
            let rows = line.dropFirst(7)
            
            for c in columns {
                
                let diff = seatRowRange.upperBound - seatRowRange.lowerBound
                let mid = seatRowRange.lowerBound + (diff / 2)
                
                switch Row(rawValue: c)! {
                case .F:
                    if diff == 1 {
                        seatRow = seatRowRange.lowerBound
                    } else {
                        seatRowRange = seatRowRange.lowerBound...mid
                    }
                    
                case .B:
                    if diff == 1 {
                        seatRow = seatRowRange.upperBound
                    } else {
                        seatRowRange = (mid+1)...seatRowRange.upperBound
                    }
                }
            }
            
            for r in rows {
                let diff = seatColRange.upperBound - seatColRange.lowerBound
                let mid = seatColRange.lowerBound + (diff / 2)
                
                switch Column(rawValue: r)! {
                case .L:
                    if diff == 1 {
                        seatCol = seatColRange.lowerBound
                    } else {
                        seatColRange = seatColRange.lowerBound...mid
                    }
                    
                case .R:
                    if diff == 1 {
                        seatCol = seatColRange.upperBound
                    } else {
                        seatColRange = (mid+1)...seatColRange.upperBound
                    }
                }
            }
            
            let id = (seatRow * 8) + seatCol
            
            ids.append(id)
//            if id > highestSeatId {
//                highestSeatId = id
//            }
        }
        
        return ids
    }
}



