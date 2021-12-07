class Day07: Day {
    override var name: String { "07" }

    override func part1() -> String {
        var totals: [Int: Int] = [:]
        var least: Int?
        for start in input.intArray {
            guard totals[start] == nil else { continue }

            var total = 0

            for pos in input.intArray {
                total += abs(pos - start)
            }

            if least == nil || total < totals[least!]! {
                least = start
            }

            totals[start] = total
        }
        return "\(totals[least!]!)"
    }

    func sum(of steps: Int) -> Int {
        return (steps * (steps + 1)) / 2
    }

    override func part2() -> String {
        var totals: [Int: Int] = [:]
        var least: Int?

        let a = input.intArray.sorted()
        let positions = a.first!...a.last!
        for start in positions {
            guard totals[start] == nil else { continue }

            var total = 0

            for pos in input.intArray {
                total += sum(of: abs(pos - start))
            }

            if least == nil || total < totals[least!]! {
                least = start
            }

            totals[start] = total
        }
        return "\(totals[least!]!)"
    }
}
