class Day06: Day {
    override var name: String { "06" }
    
    lazy var dailyInput: Grid<String> = {
        .init(from: input.raw)
    }()
    
    lazy var startingPoint: Point = {
        var p: Point = Point(x: 0, y: 0)
        dailyInput.traverse { x, y in
            if dailyInput.source[y][x] == "^" {
                p = Point(x: x, y: y)
            }
        }
        
        return p
    }()
    
    var visitedPart1: Set<Point> = []
    override func part1() -> String {
        // print(startingPoint)
        func move() -> Point {
            let p = curr.offset(by: direction)
            guard p.isInGrid(dailyInput) else {
                return p
            }
            let n = dailyInput.item(at: p)
            if n == "#" {
                direction = turnRight(from: direction)
                return move()
            }
            return p
        }
        
        var curr = startingPoint
        var direction = Point.Direction.up
        var running = true
        
        var visited: Set<Point> = [curr]
        var i = 0
        while running {
            curr = move()
            // print(i, curr)
            i += 1
            if !curr.isInGrid(dailyInput) {
                running = false
            } else {
                visited.insert(curr)
            }
                
        }
        visitedPart1 = visited
        return "\(visited.count)"
    }
    
    override func part2() -> String {
        var nodes: [Point] = []
        dailyInput.traverse { x, y in
            if dailyInput.source[y][x] == "." {
                let p = Point(x: x, y: y)
                if p != startingPoint {
                    nodes.append(p)
                }
            }
        }
        // print (nodes.count)
        
        var count = 0
        for node in nodes {
            if !visitedPart1.contains(node) {
                continue
            }
            var grid = dailyInput
            var visited: [Point: [Point.Direction]] = [:]
            grid.set("#", at: node)

   
            var curr = startingPoint
            var direction = Point.Direction.up
            var running = true
            
            while running {
                curr = move()
                if !curr.isInGrid(dailyInput) {
                    running = false
                } else {
                    if visited[curr]?.contains(direction) ?? false {
                        count += 1
                        running = false
                    } else {
                        visited[curr, default: []].append(direction)
                    }
                }
            }
            
            func move() -> Point {
                let p = curr.offset(by: direction)
                guard p.isInGrid(grid) else {
                    return p
                }
                let n = grid.item(at: p)
                if n == "#" {
                    direction = turnRight(from: direction)
                    return move()
                }
                return p
            }
        }
        
        return "\(count)"
    }
}

extension Day06 {
    
    func turnRight(from point: Point.Direction) -> Point.Direction {
        switch point {
        case .up: return .right
        case .right: return .down
        case .down: return .left
        case .left: return .up
        default: fatalError()
        }
    }
}
