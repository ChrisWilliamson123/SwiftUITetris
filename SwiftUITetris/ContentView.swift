//
//  ContentView.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var board: Board = Board()
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    @State private var gameIsOver = false
    
    var body: some View {
        if gameIsOver {
            Text("Game Over!").font(.largeTitle).foregroundColor(.red)
            Button("New Game") {
                gameIsOver = false
                board = Board()
            }
        } else {
            VStack {
                BoardView(board: board)
                    .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
                    .onReceive(timer) { _ in assignNextState() }
                HStack(spacing: 32) {
                    Button {
                        board = board.rotatingLatestPiece(.left)
                    } label: {
                        Image(systemName: "arrow.counterclockwise.circle.fill").resizable().frame(width: 44, height: 44)
                    }
                    Button {
                        board = board.movingLatestPiece(direction: .left)
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill").resizable().frame(width: 44, height: 44)
                    }
                    Button {
                        board = board.movingLatestPiece(direction: .right)
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill").resizable().frame(width: 44, height: 44)
                    }
                    Button {
                        board = board.rotatingLatestPiece(.right)
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill").resizable().frame(width: 44, height: 44)
                    }
                }
            }
            
        }
        
    }
    
    private func assignNextState() {
        var newBoard = board.movingLatestPiece(direction: .down)
        
        if newBoard == board {
            /*
             Need to split out some logic here, we have:
             1. Clear line(s)
             2. Spawn a new block
             3. End the game
             */
            newBoard = Board(data: newBoard.data, fallingPiece: nil)
            if !board.completeLineRanges.isEmpty {
                var postLineRemovalData = newBoard.data
                // Go through the ranges and remove the lines
                for r in board.completeLineRanges {
                    for y in r {
                        postLineRemovalData[y] = Array(repeating: nil, count: postLineRemovalData[y].count)
                    }
                    // Now need to move all lines before range down
                    // Can first build up an array of data which should fill the gap AND above
                    var newData = Array(postLineRemovalData[0..<r.lowerBound])
                    while newData.count != r.upperBound+1 {
                        newData.insert(Array(repeating: nil, count: newBoard.data[0].count), at: 0)
                    }
                    postLineRemovalData = newData
                }
                newBoard = Board(data: postLineRemovalData, fallingPiece: newBoard.fallingPiece)
            }
            
            let block = Block.allCases.shuffled().first!
            // We need to check if we can spawn the block
            let allBlocks = newBoard.populatedCoords
            for coord in block.spawnCoordinates {
                if allBlocks.contains(coord) { gameIsOver = true; return }
            }
            
            let newBlock = InPlayBlock(block: block,
                                       coords: block.spawnCoordinates,
                                       boundingBox: block.initialBoundingBox)
            var newData = newBoard.data
            newBlock.coords.forEach({ newData[$0.y][$0.x] = newBlock.block.colour })
            newBoard = Board(data: newData, fallingPiece: newBlock)
        }
        
        board = newBoard
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
