class Day02: Day {
    override var name: String { "02" }

    enum Direction: String {
        case forward
        case down
        case up

        var increment: Point {
            switch self {
            case .forward: return Point(x: 1, y: 0)
            case .down: return Point(x: 0, y: 1)
            case .up: return Point(x: 0, y: -1)
            }
        }
    }
    
    override func part1() -> String {
        var position = Point.zero
        for line in input.lines {
            let components = line.components(separatedBy: " ")
            let direction = Direction(rawValue: components[0])!
            let value = Int(components[1])!
            let delta = direction.increment * value
            position += delta
        }
        let output = position.x * position.y
        return "\(output)"
    }

    override func part2() -> String {
        var position = Point.zero
        var aim = Point.zero
        for line in input.lines {
            let components = line.components(separatedBy: " ")
            let direction = Direction(rawValue: components[0])!
            let value = Int(components[1])!
            var delta = direction.increment * value

            switch direction {
            case .down, .up:
                aim = aim + delta
            case .forward:
                delta.y = delta.x * aim.y
                position += delta
            }
        }
        let output = position.x * position.y
        return "\(output)"
    }
}

extension Point {
    static func +=(lhs: inout Point, rhs: Point) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}
