//
//  ContentView.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var board: BoardView.Board = BoardView.Board()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    @State private var gameIsOver = false
    
    var body: some View {
        if gameIsOver {
            Text("Game Over!").font(.largeTitle).foregroundColor(.red)
            Button("New Game") {
                gameIsOver = false
                counter = 0
                board = BoardView.Board()
            }
        } else {
            VStack {
                BoardView(board: board)
                    .padding()
                    .onReceive(timer) { _ in
                        assignNextState(timerValue: counter)
                        counter += 1
                    }
                HStack(spacing: 100) {
                    Button {
                        movePieceLeft()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill").resizable().frame(width: 44, height: 44)
                    }
                    Button {
                        movePieceRight()
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill").resizable().frame(width: 44, height: 44)
                    }
                }
            }
            
        }
        
    }
    
    private func movePieceRight() {
        guard let latestPiece = board.inPlayBlocks.last else { return }
        print(latestPiece)
        let coordsOfOtherBlocks = Set(board.inPlayBlocks.map({ $0.coords }).flatMap({ $0 }))
        let coordsRightOf: [Coordinate] = latestPiece.coords.compactMap({ coord in
            let right = Coordinate(coord.x+1, coord.y)
            if latestPiece.coords.contains(right) { return nil }
            return right
        })
        
        print(coordsRightOf)
        
        for rightCoord in coordsRightOf {
            if coordsOfOtherBlocks.contains(rightCoord) || rightCoord.x >= 10 {
                return
            }
        }
        
        var newBlocks = board.inPlayBlocks.filter({ $0 != latestPiece })
        newBlocks.append(.init(block: latestPiece.block, coords: latestPiece.coords.reduce(into: [], { $0.insert(.init($1.x+1, $1.y)) })))
        
        board = BoardView.Board(inPlayBlocks: newBlocks)
    }
    
    private func movePieceLeft() {
        guard let latestPiece = board.inPlayBlocks.last else { return }
        print(latestPiece)
        let coordsOfOtherBlocks = Set(board.inPlayBlocks.map({ $0.coords }).flatMap({ $0 }))
        let coordsLeftOf: [Coordinate] = latestPiece.coords.compactMap({ coord in
            let left = Coordinate(coord.x-1, coord.y)
            if latestPiece.coords.contains(left) { return nil }
            return left
        })
        
        print(coordsLeftOf)
        
        for leftCoord in coordsLeftOf {
            if coordsOfOtherBlocks.contains(leftCoord) || leftCoord.x < 0 {
                return
            }
        }
        
        var newBlocks = board.inPlayBlocks.filter({ $0 != latestPiece })
        newBlocks.append(.init(block: latestPiece.block, coords: latestPiece.coords.reduce(into: [], { $0.insert(.init($1.x-1, $1.y)) })))
        
        board = BoardView.Board(inPlayBlocks: newBlocks)
    }
    
    private func assignNextState(timerValue: Int) {
        let oldInPlayBlocks = board.inPlayBlocks
        var newInPlayBlocks: [BoardView.InPlayBlock] = []
        
        // Move existing pieces down one
        for block in oldInPlayBlocks {
            let shouldMoveDown = shouldMoveBlockDown(block: block, otherBlocks: Set(oldInPlayBlocks))
            if shouldMoveDown {
                newInPlayBlocks.append(.init(block: block.block, coords: block.coords.reduce(into: [], { $0.insert(.init($1.x, $1.y+1)) })))
            } else {
                newInPlayBlocks.append(block)
            }
        }
        
        // Spawn a new piece if nothing moved
        if newInPlayBlocks == oldInPlayBlocks {
            let block = BoardView.Block.allCases.shuffled().first!
            // We need to check if we can spawn the block
            let allNewBlocks = newInPlayBlocks.map({ $0.coords }).flatMap({ $0 })
            for coord in block.spawnCoordinates {
                if allNewBlocks.contains(coord) { gameIsOver = true; return }
            }
            newInPlayBlocks.append(.init(block: block, coords: block.spawnCoordinates))
        }
        
        
        
        board = BoardView.Board(inPlayBlocks: newInPlayBlocks)
    }
    
    private func shouldMoveBlockDown(block: BoardView.InPlayBlock, otherBlocks: Set<BoardView.InPlayBlock>) -> Bool {
        let coordsOfOtherBlocks = Set(otherBlocks.map({ $0.coords }).flatMap({ $0 }))
        let coordsUnderPiece: [Coordinate] = block.coords.compactMap({ coord in
            let under = Coordinate(coord.x, coord.y + 1)
            if block.coords.contains(under) { return nil }
            return under
        })
//        print(coordsUnderPiece)
        
        // If all of the blocks under the bottom blocks are empty, we can move the piece
        for underCoord in coordsUnderPiece {
            if underCoord.y == 20 { return false }
            if coordsOfOtherBlocks.contains(underCoord) {
                return false
            }
        }
        
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
