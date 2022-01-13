//
//  IBlock.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct IBlock: View {
    let rotationDegrees: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 0) {
            Cube.lightBlue.rotationEffect(.degrees(-rotationDegrees))
            Cube.lightBlue.rotationEffect(.degrees(-rotationDegrees))
            Cube.lightBlue.rotationEffect(.degrees(-rotationDegrees))
            Cube.lightBlue.rotationEffect(.degrees(-rotationDegrees))
        }.rotationEffect(.degrees(rotationDegrees))
    }
}

struct IBlock_Previews: PreviewProvider {
    static var previews: some View {
        IBlock().frame(width: 200, height: 50)
    }
}
