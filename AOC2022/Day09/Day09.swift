class Day09: Day {
    override var name: String { "09" }
    
    lazy var todaysInput: [[String]] = {
        input.lines.map {
            $0.components(separatedBy: " ")
        }
    }()
    
    override func part1() -> String {
        let result = run(knots: [Point](repeating: .zero, count: 2))
        return "\(result)"
    }
    
    override func part2() -> String {
        let result = run(knots: [Point](repeating: .zero, count: 10))
        return "\(result)"
    }
    
    func run(knots: [Point]) -> Int {
        var knots = knots
        var grid: [Point: Int] = [knots.first!: 1]
       
        for command in todaysInput {
            let n = Int(command[1])!
            let vector: Point
            switch command[0] {
            case "U": vector = Point(x:0, y:1)
            case "D": vector = Point(x:0, y:-1)
            case "R": vector = Point(x:1, y:0)
            case "L": vector = Point(x:-1, y:0)
            default: vector = Point(x:0, y:0)
            }

            for _ in 0..<n {
                for i in 0..<knots.count {
                    if i == 0 {
                        knots[i] = knots[i] + vector
                        continue
                    }
                    
                    let dx = knots[i-1].x - knots[i].x
                    let dy = knots[i-1].y - knots[i].y
                    if dx == 0 && abs(dy) > 1 {
                        knots[i].y += (dy / abs(dy))
                    } else if abs(dx) > 1 && dy == 0 {
                        knots[i].x += (dx / abs(dx))
                    } else if abs(dx) > 1 || abs(dy) > 1 {
                        knots[i].y += (dy / abs(dy))
                        knots[i].x += (dx / abs(dx))
                    }
                    
                    if i == knots.count - 1 {
                        grid[knots[i], default: 0] += 1
                    }
                }
                
            }
        }
        
        return grid.keys.count
    }
}
