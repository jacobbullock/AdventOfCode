class Day03: Day {
    override var name: String { "03" }
    
    lazy var priorityMap: [Character: Int] = {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let characterArray = Array(characters)
        var characterMap = [Character: Int]()
        for (index, c) in characterArray.enumerated() {
            characterMap[c] = index + 1
        }
        return characterMap
    }()
    
    override func part1() -> String {
        let total = input.lines.map { line in
            let c = Array(line).split().map { Set($0) }
            
            return c[0].intersection(c[1])
                .compactMap { priorityMap[$0] }
                .sum
        }.sum
        return "\(total)"
    }
    
    override func part2() -> String {
        var index = 0
        var priorities: [Int] = []
        while index < input.lines.count {
            let sacks = Array(input.lines[index..<index+3]).map { Set($0) }
            let firstSack = sacks.first!
            let common = sacks.dropFirst().reduce(firstSack) {
                $0.intersection($1)
            }
            priorities.append(common.compactMap { priorityMap[$0] }.sum)

            index += 3
        }
        return "\(priorities.sum)"
    }
}

