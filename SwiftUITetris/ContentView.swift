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
                HStack(spacing: 100) {
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
                }
            }
            
        }
        
    }
    
    private func assignNextState() {
        var newBoard = board.movingLatestPiece(direction: .down)
        
        // Spawn a new piece if nothing moved
        if newBoard == board {
            let block = Block.allCases.shuffled().first!
            // We need to check if we can spawn the block
            let allBlocks = newBoard.populatedCoords
            for coord in block.spawnCoordinates {
                if allBlocks.contains(coord) { gameIsOver = true; return }
            }
            newBoard = Board(inPlayBlocks: newBoard.inPlayBlocks + [.init(block: block, coords: block.spawnCoordinates)])
        }
        
        board = newBoard
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
