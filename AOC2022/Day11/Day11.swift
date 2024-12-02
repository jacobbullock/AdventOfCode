class Day11: Day {
    override var name: String { "11" }
    
    lazy var todaysInput: [Monkey] = {
        [
            Monkey(items: [66, 79],
                   operation: { $0 * 11 }, action: { $0 % 7 == 0 ? 6 : 7 }, test: 7),
            Monkey(items: [84, 94, 94, 81, 98, 75],
                   operation: { $0 * 17 }, action: { $0 % 13 == 0 ? 5 : 2 }, test: 13),
            Monkey(items: [85, 79, 59, 64, 79, 95, 67],
                   operation: { $0 + 8 }, action: { $0 % 5 == 0 ? 4 : 5 }, test: 5),
            Monkey(items: [70],
                   operation: { $0 + 3 }, action: { $0 % 19 == 0 ? 6 : 0 }, test: 19),
            Monkey(items: [57, 69, 78, 78],
                   operation: { $0 + 4 }, action: { $0 % 2 == 0 ? 0 : 3 }, test: 2),
            Monkey(items: [65, 92, 60, 74, 72],
                   operation: { $0 + 7 }, action: { $0 % 11 == 0 ? 3 : 4 }, test: 11),
            Monkey(items: [77, 91, 91],
                   operation: { $0 * $0 }, action: { $0 % 17 == 0 ? 1 : 7 }, test: 17),
            Monkey(items: [76, 58, 57, 55, 67, 77, 54, 99],
                   operation: { $0 + 6 }, action: { $0 % 3 == 0 ? 2 : 1 }, test: 3)
        ]
    }()

    lazy var sampleInput: [Monkey] = {
        [
            Monkey(items: [79,98],
                   operation: { $0 * 19 }, action: { $0 % 23 == 0 ? 2 : 3 }, test: 23),
            Monkey(items: [54, 65, 75, 74],
                   operation: { $0 + 6 }, action: { $0 % 19 == 0 ? 2 : 0 }, test: 19),
            Monkey(items: [79, 60, 97],
                   operation: { $0 * $0 }, action: { $0 % 13 == 0 ? 1 : 3 }, test: 13),
            Monkey(items: [74],
                   operation: { $0 + 3 }, action: { $0 % 17 == 0 ? 0 : 1 }, test: 17),
        ]
    }()
    
    override func part1() -> String {
        var monkeys = todaysInput
        for _ in 0..<20 {
            for i in 0..<monkeys.count {
                while monkeys[i].items.count > 0 {
                    let item  = monkeys[i].items.removeFirst()
                    let level = monkeys[i].operation(item) / 3
                    let index = monkeys[i].action(level)
                    
                    monkeys[index].items.append(level)
                    monkeys[i].inspectionCount += 1
                    
                }
            }
        }
        
        let result = monkeys.map { $0.inspectionCount }.sorted(by: >)[0...1].product
        return "\(result)"
    }
    
    override func part2() -> String {
        var monkeys = todaysInput
        let worryCooler = monkeys.map { $0.test }.product
        for _ in 0..<10_000 {
            for i in 0..<monkeys.count {
                while monkeys[i].items.count > 0 {
                    let item  = monkeys[i].items.removeFirst()
                    let level = monkeys[i].operation(item) % worryCooler
                    let index = monkeys[i].action(level)
                    
                    monkeys[index].items.append(level)
                    monkeys[i].inspectionCount += 1
                    
                }
            }
        }

        let result = monkeys.map { $0.inspectionCount }.sorted(by: >)[0...1].product
        return "\(result)"
    }
}

extension Day11 {
    struct Monkey {
        var inspectionCount: Int = 0
        var items: [Int]
        let operation: (Int) -> Int
        let action: (Int) -> Int
        let test: Int
    }
}

