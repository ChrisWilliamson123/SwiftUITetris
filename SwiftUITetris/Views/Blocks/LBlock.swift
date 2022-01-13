//
//  JBlock.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct LBlock: View {
    let rotationDegrees: CGFloat = 0
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Cube.orange.frame(width: 50).rotationEffect(.degrees(-rotationDegrees))
            HStack(spacing: 0) {
                Cube.orange.rotationEffect(.degrees(-rotationDegrees))
                Cube.orange.rotationEffect(.degrees(-rotationDegrees))
                Cube.orange.rotationEffect(.degrees(-rotationDegrees))
            }
        }.rotationEffect(.degrees(rotationDegrees))
    }
}

struct LBlock_Previews: PreviewProvider {
    static var previews: some View {
        LBlock().frame(width: 150, height: 100)
    }
}
