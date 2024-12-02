class Day01: Day {
    override var name: String { "01" }
    
    lazy var dailyInput: [[Int]] = {
        var pairs: [[Int]] = [[], []]
        
        for line in input.lines {
            let comps = line.components(separatedBy: "   ").map {
                Int($0)!
            }
            pairs[0].append(comps[0])
            pairs[1].append(comps[1])
        }
        
        return pairs
    }()

    override func part1() -> String {
        let pairs = dailyInput.map {
            $0.sorted()
        }
        
        let ls = pairs[0]
        let rs = pairs[1]

        var diff = 0
        
        for i in 0..<ls.count {
            diff += abs(ls[i] - rs[i])
        }

        return "\(diff)"
    }
    
    override func part2() -> String {
        let ls = dailyInput[0]
        let rs = dailyInput[1]
        
        var counts = [Int: Int]()
        
        for n in rs {
            counts[n, default: 0] += 1
        }
        
        var similar: Int = 0
        for n in ls {
            similar += n * (counts[n, default: 0])
        }
        
        return "\(similar)"
    }
}

