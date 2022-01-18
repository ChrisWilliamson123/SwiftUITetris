//
//  ContentView.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var board: Board = Board()
    let timer = Timer.publish(every: 0.0167, on: .main, in: .common).autoconnect()
    @State private var gameIsOver = false
    @State private var score = 0
    @State private var level = 1
    @State private var lastMoveTime: Double = 0
    @State private var time: Double = 0
    
    var body: some View {
        if gameIsOver {
            Text("Game Over!").font(.largeTitle).foregroundColor(.red)
            Button("New Game") {
                gameIsOver = false
                board = Board()
            }
        } else {
            GeometryReader { geometry in
                VStack {
                    Text("Score: \(score)").font(.largeTitle).padding()
                    BoardView(board: board)
                        .padding(EdgeInsets(top: 32, leading: 64, bottom: 32, trailing: 64))
                        .onReceive(timer) { _ in
                            time += 0.0167
                            tick()
                        }
                    Spacer()
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
    }
    
    /// Applies non-user inputted behaviour such as dropping a piece to the next line, deleting full lines, spawning new pieces.
    private func tick() {
        // If there's no piece in play then spawn another if we're allowed
        if board.fallingPiece == nil {
            attemptNewBlockSpawn()
            return
        }
        
        // We haven't attempted to spawn a new block, see if we can move the board down
        let gameSpeed: Double = 0.25
        if time - lastMoveTime >= gameSpeed {
            var newBoard: Board
            if !board.completeLineRanges.isEmpty {
                newBoard = board.clearingLines()
                increaseScoreUsingLineRanges(board.completeLineRanges)
            } else {
                newBoard = board.movingLatestPiece(direction: .down)
                // We need to check if a piece is still moving
                if newBoard == board {
                    // couldn't move the piece, so replace board with newboard without in play piece
                    newBoard = Board(data: newBoard.data, fallingPiece: nil)
                }
            }
            lastMoveTime = time
            board = newBoard
        }
        
    }
    
    private func attemptNewBlockSpawn() {
        print("Attempting to spawn new block")
        let blockToSpawn = Block.allCases.shuffled().first!
        if canSpawnNewBlock(blockToSpawn, in: board) {
            // Spawn it
            let newBlock = InPlayBlock(block: blockToSpawn,
                                       coords: blockToSpawn.spawnCoordinates,
                                       boundingBox: blockToSpawn.initialBoundingBox)
            var newData = board.data
            newBlock.coords.forEach({ newData[$0.y][$0.x] = newBlock.block.colour })
            board = Board(data: newData, fallingPiece: newBlock)
            lastMoveTime = time
        } else {
            gameIsOver = true
        }
    }
    
    private func canSpawnNewBlock(_ block: Block, in board: Board) -> Bool {
        let allBlocks = board.populatedCoords
        for coord in block.spawnCoordinates {
            if allBlocks.contains(coord) {
                return false
            }
        }
        return true
    }

    private func increaseScoreUsingLineRanges(_ ranges: [ClosedRange<Int>]) {
        for r in ranges {
            switch r.count {
            case 1: score += 100 * level
            case 2: score += 300 * level
            case 3: score += 500 * level
            case 4: score += 800 * level
            default: break
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
