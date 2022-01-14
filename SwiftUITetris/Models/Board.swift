struct Board: Equatable {
    let data: [[BlockColour?]]
    let inPlayBlocks: [InPlayBlock]
    
    var latestPiece: InPlayBlock? { inPlayBlocks.last }
    var populatedCoords: Set<Coordinate> { inPlayBlocks.reduce(into: [], { $0.formUnion($1.coords) }) }
    
    static let allNilData: [[BlockColour?]] = Array(repeating: Array(repeating: nil, count: 10), count: 20)
    
    init(inPlayBlocks: [InPlayBlock] = []) {
        self.inPlayBlocks = inPlayBlocks
        
        var data: [[BlockColour?]] = Self.allNilData
        
        for ipb in inPlayBlocks {
            for c in ipb.coords {
                data[c.y][c.x] = ipb.block.colour
            }
        }
        
        self.data = data
    }
    
    private func isSpaceEmpty(coord: Coordinate) -> Bool {
        data[coord.y][coord.x] == nil
    }
    
    private func getNeighbourCoords(of block: InPlayBlock, direction: MovementDirection) -> [Coordinate] {
        block.coords.compactMap({ coord in
            let neighbour = Coordinate(coord.x + direction.adjustment.x, coord.y + direction.adjustment.y)
            if block.coords.contains(neighbour) { return nil }
            return neighbour
        })
    }
}

// MARK: - Movement
extension Board {
    func movingLatestPiece(direction: MovementDirection) -> Board {
        guard let latestPiece = latestPiece else { return self }

        let neighbourCoords = getNeighbourCoords(of: latestPiece, direction: direction)
        
        for neighbour in neighbourCoords {
            if !coordIsWithinBoard(coord: neighbour) || !isSpaceEmpty(coord: neighbour) {
                return self
            }
        }
        
        var newBlocks = inPlayBlocks.filter({ $0 != latestPiece })
        let newBlock = InPlayBlock(block: latestPiece.block,
                                   coords: latestPiece.coords.reduce(into: [], { $0.insert(.init($1.x + direction.adjustment.x, $1.y + direction.adjustment.y))}))
        newBlocks.append(newBlock)
        
        return Board(inPlayBlocks: newBlocks)
    }
    
    private func coordIsWithinBoard(coord: Coordinate) -> Bool {
        coord.x >= 0 && coord.x < data[0].count && coord.y >= 0 && coord.y < data.count
    }
}

enum MovementDirection {
    case left
    case right
    case down
    
    var adjustment: Coordinate {
        switch self {
        case .left: return Coordinate(-1, 0)
        case .right: return Coordinate(1, 0)
        case .down: return Coordinate(0, 1)
        }
    }
}

struct InPlayBlock: Hashable {
    let block: Block
    let coords: Set<Coordinate>
}
