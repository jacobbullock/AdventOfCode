class Day07: Day {
    override var name: String { "07" }

    lazy var todaysInput: Node = {
        let fileSystem = FileSystem()
        return fileSystem.process(input.lines)
    }()
    
    override func part1() -> String {
        var nodes: [Node] = []
        processNode(todaysInput)
        
        func processNode(_ node: Node) {
            if node.size <= 100_000 {
                nodes.append(node)
            }
            for subnode in node.nodes {
                processNode(subnode)
            }
        }
        
        return "\(nodes.map { $0.size }.sum)"
    }
    
    override func part2() -> String {
        let usedSpace = todaysInput.size
        let totalSize = 70_000_000
        let spaceNeeded = 30_000_000
        let availableSize = totalSize - usedSpace
        let delta = spaceNeeded - availableSize

        var nodes: [Node] = []
        processNode(todaysInput)

        func processNode(_ node: Node) {
            if node.size > delta {
                nodes.append(node)
            }
            for subnode in node.nodes {
                processNode(subnode)
            }
        }
        
        let result = nodes.map { $0.size }.sorted(by: <)
        
        return "\(result.first!)"
    }
}

extension Day07 {
    struct File {
        let name: String
        let size: Int
    }
    
    struct Directory {
        let name: String
        var files: [File] = []
        
        var size: Int {
            files.map { $0.size }.sum
        }
    }
    
    enum Item {
        case file(File)
        case directory(Directory)
        
        var size: Int {
            switch self {
            case .file(let file): return file.size
            case .directory(let dir): return dir.size
            }
        }
    }
    
    class Node {
        let path: [String]
        let parent: Node?
        var nodes: [Node] = []
        var items: [Item] = []
        
        init(path: [String], parent: Node? = .none) {
            self.path = path
            self.parent = parent
        }
        
        func addItem(_ item: Item) {
            items.append(item)
        }
        
        var size: Int {
            nodes.map { $0.size }.sum + items.map { $0.size }.sum
        }
        
        func printNode(index: Int = 0) {
            let prefix = String(repeating: "\t", count: index)
            print(prefix, path.joined(separator: "/"), ", ", size)

            for subnode in nodes {
                subnode.printNode(index: index + 1)
            }
        }
    }
}

extension Day07 {
    class FileSystem {
        private var path: [String] = []
        private var rootNode: Node!
        private var currentNode: Node!
        
        func process(_ lines: [String]) -> Node {
            path = []
            rootNode = Node(path: [])
            currentNode = rootNode
            
            for line in lines {
                if line.prefix(1) == "$" {
                    processCommand(line)
                } else {
                    processListItem(line)
                }
            }
            
            return rootNode
        }
        
        private func processCommand(_ line: String) {
            let components = line.components(separatedBy: " ")
            switch components[1] {
            case "cd": changeDirectory(to: components[2])
            default: break
            }
        }
        
        private func processListItem(_ line: String) {
            let components = line.components(separatedBy: " ")

            if let size = Int(components[0]) {
                currentNode.addItem(
                    .file(.init(name: components[1], size: size))
                )
            } else if components[0] == "dir" {
                currentNode.addItem(
                    .directory(.init(name: components[1]))
                )
            }
        }
        
        private func changeDirectory(to value: String) {
            if value == "/" {
                path = ["/"]
                updateCurrentNode(from: path, name: value)
            } else if value == ".." {
                path.removeLast()
                currentNode = currentNode!.parent
            } else {
                path.append(value)
                updateCurrentNode(from: path, name: value)
            }
        }
        
        private func updateCurrentNode(from path: [String], name: String) {
            let node = Node(path: path, parent: currentNode)
            currentNode.nodes.append(node)
            currentNode = node
        }
        
    //    private func updateCurrentNode(from path: [String], name: String) {
    //        // this commented code is a version that handles more complex directory changing,
    //        // like changing to / from anywhere in the input,
    //        // it is not required with the given input, so it's commented out to make the code run faster
    //        if let node = findNode(at: path, in: rootNode) {
    //
    //            currentNode = node
    //        } else {
    //            let node = Node(name: name, path: path, parent: currentNode)
    //            currentNode.nodes.append(node)
    //            currentNode = node
    //        }
    //    }
        
    //    private func findNode(at path: [String], in node: Node) -> Node? {
    //        if node.path == path {
    //            return node
    //        }
    //
    //        for n in node.nodes {
    //            if let foundNode = findNode(at: path, in: n) {
    //                return foundNode
    //            }
    //        }
    //
    //        return nil
    //    }
    }
}
