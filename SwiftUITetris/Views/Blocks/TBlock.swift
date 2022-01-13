//
//  TBlock.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct TBlock: View {
    let rotationDegrees: CGFloat = 0

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 0) {
                Cube.purple.rotationEffect(.degrees(-rotationDegrees)).frame(width: 50)
            }
            HStack(spacing: 0) {
                Cube.purple.rotationEffect(.degrees(-rotationDegrees))
                Cube.purple.rotationEffect(.degrees(-rotationDegrees))
                Cube.purple.rotationEffect(.degrees(-rotationDegrees))
            }
        }.rotationEffect(.degrees(rotationDegrees))
    }
}

struct TBlock_Previews: PreviewProvider {
    static var previews: some View {
        TBlock().frame(width: 150, height: 100)
    }
}
