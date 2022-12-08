class Day02: Day {
    override var name: String { "02" }
    
    override func part1() -> String {
        let total = run(calculate: calculateRoundPart1)
        return "\(total)"
    }
    
    override func part2() -> String {
        let total = run(calculate: calculateRoundPart2)
        return "\(total)"
    }
}

fileprivate extension Day02 {
    // Rock = 1, Paper = 2, Scissors = 3
    // A, B, C -> opponent Play
    // X, Y, Z -> my play
    var options: [String: Int] { ["A": 1, "B": 2, "C": 3, "X": 1, "Y": 2, "Z": 3] }
    
    private func run(calculate: (String) -> Int) -> Int {
        var combosMap: [String: Int] = [:]
        var total = 0
        
        for line in input.lines {
            if let value = combosMap[line] {
                total += value
            } else {
                let value = calculate(line)
                combosMap[line] = value
                total += value
            }
        }
        return total
    }
    
    private func calculateRoundPart1(_ data: String) -> Int {
        let roundValues = [0: 3, 1: 6, -2: 6, -1: 0, 2: 0]
        
        let components = data.components(separatedBy: " ").map { options[$0]! }
        let diff = components[1] - components[0]
        
        return components[1] + roundValues[diff]!
    }
    
    private func calculateRoundPart2(_ data: String) -> Int {
        // X = lose, Y = draw, Z = win
        let playValues = ["X": 0, "Y": 3, "Z": 6]
        
        // [OpponenetsMove: [lose, draw, win]]
        let playsMap = ["A": [3,1,2], "B": [1,2,3], "C": [2,3,1]]
        
        let components = data.components(separatedBy: " ")
        let playIndex = options[components[1]]! - 1
        let playPoints = playsMap[components[0]]![playIndex]
        
        return playPoints + playValues[components[1]]!
    }
}
