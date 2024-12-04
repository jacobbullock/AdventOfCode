class Day04: Day {
    override var name: String { "04" }
    
    lazy var dailyInput: Grid<String> = {
        .init(from: input.raw)
    }()
    
    override func part1() -> String {
        var count = 0

        dailyInput.traverse { x, y in
            if dailyInput.source[y][x] == "X" {
                count += searchForXMAS(from: .init(x: x, y: y))
            }
        }
        
        return "\(count)"
    }
    
    override func part2() -> String {
        var count = 0

        dailyInput.traverse { x, y in
            if dailyInput.source[y][x] == "A" {
                count += searchForX(from: .init(x: x, y: y)) ? 1 : 0
            }
        }
        
        return "\(count)"
    }
}

extension Day04 {
    func searchForXMAS(from point: Point) -> Int {
        return point.surroundingIndicies().map {
            [point + $0, point + ($0 * 2), point + ($0 * 3)]
        }.filter {
            for p in $0 {
                guard p.isInGrid(dailyInput) else { return false }
            }
            return true
        }
        .map {
            $0.compactMap { dailyInput.source[$0.y][$0.x] }.joined()
        }.filter {
            $0 == "MAS"
        }.count
    }
    
    func searchForX(from point: Point) -> Bool {
        let cornerPoints = point.cornerPoints()
        
        let angle1 = [cornerPoints[0], cornerPoints[1]]
        let angle2 = [cornerPoints[2], cornerPoints[3]]
        
        return [angle1, angle2].map {
            $0.compactMap {
                guard $0.isInGrid(dailyInput) else { return nil }
                return dailyInput.source[$0.y][$0.x]
            }.joined()
        }
        .filter { $0 == "MS" || $0 == "SM" }
        .count == 2
    }
    
}

