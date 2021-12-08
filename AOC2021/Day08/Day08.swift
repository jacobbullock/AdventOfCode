class Day08: Day {
    override var name: String { "08" }

    lazy var outputs: [[String]] = {
        input.lines.map {
            let c = $0.components(separatedBy: " | ")
            return c[1].components(separatedBy: " ")
        }
    }()

    lazy var signals:[[String]] = {
        input.lines.map {
            let c = $0.components(separatedBy: " | ")
            return c[0].components(separatedBy: " ").sorted {
                $0.count < $1.count
            }
        }
    }()

    override func part1() -> String {
        let counts = [2, 3, 4, 7]
        let total = outputs.reduce(0) {
            $0 + $1.filter {
                counts.contains($0.count)
            }.count
        }
        return "\(total)"
    }

    func parseSignal(_ signal: String) -> [Character: Int] {
        var output: [Character: Int] = [: ]
        for c in signal.replacingOccurrences(of: " ", with: "") {
            output[c, default: 0] += 1
        }
        return output
    }

    var patterns: [[Int]] = [
        [0,1,2,3,4,5],      //0
        [1,2],              //1*
        [0,1,3,4,6],        //2
        [0,1,2,3,6],        //3
        [1,2,5,6],          //4*
        [0,2,3,5,6],        //5
        [0,2,3,4,5,6],      //6
        [0,1,2],            //7*
        [0,1,2,3,4,5,6],    //8*
        [0,1,2,3,5,6]       //9
    ]

    override func part2() -> String {
        var results: [Int] = []
        for line in input.lines {
            let comps = line.components(separatedBy: " | ")
            let signalsString = comps[0]
            let signals = signalsString.components(separatedBy: " ").sorted {
                $0.count < $1.count
            }

            let charCounts = parseSignal(signalsString)

            var d: [Int: Character] = [: ]

            let t = Array(signals[1]).filter { !Array(signals[0]).contains($0) }.first!
            let eights = charCounts.filter { _, v in v == 8 }
            let sevens = charCounts.filter { _, v in v == 7 }

            d[0] = eights.filter { k, v in k == Character(String(t)) }.first!.key
            d[1] = eights.filter { k, v in k != Character(String(t)) }.first!.key
            d[2] = charCounts.first(where: { $1 == 9 })!.key
            //3
            d[4] = charCounts.first(where: { $1 == 4 })!.key
            d[5] = charCounts.first(where: { $1 == 6 })!.key
            //6
            let commons: [Character] = [d[1]!, d[2]!, d[5]!]
            let m = Array(signals[2]).filter { !commons.contains($0) }.first!
            d[3] = sevens.filter { k, _ in k != Character(String(m)) }.first!.key
            d[6] = sevens.filter { k, v in k == Character(String(m)) }.first!.key

            let outputs = comps[1].components(separatedBy: " ")
            var nums: [String] = []
            for output in outputs {
                let digit = String(output.sorted())
                for num in 0..<patterns.count {
                    var characters: [Character] = []
                    for c in patterns[num] {
                        characters.append(d[c]!)
                    }
                    let pattern = String(characters.sorted())

                    if digit == pattern {
                        nums.append(String(num))
                        break
                    }
                }
            }
            results.append(Int(nums.joined(separator: ""))!)

        }
        let total = results.reduce(0, +)
        return "\(total)"
    }
}
