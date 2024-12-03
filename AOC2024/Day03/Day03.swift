import RegexBuilder
import Foundation

extension Day03 {
    enum Command {
        case start(Int)
        case stop(Int)
        case mul(Int, Int, Int)
        
        var sortOrder: Int {
            switch self {
            case .start(let v): return v
            case .stop(let v): return v
            case .mul(let v, _, _): return v
            }
        }
    }
}

class Day03: Day {
    override var name: String { "03" }
    
    let firstNum = Reference(Int.self)
    let secondNum = Reference(Int.self)
    
    lazy var mul = {
        Regex {
            "mul("

            TryCapture(as: firstNum) {
                OneOrMore(.digit)
            } transform: { match in
                guard match.count <= 3 else { return nil }
                return Int(match)
            }

            ","

            TryCapture(as: secondNum) {
                OneOrMore(.digit)
            } transform: { match in
                guard match.count <= 3 else { return nil }
                return Int(match)
            }

            ")"
        }
    }()
    
    
    
    override func part1() -> String {
        let matches = input.raw.matches(of: mul)
        let value = matches.reduce(0) {
            $0 + ($1[firstNum] * $1[secondNum])
        }
        return "\(value)"
    }
    
    override func part2() -> String {
        let doCommands = input.raw.matches(of: try! Regex("do")).map {
            Command.start(input.raw.distance(from: input.raw.startIndex, to: $0.range.lowerBound))
        }
        let dontCommands = input.raw.matches(of: try! Regex("don't")).map {
            Command.stop(input.raw.distance(from: input.raw.startIndex, to: $0.range.lowerBound))
        }

        let multiplyCommands = input.raw.matches(of: mul).map {
            Command.mul(
                input.raw.distance(from: input.raw.startIndex, to: $0.range.lowerBound),
                $0[firstNum],
                $0[secondNum]
            )
        }
        
        let commands: [Command] = (doCommands + dontCommands + multiplyCommands).sorted {
            return $0.sortOrder < $1.sortOrder
        }
        
        var value: Int = 0
        var isCalculating = true
        for c in commands {
            switch c {
            case .start:
                isCalculating = true
            case .stop:
                isCalculating = false
            case .mul(_, let a, let b):
//                print(a, b)
                if isCalculating {
                    value += a * b
                }
            }
        }

        return "\(value)"
    }
    
    // playwith some alternate regex options in swift
    func altRegex() {
        let matches = input.raw.matches(of: /mul\(([0-9]{1,3}),([0-9]{1,3})\)/)
        for match in matches {
            print(input.raw[match.range])
            print(match.output.1)
            print(match.output.2)
        }

        
        
        let matches2 = input.raw.matches(of: try! Regex(#"mul\(([0-9]{1,3}),([0-9]{1,3})\)"#))
        for match in matches2 {
            print(input.raw[match.range])
            print(match.output.extractValues(as: (Substring, Substring, Substring).self))
        }
        
        
        
        let captureRegex = try! NSRegularExpression(
            pattern: #"mul\(([0-9]{1,3}),([0-9]{1,3})\)"#,
            options: []
        )
        let matches3 = captureRegex.matches(
            in: input.raw,
            options: [],
            range: NSRange(input.raw.startIndex..<input.raw.endIndex, in: input.raw)
        )
        for match in matches3 {
            for i in 1..<match.numberOfRanges {
                let r = match.range(at: i)
                print(input.raw[Range(r, in: input.raw)!])
            }
        }
    }
}

