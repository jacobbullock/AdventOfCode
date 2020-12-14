//
//  Day12.swift
//  AOC2020
//
//  Created by Jacob Bullock on 12/11/20.
//

import Foundation

enum Compass: String {
    case N, S, E, W, R, L, F
    
    var point: Point? {
        switch self {
        case .N:
            return Point(x: 0, y: 1)
        case .S:
            return Point(x: 0, y: -1)
        case .E:
            return Point(x: 1, y: 0)
        case .W:
            return Point(x: -1, y: 0)
        default:
            return Point.zero
        }
    }
}

struct Heading {
    var rotation: Int
    
    mutating func rotate(by degree: Int) {
        rotation += degree
        rotation %= 360
    }

    var direction: Compass? {
        var r = rotation
        
        if r < 0 {
            r = 360 + r
        }
        switch r {
        case 0:
            return .N
        case 90:
            return .E
        case 180:
            return .S
        case 270:
            return .W
        default:
            return nil
        }
    }
}

class Day12: Day {
    override var name: String { "12" }
    
    override func part1() -> String {
        
        var heading = Heading(rotation: 90)
        
        let result = input.lines.reduce(Point(x:0, y:0)) { (position, line) -> Point in
            let cmd = String(line.prefix(1))
            let i = Int(line.dropFirst())!
            
            var p = position
            switch Compass(rawValue: cmd)! {
            case .N:
                p.y += i
            case .S:
                p.y -= i
            case .E:
                p.x += i
            case .W:
                p.x -= i
            case .R:
                heading.rotate(by: i)
            case .L:
                heading.rotate(by: -i)
            case .F:
                p = p + (heading.direction!.point! * i)
            }
            
            return p
        }
        
        return "\(result.manhattanDistance)"
    }
    
    override func part2() -> String {
 
        var waypoint = Point(x: 10, y: 1)
        
        let result = input.lines.reduce(Point(x:0, y:0)) { (position, line) -> Point in
            let cmd = String(line.prefix(1))
            let i = Int(line.dropFirst())!
            
            var p = position
            switch Compass(rawValue: cmd)! {
            case .N:
                waypoint.y += i
            case .S:
                waypoint.y -= i
            case .E:
                waypoint.x += i
            case .W:
                waypoint.x -= i
            case .R:
                waypoint.rotate(by: i)
            case .L:
                waypoint.rotate(by: -i)
            case .F:
                p = p + (waypoint * i)
            }
            
            return p
        }
        
        return "\(result.manhattanDistance)"
    }
}

extension Point {
    
    mutating func rotate(by degree: Int) {
        var r = degree
        if r < 0 {
            r = 360 + r
        }
        
        let p = self
        
        if r == 90 {
            y = -p.x
            x = p.y
        } else if r == 180 {
            y = -p.y
            x = -p.x
        } else if r == 270 {
            y = p.x
            x = -p.y
        } else {
            print("\(r)")
        }
    }
}
