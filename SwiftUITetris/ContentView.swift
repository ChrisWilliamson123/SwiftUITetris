//
//  ContentView.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var board: Board = Board()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
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
                    .padding()
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
            if !board.fullLines.isEmpty {
                // Remove the line and move everything above down one
                
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
