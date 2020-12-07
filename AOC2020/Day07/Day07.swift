//
//  Day07.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/1/20.
//

import Foundation

class Day07: Day {
    override var name: String { "07" }
    
    lazy var rules: [String: [String: Int]] = {
        var node = [String: [String: Int]]()
        for line in input.lines {
            let comps = line.components(separatedBy: " contain ")
            var children = [String: Int]()
            
            let bags = comps[1].components(separatedBy: ", ")
            for bag in bags {
                var info = bag.components(separatedBy: " ")
                var count = Int(info.removeFirst())
                var key = String(info.joined(separator: " "))
                children[sanitize(key)] = count
            }
            node[sanitize(comps[0])] = children
        }
        
        return node
    }()
    
    func sanitize(_ str: String) -> String {
        return str.replacingOccurrences(of: " bags", with: "")
            .replacingOccurrences(of: " bag", with: "")
            .replacingOccurrences(of: ".", with: "")
    }
    
    override func part1() -> String {
        var b = true
        
        var result: Set<String> = []
        
        var search = ["shiny gold"]
        
        while b {
            var tier: [String] = []
            for term in search {
                
                tier = tier + rules.filter {
                    $0.value.keys.joined(separator: "--").contains(term)
                }.map { $0.key }
            }
            
            if tier.count == 0 {
                b = false
                break
            }
            
            tier.forEach {
                result.insert($0)
            }
            
            search = tier
            
        }
        return "\(result.count)"
    }
    
    func countBags(_ color: String) -> Int {
        var total = 0
        guard let bag = rules[color] else {
            return 0
        }
        
        for (col, count) in bag {
            total += count * (countBags(col) + 1)
        }
        
        
        return total
    }

    override func part2() -> String {
        let result = countBags("shiny gold")
        return "\(result)"
    }
}
