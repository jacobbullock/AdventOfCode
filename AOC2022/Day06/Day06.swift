class Day06: Day {
    override var name: String { "06" }
    
    lazy var todaysInput: [Character] = {
        Array(input.raw)
    }()
    
    override func part1() -> String {
        return run(increment: 4)
    }
    
    override func part2() -> String {
        return run(increment: 14)
    }
    
    func run(increment: Int) -> String {
        var window: [Character: Int] = [:]
        for c in increment..<todaysInput.count {
            window[todaysInput[c], default: 0] += 1
            
            let first = c - increment
            let firstValue = todaysInput[first]
            if first >= 0 {
                window[firstValue, default: 0] -= 1
                if let count = window[firstValue], count <= 0 {
                    window[firstValue] = nil
                }
            }
            
            if window.keys.count == increment {
                return "\(c + 1)"
            }
        }

        return "failure"
    }
    
    // first attempt, works great, but not as efficient as a proper sliding window
    func run2(increment: Int) -> String {
        for c in 0..<todaysInput.count-increment {
            if Set(Array(todaysInput[c...(c+increment-1)])).count == increment {
                return "\(c+increment)"
            }
        }

        return "failure"
    }
}

