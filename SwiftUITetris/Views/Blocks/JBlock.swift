//
//  JBlock.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct JBlock: View {
    let rotationDegrees: CGFloat = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Cube.darkBlue.frame(width: 50).rotationEffect(.degrees(-rotationDegrees))
            HStack(spacing: 0) {
                Cube.darkBlue.rotationEffect(.degrees(-rotationDegrees))
                Cube.darkBlue.rotationEffect(.degrees(-rotationDegrees))
                Cube.darkBlue.rotationEffect(.degrees(-rotationDegrees))
            }
        }.rotationEffect(.degrees(rotationDegrees))
    }
}

struct JBlock_Previews: PreviewProvider {
    static var previews: some View {
        JBlock().frame(width: 150, height: 100)
    }
}
