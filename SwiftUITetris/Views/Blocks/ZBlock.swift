//
//  SBlock.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct ZBlock: View {
    let rotationDegrees: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Cube.red.rotationEffect(.degrees(-rotationDegrees))
                Cube.red.rotationEffect(.degrees(-rotationDegrees))
                Rectangle().fill(.clear).frame(width: 50)
            }
            HStack(spacing: 0) {
                Rectangle().fill(.clear).frame(width: 50)
                Cube.red.rotationEffect(.degrees(-rotationDegrees))
                Cube.red.rotationEffect(.degrees(-rotationDegrees))
            }
        }.rotationEffect(.degrees(rotationDegrees))
    }
}

struct ZBlock_Previews: PreviewProvider {
    static var previews: some View {
        ZBlock().frame(width: 150, height: 100)
    }
}
