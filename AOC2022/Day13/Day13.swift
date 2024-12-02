class Day13: Day {
    lazy var todaysInput: [[Packet]] = {
        var data: [[Packet]] = []
        let pairs = input.raw.components(separatedBy: "\n\n")
        for pair in pairs {
            let comps = pair.components(separatedBy: "\n")
            var packets: [Packet] = []
            for line in comps {
                print(line)
                
                
                packets.append(parsePacket(from: line))
            }
            data.append(packets)
        }
        
        return data
    }()

    func parsePacket(from line: String) -> Packet {
        var packet = Packet()
        packet.data = []
        
        return packet
    }
    
    override var name: String { "13" }
    
    override func part1() -> String {
        let d = todaysInput
        return ""
    }
    
    override func part2() -> String {
        return ""
    }
}

extension Day13 {
    struct Packet {
        var data: [PacketData] = []
    }

    enum PacketData {
        case num(Int)
        case list([Int])
    }
}

