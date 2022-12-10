class Day10: Day {
    override var name: String { "10" }
    
    override func part1() -> String {
        var targets = [20, 60, 100, 140, 180, 220]
        var total = 0
        var cycle = 0
        var x = 1
        lineLoop: for line in input.lines {
            let components = line.components(separatedBy: " ")
            switch components[0] {
            case "addx":
                cycle += 2
                if let target = targets.first,
                   cycle >= target {
                    total += target * x
                    targets.removeFirst()
                    
                    if targets.isEmpty {
                        break lineLoop
                    }
                }
                x += Int(components[1])!
            default: cycle += 1
            }
        }
        
        return "\(total)"
    }
    
    override func part2() -> String {
        var crt = ""
        var cycle = 0
        var x = 1
        
        for line in input.lines {
            let components = line.components(separatedBy: " ")
            let cycles: Int
            let increment: Int
            switch components[0] {
            case "addx":
                cycles = 2
                increment = Int(components[1])!
            default:
                cycles = 1
                increment = 0
            }
            
            for _ in 0..<cycles {
                if abs(x-cycle) <= 1 {
                    crt += "#"
                } else {
                    crt += "."
                }
                
                cycle += 1
   
                if cycle % 40 == 0 {
                    cycle = 0
                    crt += "\n"
                }
            }
            
            x += increment
        }
        return "\n\(crt)"
    }
}

