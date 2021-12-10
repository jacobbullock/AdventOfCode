class Day05: Day {
    override var name: String { "05" }

    lazy var coordinates: [[Point]] = {
        var a: [[Point]] = []
        for line in input.lines {
            let components =  line.components(separatedBy: " -> ")
            var aa: [Point] = []
            for comp in components {
                let values = comp.components(separatedBy: ",")
                aa.append(Point(x: Int(values[0])!, y: Int(values[1])!))
            }
            a.append(aa)
        }

        return a
    }()
    
    override func part1() -> String {
        var hash: [String: Int] = [:]
        for coord in coordinates {
            if coord[0].x == coord[1].x {
                let max = max(coord[0].y, coord[1].y)
                let min = min(coord[0].y, coord[1].y)

                let diff = max - min

                for i in 0...diff {
                    let key = "\(coord[0].x),\(min + i)"
                    if let v = hash[key] {
                        hash[key] = v + 1
                    } else {
                        hash[key] = 1
                    }
                }
            } else if coord[0].y == coord[1].y {
                let max = max(coord[0].x, coord[1].x)
                let min = min(coord[0].x, coord[1].x)

                let diff = max - min

                for i in 0...diff {
                    let key = "\(min + i),\(coord[0].y)"
                    if let v = hash[key] {
                        hash[key] = v + 1
                    } else {
                        hash[key] = 1
                    }
                }
            }
        }

        var count = 0
        for (_, value) in hash {

            if value > 1 {
                count += 1
            }

            //print("\(key): \(value) :: \(count)")
        }
        return "\(count)"
    }

    override func part2() -> String {
        var hash: [String: Int] = [:]
        for coord in coordinates {
            if coord[0].x == coord[1].x {
                let max = max(coord[0].y, coord[1].y)
                let min = min(coord[0].y, coord[1].y)

                let diff = max - min

                for i in 0...diff {
                    let key = "\(coord[0].x),\(min + i)"
                    if let v = hash[key] {
                        hash[key] = v + 1
                    } else {
                        hash[key] = 1
                    }
                }
            } else if coord[0].y == coord[1].y {
                let max = max(coord[0].x, coord[1].x)
                let min = min(coord[0].x, coord[1].x)

                let diff = max - min

                for i in 0...diff {
                    let key = "\(min + i),\(coord[0].y)"
                    if let v = hash[key] {
                        hash[key] = v + 1
                    } else {
                        hash[key] = 1
                    }
                }
            } else {
                var xi = 1
                var yi = 1
                if coord[0].x > coord[1].x {
                    xi = -1
                }

                if coord[0].y > coord[1].y {
                    yi = -1
                }

                let diff = abs(coord[0].x - coord[1].x)
                let minx = coord[0].x
                let miny = coord[0].y

               // print(diff, minx, miny, xi, yi)

                for i in 0...diff {
                    let key = "\(minx + (xi * i)),\(miny + (yi * i))"
                    if let v = hash[key] {
                        hash[key] = v + 1
                    } else {
                        hash[key] = 1
                    }
                }
            }
        }

        var count = 0
        for (_, value) in hash {

            if value > 1 {
                count += 1
            }

            //print("\(key): \(value) :: \(count)")
        }
        return "\(count)"
    }
}
