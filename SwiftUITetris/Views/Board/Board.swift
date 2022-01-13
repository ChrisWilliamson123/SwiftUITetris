//
//  Board.swift
//  SwiftUITetris
//
//  Created by Chris on 13/01/2022.
//

import SwiftUI

struct BoardView: View {
    let board: Board
    
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
        
        init(data: [[BlockColour?]]? = nil) {
            if let data = data {
                self.data = data
                return
            }
            
            // Initialise data to be all clear
            self.data = Array(repeating: Array(repeating: nil, count: 10), count: 20)
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
    
    struct Coordinate {
        let x: Int
        let y: Int
        
        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
    }
    
    struct BoardView_Previews: PreviewProvider {
        static var previews: some View {
            BoardView(board: Board(data: [
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, .lightBlue],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, .lightBlue],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, .lightBlue],
                [.red, nil, nil, nil, nil, nil, nil, nil, nil, .lightBlue]
            ])).padding()
        }
    }
}
