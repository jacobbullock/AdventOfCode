class Day03: Day {
    override var name: String { "03" }
    
    override func part1() -> String {
        let lines = input.lines
        let count = lines[0].count

        var counts: [[Character: Int]] = []
        for _ in 0..<count {
            counts.append(["0": 0, "1": 0])
        }

        var index = 0

        let combined = lines.joined(separator: "")
        for c in combined {
            counts[index][c] = counts[index][c]! + 1
            index += 1
            if index == count {
                index = 0
            }
        }

        var gamma = ""
        var epsilon = ""

        for d in counts {
            if d["0"]! > d["1"]! {
                gamma += "0"
                epsilon += "1"
            } else {
                gamma += "1"
                epsilon += "0"
            }
        }

        let g = Int(gamma, radix: 2)!
        let e = Int(epsilon, radix: 2)!

        return "\(g * e)"
    }

    func mostCommon(i: Int, count: Int, combined: String, useLeast: Bool, tied: Character) -> Character {
        var counts: [Character: Int] = ["0": 0, "1": 0]
        for c in stride(from: i, to: combined.count, by: count) {
            counts[combined[c]] = counts[combined[c]]! + 1
        }

        if counts["0"]! == counts["1"]! {
            return tied
        } else if  counts["0"]! > counts["1"]! {
            return useLeast ? "1" : "0"
        } else {
            return useLeast ? "0" : "1"
        }
    }

    override func part2() -> String {

        var linesA = input.lines
        var linesB = input.lines
        let count = linesA[0].count

        var counts: [[Character: Int]] = []
        for _ in 0..<count {
            counts.append(["0": 0, "1": 0])
        }

        for i in 0..<count {
            if linesA.count > 1 {
                let combinedA = linesA.joined(separator: "")
                let commonA = mostCommon(i: i, count: count, combined: combinedA, useLeast: false, tied: "1")
                linesA = linesA.filter {
                    let index = $0.index($0.startIndex, offsetBy: i)
                    return $0[index] == commonA
                }
            }

            if linesB.count > 1 {
                let combinedB = linesB.joined(separator: "")
                let commonB = mostCommon(i: i, count: count, combined: combinedB, useLeast: true, tied: "0")
                linesB = linesB.filter {
                    let index = $0.index($0.startIndex, offsetBy: i)
                    return $0[index] == commonB
                }
            }
        }

        let a = Int(linesA[0], radix: 2)!
        let b = Int(linesB[0], radix: 2)!

        return "\(a * b)"
    }
}
