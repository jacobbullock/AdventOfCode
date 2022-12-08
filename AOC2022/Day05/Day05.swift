import Foundation

class Day05: Day {
    override var name: String { "05" }
    
    lazy var grid: [[Character]] = {
        let sections = input.raw.components(separatedBy: "\n\n")
        let lines: Array<String> = { sections[0].components(separatedBy: .newlines) }().dropLast()
        
        var items: [[Character]] = []
        
        let columnns = (lines[0].count) / 4

        for _ in 0...columnns {
            items.append([])
        }
        
        for line in lines {
            var i = 0
            for c in stride(from: 0, to: lines[0].count, by: 4) {
                if line[c] == "[" {
                    items[i].append(line[c+1])
                }
                
                i += 1
            }
        }
        
        return items
    }()
    
    lazy var commands: [[Int]] = {
        let sections = input.raw.components(separatedBy: "\n\n")
        let lines: Array<String> = { sections[1].components(separatedBy: .newlines) }()
        
        var commands: [[Int]] = []
        for line in lines {
            let regex = try! NSRegularExpression(pattern: #"move (\d+) from (\d+) to (\d+)"#)
            let fullRange = NSRange(line.startIndex..<line.endIndex, in: line)
            let results = regex.matches(in: line, range: fullRange)

            let match = results.first!
            //let result = results.map { match in
                var list: [Int] = []
                for rangeIndex in 0..<match.numberOfRanges {
                    let matchRange = match.range(at: rangeIndex)

                    guard matchRange != fullRange else { continue }

                    if let substringRange = Range(matchRange, in: line) {
                        list.append(Int(line[substringRange])!)
                    }
                }
                
            //}
            commands.append(list)
            
//            let component = line.components(separatedBy: .decimalDigits.inverted)
//            let list = component.filter({ $0 != "" }).map { Int($0)! }
//            commands.append(list)
        }
        
        return commands
    }()
    
    override func part1() -> String {
        var currentGrid = grid
        for command in commands {
            let source = command[1]-1
            let destination = command[2]-1
            let num = command[0]
            let moving = Array(currentGrid[source].prefix(num))
            currentGrid[source].removeFirst(num)
            currentGrid[destination] = moving.reversed() + currentGrid[destination]
        }
        let result = currentGrid.map { String($0.first!) }.joined(separator: "")
        return "\(result)"
    }
    
    override func part2() -> String {
        var currentGrid = grid
        for command in commands {
            let source = command[1]-1
            let destination = command[2]-1
            let num = command[0]
            let moving = Array(currentGrid[source].prefix(num))
            currentGrid[source].removeFirst(num)
            currentGrid[destination] = moving + currentGrid[destination]
        }
        let result = currentGrid.map { String($0.first!) }.joined(separator: "")
        return "\(result)"
    }
}

