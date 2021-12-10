class Day09: Day {
    override var name: String { "09" }

    lazy var linesOfCharacters: [[Int]] = {
        input.lines.map {
            Array($0).map {
                Int(String($0))!
            }
        }
    }()

    
    override func part1() -> String {
        let lowPoints = getLowPoints()
        let total = lowPoints.reduce(0, +) + lowPoints.count
        return "\(total)"
    }

    func getLowPoints() -> [Int] {
        var lowPoints: [Int] = []

        var currentLine = 0
        for line in linesOfCharacters {
            var index = 0
            for c in line {
                let a = getAdjacents(start: Point(x: index, y: currentLine))

                var isLowPoint = true
                for i in a {
                    if c >= i {
                        isLowPoint = false
                        break
                    }
                }

                if isLowPoint {
                    lowPoints.append(c)
                }

                index += 1
            }
            currentLine += 1
        }
        //print(lowPoints)

        return lowPoints
    }

    func getLowPointByIndex() -> [Point] {
        var lowPoints: [Point] = []

        var currentLine = 0
        for line in linesOfCharacters {
            var index = 0
            for c in line {
                let a = getAdjacents(start: Point(x: index, y: currentLine))

                var isLowPoint = true
                for i in a {
                    if c >= i {
                        isLowPoint = false
                        break
                    }
                }

                if isLowPoint {
                    lowPoints.append(Point(x: index, y: currentLine))
                }

                index += 1
            }
            currentLine += 1
        }
        //print(lowPoints)

        return lowPoints
    }

    func getAdjacents(start: Point) -> [Int] {
        let lineLen = input.lines[0].count
        let lineCount = input.lines.count

        var a: [Int] = []
        if start.x > 0 {
            a.append(linesOfCharacters[start.y][start.x-1])
        }

        if start.x < lineLen - 1 {
            a.append(linesOfCharacters[start.y][start.x+1])
        }

        if start.y > 0 {
            a.append(linesOfCharacters[start.y-1][start.x])
        }

        if start.y < lineCount - 1 {
            a.append(linesOfCharacters[start.y+1][start.x])
        }

        return a
    }

    func getAdjacentsWithIndex(start: Point) -> [(Point, Int)] {
        let lineLen = input.lines[0].count
        let lineCount = input.lines.count

        var a: [(Point, Int)] = []
        if start.x > 0 {
            a.append((Point(x: start.x - 1, y: start.y), linesOfCharacters[start.y][start.x-1]))
        }

        if start.x < lineLen - 1 {
            a.append((Point(x: start.x + 1, y: start.y), linesOfCharacters[start.y][start.x+1]))
        }

        if start.y > 0 {
            a.append((Point(x: start.x, y: start.y - 1), linesOfCharacters[start.y-1][start.x]))
        }

        if start.y < lineCount - 1 {
            a.append((Point(x: start.x, y: start.y + 1), linesOfCharacters[start.y+1][start.x]))
        }

        return a
    }

    override func part2() -> String {
        var basins: [Int] = []
        for point in getLowPointByIndex() {
            var points = Set<Point>()
            var open = [point]
            while open.isEmpty == false {
                let next = open.removeFirst()
                points.insert(next)
                let a = getAdjacentsWithIndex(start: next)
                for i in a {
                    if i.1 < 9, points.contains(i.0) == false {
                        open.append(i.0)
                    }
                }
            }

            basins.append(points.count)
        }
        let sizes = basins.sorted(by: >)
        let total = sizes.prefix(3).reduce(1, *)
        return "\(total)"
    }
}
