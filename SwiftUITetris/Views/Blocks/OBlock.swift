//
//  OBlock.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct OBlock: View {

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Cube.yellow
                Cube.yellow
            }
                   HStack(spacing: 0) {
                Cube.yellow
                Cube.yellow
            }
        }
    }
}

struct OBlock_Previews: PreviewProvider {
    static var previews: some View {
        OBlock().frame(width: 100, height: 100)
    }
}
