class Day07: Day {
    override var name: String { "07" }
    
    lazy var dailyInput: [Calculation] = {
        input.lines.map {
            let comps = $0.components(separatedBy: ": ")
            return Calculation(total: Int(comps[0])!, nums: comps[1].components(separatedBy: " ").map { Int($0)! })
        }
    }()
    
    override func part1() -> String {
        let valid = dailyInput.map {
            $0.isValid(operations: ["+", "*"]) ? $0.total : 0
        }
        return "\(valid.sum)"
    }
    
    override func part2() -> String {
        let valid = dailyInput.map {
            $0.isValid(operations: ["+", "*", "||"]) ? $0.total : 0
        }
        return "\(valid.sum)"
    }
}

extension Day07 {
    struct Calculation {
        let total: Int
        let nums: [Int]
        
        func isValid(operations: [String]) -> Bool {
            var values: [Int] = []
 
            for i in 1..<nums.count {
                if i == 1 {
                    for operation in operations {
                        values.append(calculate(nums[0], nums[i], operation))
                    }
                } else {
                    let c = values.count
                    for j in 0..<c {
                        let curr = values[j]
                        if curr > total {
                            continue
                        } else {
                            values[j] = calculate(curr, nums[i], operations[0])
                            for op in 1..<operations.count {
                                values.append(calculate(curr, nums[i], operations[op]))
                            }
                        }
                    }
                }
            }
            return values.contains(total)
        }
        
        func calculate(_ a: Int, _ b: Int, _ operation: String) -> Int {
            switch operation {
            case "+": return a + b
            case "*": return a * b
            case "||": return Int(String(a) + String(b))!
            default: fatalError()
            }
        }
    }
}
