class Day06: Day {
    override var name: String { "06" }



    override func part1() -> String {

        var dict: [Int: Int] = [: ]

        for i in input.intArray {
            if dict[i] == nil {
                dict[i] = 1
            } else {
                dict[i] = dict[i]! + 1
            }
        }

        //let keys = dict.keys.sorted(by: <)
        //print(keys.map { "\($0): \(dict[$0]!)"})

        for _ in 0..<80 { //i
            dict = shiftDict(dict: dict)
            //let keys = dict.keys.sorted(by: <)
            //print(keys.map { "\($0): \(dict[$0]!)"})

            var sum = 0
            for (_, value) in dict {
                sum += value
            }
            //print("\(i): \(sum)")
        }

        var sum = 0
        for (_, value) in dict {
            sum += value
        }

        return "\(sum)"
    }

    func shiftDict(dict: [Int: Int]) -> [Int: Int] {
        var d: [Int: Int] = [:]

        let keys = dict.keys.sorted(by: <)
        for key in keys {
            if key == 0 {
                d[8] = dict[key]!
                d[6] = (d[6] == nil) ? dict[key]! : d[6]! + dict[key]!
            } else {
                if key - 1 == 6 {
                    d[6] = (d[6] == nil) ? dict[key]! : d[6]! + dict[key]!
                } else {
                    d[key - 1] = dict[key]!
                }

            }
        }

        return d
    }

    override func part2() -> String {
        var dict: [Int: Int] = [: ]

        for i in input.intArray {
            if dict[i] == nil {
                dict[i] = 1
            } else {
                dict[i] = dict[i]! + 1
            }
        }

        //let keys = dict.keys.sorted(by: <)
        //print(keys.map { "\($0): \(dict[$0]!)"})

        for _ in 0..<256 {//i
            dict = shiftDict(dict: dict)
            //let keys = dict.keys.sorted(by: <)
            //print(keys.map { "\($0): \(dict[$0]!)"})

            var sum = 0
            for (_, value) in dict {
                sum += value
            }
            ///print("\(i): \(sum)")
        }

        var sum = 0
        for (_, value) in dict {
            sum += value
        }

        return "\(sum)"
    }
}
