//
//  Board.swift
//  SwiftUITetris
//
//  Created by Chris on 13/01/2022.
//

import SwiftUI

struct Board: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack(spacing: 0) {
                        ForEach(0..<12) { _ in
                            Cube.grey
                        }
                    }.frame(height: geometry.size.width / 12)
                    Spacer()
                    HStack(spacing: 0) {
                        ForEach(0..<12) { _ in
                            Cube.grey
                        }
                    }.frame(height: geometry.size.width / 12)
                }
                HStack {
                    VStack(spacing: 0) {
                        ForEach(0..<22) { _ in
                            Cube.grey
                        }
                    }.frame(width: geometry.size.width / 12)
                    Spacer()
                    VStack(spacing: 0) {
                        ForEach(0..<22) { _ in
                            Cube.grey
                        }
                    }.frame(width: geometry.size.width / 12)
                }
            }
            .background(.black)
        }
    }
}

struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board().padding()
    }
}
