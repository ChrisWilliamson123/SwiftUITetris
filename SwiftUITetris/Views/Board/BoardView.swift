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
}
