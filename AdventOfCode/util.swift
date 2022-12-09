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

struct Point: Hashable {
    var x: Int
    var y: Int
    
    static var zero: Point {
        return Point(x: 0, y: 0)
    }
    
    var manhattanDistance: Int {
        abs(x) + abs(y)
    }
    
    static func * (left: Point, right: Int) -> Point {
        return Point(x: left.x * right, y: left.y * right)
    }
    
    static func + (left: Point, right: Point) -> Point {
        return Point(x: left.x + right.x, y: left.y + right.y)
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
