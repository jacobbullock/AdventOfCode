//
//  Input.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/3/20.
//

import Foundation

class Input {
    let raw: String
    
    public lazy var lines: Array<String> = { raw.components(separatedBy: .newlines) }()
    public lazy var integers: Array<Int> = { lines.map { Int($0)! } }()
    public lazy var intArray: Array<Int> = { raw.components(separatedBy: ",").map { Int($0)! } }()
    
    public convenience init(file: String) {
        self.init(try! String(contentsOfFile: file))
    }
    
    public init(_ raw: String) {
        self.raw = raw.trimmingCharacters(in: .newlines)
    }
    
}
