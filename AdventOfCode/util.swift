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
}

extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}

