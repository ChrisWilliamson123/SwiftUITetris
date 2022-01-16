struct Board: Equatable {
    let data: [[BlockColour?]]
    let fallingPiece: InPlayBlock?

    var populatedCoords: Set<Coordinate> {
        var result = Set<Coordinate>()
        for y in 0..<data.count {
            for x in 0..<data[y].count where data[y][x] != nil {
                result.insert(Coordinate(x, y))
            }
        }
        return result
    }
    
//    static func == (lhs: Board, rhs: Board) -> Bool {
//        lhs.data == rhs.data
//    }
    
    var completeLineRanges: [ClosedRange<Int>] {
        var ranges = [ClosedRange<Int>]()
        var mainIndex = data.count - 1
        while mainIndex >= 0 {
            let lineData = data[mainIndex]
            if lineData.contains(nil) { mainIndex -= 1; continue }
            if mainIndex == 0 { ranges.append(0...0); mainIndex -= 1; continue }
            
            // Line is full so start building range
            var endOfRangeIndex = mainIndex - 1
            while endOfRangeIndex >= 0 {
                let nextLineData = data[endOfRangeIndex]
                if nextLineData.contains(nil) {
                    // Range has ended
                    ranges.append(endOfRangeIndex+1...mainIndex)
                    break
                }
                // This line was full, so reduce end of range index
                endOfRangeIndex -= 1
            }
            mainIndex = endOfRangeIndex
        }
        return ranges
    }
    
//    var fullLines: Set<Int> {
//        stride(from: data.count-1, to: -1, by: -1).reduce(into: <#T##Result#>, <#T##updateAccumulatingResult: (inout Result, Int) throws -> ()##(inout Result, Int) throws -> ()##(_ partialResult: inout Result, Int) throws -> ()#>)
//        (0..<data.count).reduce(into: [], {
//            if data[$1].contains(nil) { return }
//            $0.insert($1)
//        })
//    }
    
    static let allNilData: [[BlockColour?]] = Array(repeating: Array(repeating: nil, count: 10), count: 20)
    
    init(data: [[BlockColour?]]? = nil, fallingPiece: InPlayBlock? = nil) {
        self.data = data ?? Self.allNilData
        self.fallingPiece = fallingPiece
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
        guard let latestPiece = fallingPiece else { return self }

        let neighbourCoords = getNeighbourCoords(of: latestPiece, direction: direction)
        
        for neighbour in neighbourCoords {
            if !coordIsWithinBoard(coord: neighbour) || !isSpaceEmpty(coord: neighbour) {
                return self
            }
        }
        
        let newBlock = InPlayBlock(block: latestPiece.block,
                                   coords: latestPiece.coords.reduce(into: [], { $0.insert(.init($1.x + direction.adjustment.x, $1.y + direction.adjustment.y))}),
                                   boundingBox: latestPiece.boundingBox.map({ .init($0.x + direction.adjustment.x, $0.y + direction.adjustment.y) }))

        return self.replacing(latestPiece, with: newBlock)
    }
    
    private func coordIsWithinBoard(coord: Coordinate) -> Bool {
        coord.x >= 0 && coord.x < data[0].count && coord.y >= 0 && coord.y < data.count
    }
}

// MARK: - Rotating
extension Board {
    
    func rotatingLatestPiece(_ direction: MovementDirection) -> Board {
        guard let latestPiece = fallingPiece else { return self }
        switch direction {
        case .left:
            let rotated = latestPiece.rotatedLeft()
            return self.replacing(latestPiece, with: rotated)
        case .right:
            let rotated = latestPiece.rotatedRight()
            return self.replacing(latestPiece, with: rotated)
        default:
            return self
        }
    }
}

// MARK: - Data manipulation
extension Board {
    func replacing(_ oldPiece: InPlayBlock, with newPiece: InPlayBlock) -> Board {
        var newData = data
        oldPiece.coords.forEach({ newData[$0.y][$0.x] = nil })
        newPiece.coords.forEach({ newData[$0.y][$0.x] = newPiece.block.colour })
        return Board(data: newData, fallingPiece: newPiece)
    }
}

