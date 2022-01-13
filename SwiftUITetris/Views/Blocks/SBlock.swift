//
//  SBlock.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct SBlock: View {
    let rotationDegrees: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Rectangle().fill(.clear).frame(width: 50)
                Cube.green.rotationEffect(.degrees(-rotationDegrees))
                Cube.green.rotationEffect(.degrees(-rotationDegrees))
            }
            HStack(spacing: 0) {
                Cube.green.rotationEffect(.degrees(-rotationDegrees))
                Cube.green.rotationEffect(.degrees(-rotationDegrees))
                Rectangle().fill(.clear).frame(width: 50)
            }
        }.rotationEffect(.degrees(rotationDegrees))
    }
}

struct SBlock_Previews: PreviewProvider {
    static var previews: some View {
        SBlock().frame(width: 150, height: 100)
    }
}
