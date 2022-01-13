//
//  IsoscelesTrapezium.swift
//  SwiftUITetris
//
//  Created by Chris on 12/01/2022.
//

import SwiftUI

struct IsoscelesTrapezium: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // 0.13% for inner bits
        path.move(to: CGPoint(x: rect.minY, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.133, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.866, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

struct IsoscelesTrapezium_Previews: PreviewProvider {
    static var previews: some View {
        IsoscelesTrapezium().fill(.red).frame(width: 200, height: 100).background(.blue)
    }
}
