class Day01: Day {
    override var name: String { "01" }
    
    lazy var todaysInput: [Int] = {
        input.raw
            .components(separatedBy: "\n\n")
            .map {
                $0.components(separatedBy: "\n")
                  .compactMap { Int($0) }
                  .sum
            }
    }()
    
    override func part1() -> String {
        return "\(todaysInput.max())"
    }
    
    override func part2() -> String {
        return "\(todaysInput.max(count: 3))"
    }
}
