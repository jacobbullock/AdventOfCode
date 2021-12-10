class Day10: Day {
    override var name: String { "10" }

    lazy var linesOfCharacters: [[String]] = {
        input.lines.map {
            Array($0).map {
                String($0)
            }
        }
    }()

    let opens = ["(", "[", "{", "<"]
    let closes = [")", "]", "}", ">"]
    let lookupOpen: [String: Int] = ["(":0, "[": 1, "{": 2, "<":3]
    let lookupClosed: [String: Int] = [")":0, "]": 1, "}": 2, ">":3]


    override func part1() -> String {
        let points: [String: Int] = [")": 3, "]": 57, "}": 1197, ">":25137]

        var errors: [String] = []
        for line in linesOfCharacters {
            var stack: [String] = []
            for c in line {
                if opens.contains(c) {
                    stack.append(c)
                }

                if closes.contains(c) {
                    if stack.isEmpty {
                        errors.append(c)
                    }

                    if stack.last! != opens[lookupClosed[c]!] {
                        errors.append(c)
                        break
                    } else {
                        stack.removeLast()
                    }
                }

            }
        }
        print(errors)
        let total = errors.reduce(0) {
            $0 + points[$1]!
        }
        return "\(total)"
    }

    override func part2() -> String {

        var incompletes: [[String]] = []
        let points: [String: Int] = ["(": 1, "[": 2, "{": 3, "<":4]

        for line in linesOfCharacters {
            var stack: [String] = []
            var incomplete: [String] = []
            var skip = false
            for c in line {
                if opens.contains(c) {
                    stack.append(c)
                }

                if closes.contains(c) {
                    if stack.isEmpty {
                        skip = true
                        break
                    }

                    if stack.last! != opens[closes.firstIndex(of: c)!] {
                        skip = true
                        break
                    } else {
                        stack.removeLast()
                    }
                }
            }

            if !skip {
                for s in stack.reversed() {
                    incomplete.append(s)
                }
                incompletes.append(incomplete)
            }

        }

        let totals = incompletes.map {
            $0.reduce(0) {
                ($0 * 5) + points[$1]!
            }
        }
        let midIndex = totals.count / 2
        return "\(totals.sorted()[midIndex])"
    }
}
