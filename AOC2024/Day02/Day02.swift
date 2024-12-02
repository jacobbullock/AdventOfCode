class Day02: Day {
    override var name: String { "02" }
    
    lazy var dailyInput: [[Int]] = {
        input.lines.map {
            $0.components(separatedBy: " ").map { Int($0)! }
        }
    }()
    
    override func part1() -> String {
        let count = dailyInput.compactMap {
            isSafe($0) ? 1 : nil
        }.count

        return "\(count)"
    }
    
    override func part2() -> String {
        let count = dailyInput.compactMap {
            isSafe($0) ? 1 : {
                for i in 0..<$0.count {
                    var line = $0
                    line.remove(at: i)
                    
                    if isSafe(line) {
                        return 1
                    }
                }
                return nil
            }($0)
        }.count
        
        return "\(count)"
    }
    
    private func isSafe(_ line: [Int]) -> Bool {
        guard line.isIncreasing() || line.isDecreasing() else { return false }

        for i in 1 ..< line.count {
            if !(1...3).contains(abs(line[i] - line[i - 1])) {
                return false
            }
        }

        return true
    }
}

