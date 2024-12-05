class Day05: Day {
    override var name: String { "05" }
    
    lazy var dailyInput: (rules: [Int: Set<Int>], updates: [[Int]]) = {
        let parts = input.raw.split(separator: "\n\n")
        
        var rules: [Int: Set<Int>] = [:]
        parts[0].components(separatedBy: .newlines).forEach {
            let comps = $0.split(separator: "|")
            let a = Int(String(comps[0]))!
            let b = Int(String(comps[1]))!
            rules[a, default: Set<Int>()].insert( b )
        }
        
        let updates = parts[1].components(separatedBy: .newlines).map {
            $0.components(separatedBy: ",").map { Int($0)! }
        }
        
        return (rules: rules, updates: updates)
    }()
    
    var badUpdates: [[Int]] = []

    override func part1() -> String {
        var values: [Int] = []
        for update in dailyInput.updates {
            let reversed = Array(update.reversed())
            var isCorrect = true
            for i in 0..<reversed.count {
                let slice = Set(reversed.suffix(from: i + 1))

                guard let rules = dailyInput.rules[reversed[i]] else {
                    continue
                }

                if rules.intersection(slice).count > 0 {
                    isCorrect = false
                    break
                }
            }
            
            if isCorrect {
                values.append(update[(update.count / 2)])
            } else {
                badUpdates.append(update)
            }
        }
    
        return "\(values.sum)"
    }
    
    override func part2() -> String {
        let value = badUpdates.map {
            $0.sorted {
                dailyInput.rules[$0]?.contains($1) ?? false
            }
        }.map {
            $0[($0.count / 2)]
        }
        .sum

        return "\(value)"
    }
}

