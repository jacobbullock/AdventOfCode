//
//  util.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/1/20.
//


func twoSum(source: [Int], target: Int) -> [Int] {
    var dict = [Int: Int]()

    for (index, element) in source.enumerated() {
        let pair = target - element
        if let _ = dict[pair] {
            return [element, pair]
        }
        dict[element] = index
    }

    return []
}

func threeSum(source: [Int], target: Int) -> [Int] {
    for i in source {
        let diff = target - i
        var result = twoSum(source: source, target: diff)
        guard result.count == 2 else { continue }
        result.append(i)
        return result
    }

    return []
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(range: ClosedRange<Int>) -> Character {
        let start = index(startIndex, offsetBy: range.lowerBound)
        return self[index(start, offsetBy: range.upperBound - range.lowerBound)]
    }
}

extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}

extension Point {
    enum Direction {
        case up
        case down
        case right
        case left
        case upLeft
        case upRight
        case downLeft
        case downRight
    }
}

struct Point: Hashable {
    var x: Int
    var y: Int
    
    static var zero: Point {
        return Point(x: 0, y: 0)
    }
    
    var manhattanDistance: Int {
        abs(x) + abs(y)
    }
    
    func offset(by direction: Direction) -> Point {
        switch direction {
        case .up: return Point(x: x, y: y - 1)
        case .down: return Point(x: x, y: y + 1)
        case .right: return Point(x: x + 1, y: y)
        case .left: return Point(x: x - 1, y: y)
        case .upLeft: return Point(x: x - 1, y: y - 1)
        case .upRight: return Point(x: x + 1, y: y - 1)
        case .downLeft: return Point(x: x - 1, y: y + 1)
        case .downRight: return Point(x: x + 1, y: y + 1)
        }
    }
    
    func surroundingPoints() -> [Point] {
        return [
            Point(x: x - 1, y: y), //left
            Point(x: x + 1, y: y), //right
            Point(x: x, y: y - 1), //top
            Point(x: x, y: y + 1), //bottom
            Point(x: x - 1, y: y - 1), //left / down
            Point(x: x - 1, y: y + 1), //left / up
            Point(x: x + 1, y: y + 1), //right / up
            Point(x: x + 1, y: y - 1), //right / down
        ].filter {
            $0.x >= 0 && $0.y >= 0
        }
        
    }
    
    func cornerPoints() -> [Point] {
        return [
            Point(x: x-1, y: y-1),  //left / down
            Point(x: x+1, y: y+1),  //right / up
            Point(x: x-1, y: y+1),  //left / up
            Point(x: x+1, y: y-1), //right /down
        ]
    }
    
    func surroundingIndicies() -> [Point] {
        return [
            Point(x: -1, y: 0), //left
            Point(x: 1, y: 0), //right
            Point(x: 0, y: -1), //top
            Point(x: 0, y: 1), //bottom
            Point(x: -1, y: -1), //left / down
            Point(x: -1, y: 1), //left / up
            Point(x: 1, y: 1), //right / up
            Point(x: 1, y: -1), //right / down
        ]
    }
    
    
    static func * (left: Point, right: Int) -> Point {
        return Point(x: left.x * right, y: left.y * right)
    }
    
    static func + (left: Point, right: Point) -> Point {
        return Point(x: left.x + right.x, y: left.y + right.y)
    }
    
    func isInGrid<T>(_ grid: Grid<T>) -> Bool {
        (x >= 0 && y >= 0) && (x < grid.width && y < grid.height)
    }
}

extension Sequence where Element: AdditiveArithmetic {
    var sum: Element { reduce(.zero, +) }
}

extension Sequence where Element: Numeric & Comparable {
    var product: Element { reduce(1, *) }
    
    func min(count: Int = 1) -> Element {
        Array(self.sorted(by: <).prefix(count)).sum
    }
    func max(count: Int = 1) -> Element {
        Array(self.sorted(by: >).prefix(count)).sum
    }
}

extension Array {
    func split() -> [[Element]] {
        let half = count / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< count]
        return [Array(leftSplit), Array(rightSplit)]
    }
}

extension Array where Element: Numeric & Comparable {
    func isIncreasing() -> Bool {
        for i in 1 ..< count {
            if self[i] < self[i - 1] {
                return false
            }
        }
        return true
    }
    
    func isDecreasing() -> Bool {
        for i in 1 ..< count {
            if self[i] > self[i - 1] {
                return false
            }
        }
        return true
    }
}

extension ClosedRange<Int> {
    func contains(_ range: ClosedRange<Int>) -> Bool {
        contains(range.lowerBound) && contains(range.upperBound)
    }
    
    func overlaps(_ range: ClosedRange<Int>) -> Bool {
        contains(range.lowerBound) || contains(range.upperBound)
    }
}

extension Point {
    static func +=(lhs: Self, rhs: Self) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}


struct Grid<T> {
    var source: [[T]]
    
    var width: Int { source[0].count }
    var height: Int { source.count }
    
    init(from string: String) {
        let source = string.components(separatedBy: .newlines).map {
            Array($0).map {
                String($0) as! T
            }
        }
        self.source = source
    }
    
    func traverse(action: (Int, Int) -> Void) {
        for y in 0..<width {
            for x in 0..<height {
                action(x, y)
            }
        }
    }
    
    func item(at point: Point) -> T {
        return source[point.y][point.x]
    }
    
    mutating func set(_ value: T, at point: Point) {
        source[point.y][point.x] = value
    }
}
