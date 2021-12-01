class Day01: Day {
    override var name: String { "01" }

    lazy var integers: [Int] = {
        return input.integers
    }()
    
    override func part1() -> String {
        var lastNum = integers.first!
        var count = 0
        for n in integers.dropFirst() {
            if n > lastNum {
                count += 1
            }
            lastNum = n
        }
        return "\(count)"
    }

    override func part2() -> String {
        var lastSum = integers[0...2].reduce(0, +)
        var count = 0
        for (index, _) in integers.enumerated() {
            guard index > 0 else { continue }
            guard index + 2 < integers.count else { break }
            let sum = lastSum - integers[index - 1] + integers[index + 2]
            if sum > lastSum {
                count += 1
            }
            lastSum = sum
        }
        return "\(count)"
    }
}
