class Day07: Day {
    override var name: String { "07" }


    func median(of array: [Int]) -> Float {
        let sorted = array.sorted()
        if sorted.count % 2 == 0 {
            return Float((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
        } else {
            return Float(sorted[(sorted.count - 1) / 2])
        }
    }

    override func part1() -> String {
        let median = Int(median(of: input.intArray))

        let total = input.intArray.reduce(0) {
            $0 + abs(median - $1)
        }

        return "\(total)"
    }

    func sum(of steps: Int) -> Int {
        return (steps * (steps + 1)) / 2
    }

    override func part2() -> String {
        let average = input.intArray.reduce(0, +) / input.intArray.count

        let total = input.intArray.reduce(0) {
            $0 + sum(of: abs(average - $1))
        }

        return "\(total)"
    }
}
