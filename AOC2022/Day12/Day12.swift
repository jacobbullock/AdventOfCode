
import Foundation

class Day12: Day {
    override var name: String { "12" }
    
    lazy var characterMap: [Character:  Int] = {
        let characters = Array("abcdefghijklmnopqrstuvwxyz")
        var m = [Character:  Int]()
        for (index, value) in characters.enumerated() {
            m[value] = index
        }
        return m
    }()
    
    func mapNodes(in grid: Grid<Int>) -> (start: Node<Int>, end: Node<Int>) {
        var start: Node<Int>?
        var end: Node<Int>?
        
        let a = input.lines.map { Array($0) }
        
        for r in 0..<a.count {
            for c in 0..<a[r].count {
                if a[r][c] == "S" {
                    start = grid.nodes[r][c]
                }
                
                if a[r][c] == "E" {
                    end = grid.nodes[r][c]
                }
                
                if let start = start, let end = end {
                    return (start: start, end: end)
                }
            }
        }
        
        fatalError()
    }
    
    func todaysInput(delta: (Int, Int) -> (Int)) -> Grid<Int> {
        let a = input.lines.map {
            Array($0).map {
                let c: Character
                switch $0 {
                case "S": c = "a"
                case "E": c = "z"
                default: c = $0
                }
                return Node(value: self.characterMap[c]!)
            }
        }
        
        for r in 0..<a.count {
            for c in 0..<a[r].count {
                let currValue = a[r][c].value
                
                var edges: [Node<Int>] = []
                
                if r > 0, delta(a[r-1][c].value, currValue) <= 1 {
                    edges.append(a[r-1][c])
                }
                
                if r < a.count - 1, delta(a[r+1][c].value, currValue) <= 1 {
                    edges.append(a[r+1][c])
                }
                
                if c > 0, delta(a[r][c-1].value, currValue) <= 1  {
                    edges.append(a[r][c-1])
                }
                
                if c < a[r].count - 1, delta(a[r][c+1].value, currValue) <= 1 {
                    edges.append(a[r][c+1])
                }
                
                a[r][c].edges = edges
            }
        }
        
        return Grid(nodes: a)
    }

    override func part1() -> String {
        let grid = todaysInput(delta: { $0 - $1 })
        let poi = mapNodes(in: grid)
        let bds = bds(grid: grid, start: poi.start, end: .node(poi.end))


        return "\(bds?.count)"
    }
    
    override func part2() -> String {
        let grid = todaysInput(delta: { $1 - $0 })
        let poi = mapNodes(in: grid)
        let bds = bds(grid: grid, start: poi.end, end: .value(0))
        
        return "\(bds?.count)"
    }
    
    
}

extension Day12 {
    enum Destination {
        case node(Node<Int>)
        case value(Int)
    }
    
    class Node<T>: Equatable, Hashable {
        static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
            lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        let id: UUID
        let value: T
        var edges: [Node<T>] = []
        var crumb: Node<T>?
        
        init(value: T) {
            id = UUID()
            self.value = value
        }
    }

    class Grid<T> {
        var nodes: [[Node<T>]] = []
        
        init(nodes: [[Node<T>]]) {
            self.nodes = nodes
        }
    }
    
    private func bds(grid: Grid<Int>, start: Node<Int>, end: Destination) -> [Node<Int>]? {
        var queue: [Node<Int>] = [start]
        var visited: Set<Node<Int>> = [start]
        
        while !queue.isEmpty {
            let current = queue.removeFirst()

            var foundIt = false
            switch end {
            case .node(let target): foundIt = current == target
            case .value(let value): foundIt = current.value == value
            }
            if foundIt {
                var path: [Node<Int>] = []
                var crumb: Node<Int>? = current.crumb
                while crumb != nil {
                    path.append(crumb!)
                    crumb = crumb?.crumb
                }
                return path
            }
            
            let edges = current.edges
            let filtered = Set(edges).subtracting(visited)
            let items = Array(
                filtered.map {
                    $0.crumb = current
                    return $0
                }
            )
            
            for item in items {
                visited.insert(item)
            }
            queue += items
        }
        
        return nil
    }
}
