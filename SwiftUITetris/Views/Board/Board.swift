//
//  Board.swift
//  SwiftUITetris
//
//  Created by Chris on 13/01/2022.
//

import SwiftUI

struct BoardView: View {
    let board: Board
    
    init(board: Board = Board()) {
        self.board = board
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0..<12) { _ in
                            Cube.grey
                        }
                    }.frame(height: geometry.size.width / 12)
                    ForEach(0..<20) { y in
                        HStack(spacing: 0) {
                            Cube.grey
                            ForEach(0..<10) { x in
                                if let colour = board.data[y][x] {
                                    colour.cube
                                } else {
                                    Rectangle().fill(.clear)
                                }
                            }
                            Cube.grey
                        }.frame(height: geometry.size.width / 12)
                    }
                    HStack(spacing: 0) {
                        ForEach(0..<12) { _ in
                            Cube.grey
                        }
                    }.frame(height: geometry.size.width / 12)
                }
                .background(.black)
            }
        }
    }
    
    struct Board {
        let data: [[BlockColour?]]
        let inPlayBlocks: [InPlayBlock]
//        let settledBlocks: Set<InPlayBlock>
        
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
    }
    
    enum BlockColour {
        case lightBlue
        case darkBlue
        case orange
        case yellow
        case green
        case purple
        case red
        
        var cube: Cube {
            switch self {
            case .lightBlue: return Cube.lightBlue
            case .darkBlue: return Cube.darkBlue
            case .orange: return Cube.orange
            case .yellow: return Cube.yellow
            case .green: return Cube.green
            case .purple: return Cube.purple
            case .red: return Cube.red
            }
        }
    }
    
    enum Block: CaseIterable {
        case tBlock
        case iBlock
        case zBlock
        case sBlock
        case oBlock
        case lBlock
        case jBlock
        
        var colour: BlockColour {
            switch self {
            case .iBlock: return .lightBlue
            case .jBlock: return .darkBlue
            case .lBlock: return .orange
            case .oBlock: return .yellow
            case .sBlock: return .green
            case .tBlock: return .purple
            case .zBlock: return .red
            }
        }
        
        var spawnCoordinates: Set<Coordinate> {
            switch self {
            case .tBlock: return [.init(4, 0), .init(3, 1), .init(4, 1), .init(5, 1)]
            case .iBlock: return [.init(3, 1), .init(4, 1), .init(5, 1), .init(6, 1)]
            case .zBlock: return [.init(3, 0), .init(4, 0), .init(4, 1), .init(5, 1)]
            case .sBlock: return [.init(4, 0), .init(5, 0), .init(3, 1), .init(4, 1)]
            case .oBlock: return [.init(4, 0), .init(5, 0), .init(4, 1), .init(5, 1)]
            case .lBlock: return [.init(5, 0), .init(3, 1), .init(4, 1), .init(5, 1)]
            case .jBlock: return [.init(3, 0), .init(3, 1), .init(4, 1), .init(5, 1)]
            }
        }
    }
    
    struct InPlayBlock: Hashable {
        let block: Block
        let coords: Set<Coordinate>
    }
    
//    struct BoardView_Previews: PreviewProvider {
//        static var previews: some View {
//            ScrollView {
//                VStack {
//                    
//                    ForEach(Block.allCases, id: \.self) { block in
//                        buildBoardWithColouredBlocks(coords: block.spawnCoordinates, colour: block.colour)
//                            .padding()
//                            .frame(width: 300, height: 700)
//                    }
//                }
//            }
//        }
//        
//        private static func buildBoardWithColouredBlocks(coords: Set<Coordinate>, colour: BlockColour) -> BoardView {
//            var data = Board.allNilData
//            for c in coords {
//                data[c.y][c.x] = colour
//            }
//            
//            return BoardView(board: Board(data: data))
//        }
//    }
}

struct Coordinate: Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
