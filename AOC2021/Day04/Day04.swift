import Foundation
class Day04: Day {
    class Board: Hashable {
        static func == (lhs: Day04.Board, rhs: Day04.Board) -> Bool {
            return lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        internal init(rows: [[Node]], columns: [[Node]]) {
            self.rows = rows
            self.columns = columns
        }

        var id: UUID = UUID()
        var rows: [[Node]]
        var columns: [[Node]]

        func select(num: Int) {
            for row in rows {
                for node in row {
                    if node.value == num {
                        node.selected = true
                    }
                }
            }
        }

        var unselectedNodes: [Node] {
            var nodes: [Node] = []
            for row in rows {
                for node in row {
                    if !node.selected {
                        nodes.append(node)
                    }
                }
            }

            return nodes
        }

        var winner: [Node]? {
            for row in rows {
                var selected = true
                for node in row {
                    if !node.selected {
                        selected = false
                    }
                }
                if selected {
                    return unselectedNodes
                }
            }

            for column in columns {
                var selected = true
                for node in column {
                    if !node.selected {
                        selected = false
                    }
                }
                if selected {
                    return unselectedNodes
                }
            }

            return nil
        }
    }

    class Node {
        internal init(value: Int, selected: Bool) {
            self.value = value
            self.selected = selected
        }

        var value: Int
        var selected: Bool
    }

    override var name: String { "04" }

    lazy var numbers: [Int] = {
        input.lines[0].components(separatedBy: ",").map { Int($0)! }
    }()

    lazy var boards: [Board] = {
        var lines = input.lines
        lines.removeFirst(1)

        var board: Board = Board(rows: [], columns: [])
        var columns: [[Node]] = []
        var boards: [Board] = []
        for line in lines {
            if line.count == 0 {
                if columns.count > 0 {
                    board.columns = columns
                    boards.append(board)
                }
                board = Board(rows: [], columns: [])
                columns = []
                for i in 0..<5 {
                    columns.append([])
                }
                continue
            }

            var nums = line.components(separatedBy: .whitespaces).filter { $0 != "" }.map { Int($0)! }

            let row = nums.map { Node(value: $0, selected: false) }
            board.rows.append(row)

            for i in 0..<columns.count {
                columns[i].append(row[i])
            }
        }

        if columns.count > 0 {
            boards.append(board)
        }

        return boards
    }()
    
    override func part1() -> String {
        let boards = boards
        var winner: [Node]? = nil
        var lastNum: Int = numbers[0]
        outerLoop: for num in numbers {
            lastNum = num
            for board in boards {
                board.select(num: num)
                if let winningBoard = board.winner {
                    winner = winningBoard
                    break outerLoop
                }
            }
        }

        print(winner!)
        let values = winner!.map{$0.value}
        print(values)
        let sum = values.reduce(0, +)
        print(sum)
        print(lastNum)
        let answer = sum * lastNum

        return "\(answer)"
    }

    override func part2() -> String {
        var boards = boards
        var winner: [Node]? = nil
        var lastNum: Int = numbers[0]
        var lastWinningBoard: Board?
        outerLoop: for num in numbers {
            lastNum = num
            for board in boards {
                board.select(num: num)
                if let winningBoard = board.winner {
                    lastWinningBoard = board
                    if boards.count > 1 {
                        boards.removeAll { $0 == lastWinningBoard }
                    } else {
                        winner = lastWinningBoard?.unselectedNodes
                        break outerLoop
                    }
                }
            }
        }

        print(winner!)
        let values = winner!.map{$0.value}
        print(values)
        let sum = values.reduce(0, +)
        print(sum)
        print(lastNum)
        let answer = sum * lastNum

        return "\(answer)"
    }
}
