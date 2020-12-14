//
//  Day11.swift
//  AOC2020
//
//  Created by Jacob Bullock on 12/10/20.
//

import Foundation

class Day11: Day {
    override var name: String { "11" }
    
    var adjIndecies = [ [-1, -1], [0, -1], [1, -1],
                        [-1, 0], [1, 0],
                        [-1, 1], [0, 1], [1, 1] ]
    
    lazy var startGrid: [String: Character] = {
        var d = [String: Character]()
        
        var x = 0
        var y = 0
        for line in input.lines {
            
            x = 0
            
            for c in line {
                d["\(x)_\(y)"] = c
                
                x += 1
            }
            
            y += 1
        }
        
        return d
    }()
    
    override func part1() -> String {
        var grid  = startGrid
        
        var updatedGrid = grid
        
        var round = 0
        var changes = false

        while true {
            if !changes && round != 0 {
                print("round: \(round)")
                let result = updatedGrid.filter {
                    $0.value == "#"
                }.count
                return "\(result)"
            } else {
                if round != 0 {
                    grid = updatedGrid
                }
                changes = false
            }
        
            var x = 0
            var y = 0
            
            for line in input.lines {
                x = 0
                
                for _ in line {
                    
                    let key = "\(x)_\(y)"
                    let current = grid[key]
                    
                    if current == "." {
                        x += 1
                        continue
                    }
                    
                    var adjacentOccupied = 0
                    
                    for i in adjIndecies {
                        let xx = x + i[0]
                        let yy = y + i[1]
                        
                        let kk = "\(xx)_\(yy)"
                        
                        if grid[kk] == "#" {
                            adjacentOccupied += 1
                        }
                    }
                    
                    if current == "L" {
                        if adjacentOccupied == 0 {
                            updatedGrid[key] = "#"
                            changes = true
                        }
                    } else if current == "#" {
                        if adjacentOccupied >= 4 {
                            updatedGrid[key] = "L"
                            changes = true
                        }
                    }

                    x += 1
                }
                
                y += 1
            }
            
            round += 1
            
        }
    }
    
    override func part2() -> String {
        var grid  = startGrid
        
        var updatedGrid = grid
        
        var round = 0
        var changes = false
        
        var firstSeats = [String: [(Int, Int)]]()

        while true {
            print("round: \(round)")
            if !changes && round != 0 {
                print("round: \(round)")
                let result = updatedGrid.filter {
                    $0.value == "#"
                }.count
                return "\(result)"
            } else {
                if round != 0 {
                    grid = updatedGrid
                }
                changes = false
            }
        
            var x = 0
            var y = 0
            
            for line in input.lines {
                x = 0
                
                for _ in line {
                    
                    let key = "\(x)_\(y)"
                    let current = grid[key]
                    
                    if current == "." {
                        x += 1
                        continue
                    }
                    
                    if firstSeats[key] == nil {
                        var seats = [(Int, Int)]()
                        for i in adjIndecies {
                            var foundSeat = false
                            var step = 1
                            while !foundSeat {
                                let xx = x + (i[0] * step)
                                let yy = y + (i[1] * step)
                                
                                if (xx < 0 || yy < 0 || xx >= line.count || yy >= input.lines.count) {
                                    foundSeat = true
                                    break
                                }
                                
                                let kk = "\(xx)_\(yy)"
                                
                                if grid[kk] != "." {
                                    seats.append((xx, yy))
                                    foundSeat = true
                                }
                                
                                step += 1
                            }
                            
                        }
                        
                        firstSeats[key] = seats
                        
                        //print(firstSeats)
                    }
                    
                    //print(firstSeats)
                    
                    var adjacentOccupied = 0
                    
                    for i in firstSeats[key]! {
                        let kk = "\(i.0)_\(i.1)"
                        
                        if grid[kk] == "#" {
                            adjacentOccupied += 1
                        }
                    }
                    
                    if current == "L" {
                        if adjacentOccupied == 0 {
                            updatedGrid[key] = "#"
                            changes = true
                        }
                    } else if current == "#" {
                        if adjacentOccupied >= 5 {
                            updatedGrid[key] = "L"
                            changes = true
                        }
                    }

                    x += 1
                }
                
                y += 1
            }
            
            round += 1
            
        }
    }
}
