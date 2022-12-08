class Day04: Day {
    override var name: String { "04" }
    
    lazy var todaysInput: [[ClosedRange<Int>]] = {
        input.lines.map {
            $0
            .components(separatedBy: ",")
            .map { $0.components(separatedBy: "-").map { Int($0)! } }
            .map { $0[0]...$0[1] }
        }
    }()
    
    override func part1() -> String {
        let count = todaysInput.filter {
            $0[0].contains($0[1]) || $0[1].contains($0[0])
        }.count
        
        return "\(count)"
    }
    
    override func part2() -> String {
        let count = todaysInput.filter {
            $0[0].overlaps($0[1]) || $0[1].overlaps($0[0])
        }.count
        
        return "\(count)"
    }
}
