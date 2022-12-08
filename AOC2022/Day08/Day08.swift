class Day08: Day {
    override var name: String { "08" }
    
    lazy var todaysInputs: [[Int]] = {
        input.lines
            .map {
                Array($0).map { Int(String($0))! }
            }
            
    }()
    
    lazy var startingGrid: [[Bool]] = {
        todaysInputs.map {
            $0.map { _ in false }
        }
    }()
    
    var width: Int {
        todaysInputs[0].count
    }
    
    var height: Int {
        input.lines.count
    }
    
    var grid: [[Bool]] = []
    override func part1() -> String {
        grid = startingGrid
        
        scanRows()
        scanColumns()
        
        let result = grid.map {
            $0.map { $0 ? 1 : 0 }.sum
        }.sum
        
        return "\(result)"
    }
    
    override func part2() -> String {
        
        var highScore = 0
        
        var row = 0
        var col = 0
        
        while row < height {
            let score = [
                scenicScore(row: row, col: col, rowIncrement: 0, colIncrement: 1),
                scenicScore(row: row, col: col, rowIncrement: 0, colIncrement: -1),
                scenicScore(row: row, col: col, rowIncrement: 1, colIncrement: 0),
                scenicScore(row: row, col: col, rowIncrement: -1, colIncrement: 0),
            ].product

            if score > highScore {
                highScore = score
            }
            
            col += 1
            
            if col == width {
                col = 0
                row += 1
            }
        }

        return "\(highScore)"
    }
}

extension Day08 {
    
    private func scenicScore(row: Int, col: Int, rowIncrement: Int, colIncrement: Int) -> Int {
        if row == 0 || col == 0 || row == height - 1 || col == width - 1 {
            return 0
        }
        
        let startingTree = todaysInputs[row][col]
        var trees = 0
        
        var currRow = row
        var currCol = col
        var scan = true
        while scan {
            currRow += rowIncrement
            currCol += colIncrement

            let tree = todaysInputs[currRow][currCol]

            trees += 1
            
            if tree >= startingTree || currRow == 0 || currCol == 0 || currRow == height - 1 || currCol == width - 1 {
                scan = false
                break
            }
        }
        
        return trees
    }
    
    private func scanRows() {
        var index = 0
        
        var left = -1
        var right = -1
        
        var columnIndex = 0
        
        while columnIndex < height {
            let rightIndex = width - 1 - index
            
            let a = todaysInputs[columnIndex][index]
            let b = todaysInputs[columnIndex][rightIndex]
            
            if a > left {
                grid[columnIndex][index] = true
                left = a
            }
            
            if b > right {
                grid[columnIndex][rightIndex] = true
                right = b
            }
            
            index += 1
            
            if index == width {
                columnIndex += 1
                index = 0
                left = -1
                right = -1
            }
        }
    }
    
    private func scanColumns() {
        var index = 0
        
        var top = -1
        var bottom = -1
        
        var rowIndex = 0
        
        while rowIndex < width {
            let bottomIndex = height - 1 - index
            
            let a = todaysInputs[index][rowIndex]
            let b = todaysInputs[bottomIndex][rowIndex]
            
            if a > top {
                grid[index][rowIndex] = true
                top = a
            }
            
            if b > bottom {
                grid[bottomIndex][rowIndex] = true
                bottom = b
            }
            
            index += 1
            
            if index == height {
                rowIndex += 1
                index = 0
                top = -1
                bottom = -1
            }
        }
    }
}