// MARK: - Line Clearing
//extension Board {
//    func deletingLines(_ lines: Set<Int>) -> Board {
//        for l in lines {
//
//        }
//    }
//}

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
    let boundingBox: [Coordinate]
    
    func rotatedRight() -> InPlayBlock {
        if block == .oBlock { return self }
        if block == .iBlock {
            let transformations = [
                Set([Coordinate(0, 1), Coordinate(1, 1), Coordinate(2, 1), Coordinate(3, 1)]),
                Set([Coordinate(2, 0), Coordinate(2, 1), Coordinate(2, 2), Coordinate(2, 3)]),
                Set([Coordinate(0, 2), Coordinate(1, 2), Coordinate(2, 2), Coordinate(3, 2)]),
                Set([Coordinate(1, 0), Coordinate(1, 1), Coordinate(1, 2), Coordinate(1, 3)])
            ]
            let translated = Set(coords.map({ Coordinate($0.x - boundingBox[0].x, $0.y - boundingBox[0].y) }))
            print(translated)
            let index = transformations.firstIndex(where: { $0 == translated })!
            let rotated = Array(transformations.rotatingLeft(positions: 1))
            let actual = rotated[index]
            return .init(block: block,
                         coords: actual.reduce(into: [], { $0.insert(Coordinate(boundingBox[0].x + $1.x, boundingBox[0].y + $1.y)) }),
                         boundingBox: boundingBox)
        }
        
        let midPoint = Coordinate(boundingBox[0].x+1, boundingBox[0].y+1)
        return .init(block: block, coords: coords.reduce(into: [], { $0.insert($1.rotatingAround(origin: midPoint, by: 90)) }), boundingBox: boundingBox)
    }
    
    func rotatedLeft() -> InPlayBlock {
        if block == .oBlock { return self }
        if block == .iBlock {
            let transformations = [
                Set([Coordinate(0, 1), Coordinate(1, 1), Coordinate(2, 1), Coordinate(3, 1)]),
                Set([Coordinate(2, 0), Coordinate(2, 1), Coordinate(2, 2), Coordinate(2, 3)]),
                Set([Coordinate(0, 2), Coordinate(1, 2), Coordinate(2, 2), Coordinate(3, 2)]),
                Set([Coordinate(1, 0), Coordinate(1, 1), Coordinate(1, 2), Coordinate(1, 3)])
            ]
            let translated = Set(coords.map({ Coordinate($0.x - boundingBox[0].x, $0.y - boundingBox[0].y) }))
            print(translated)
            let index = transformations.firstIndex(where: { $0 == translated })!
            let rotated = Array(transformations.rotatingRight(positions: 1))
            let actual = rotated[index]
            return .init(block: block,
                         coords: actual.reduce(into: [], { $0.insert(Coordinate(boundingBox[0].x + $1.x, boundingBox[0].y + $1.y)) }),
                         boundingBox: boundingBox)
        }
        
        let midPoint = Coordinate(boundingBox[0].x+1, boundingBox[0].y+1)
        return .init(block: block, coords: coords.reduce(into: [], { $0.insert($1.rotatingAround(origin: midPoint, by: -90)) }), boundingBox: boundingBox)
    }
}

extension RangeReplaceableCollection {
    func rotatingLeft(positions: Int) -> SubSequence {
        let index = self.index(startIndex, offsetBy: positions, limitedBy: endIndex) ?? endIndex
        return self[index...] + self[..<index]
    }
    mutating func rotateLeft(positions: Int) {
        let index = self.index(startIndex, offsetBy: positions, limitedBy: endIndex) ?? endIndex
        let slice = self[..<index]
        removeSubrange(..<index)
        insert(contentsOf: slice, at: endIndex)
    }
}

extension RangeReplaceableCollection {
    func rotatingRight(positions: Int) -> SubSequence {
        let index = self.index(endIndex, offsetBy: -positions, limitedBy: startIndex) ?? startIndex
        return self[index...] + self[..<index]
    }
    mutating func rotateRight(positions: Int) {
        let index = self.index(endIndex, offsetBy: -positions, limitedBy: startIndex) ?? startIndex
        let slice = self[index...]
        removeSubrange(index...)
        insert(contentsOf: slice, at: startIndex)
    }
}
