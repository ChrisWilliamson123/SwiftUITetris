import Foundation
import UIKit

struct Coordinate: Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    func rotatingAround(origin: Coordinate, by degrees: CGFloat) -> Coordinate {
        let dx = Double(x - origin.x)
        let dy = Double(y - origin.y)
        print(dx, dy)
        let radius = sqrt(dx * dx + dy * dy)
        print(radius)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + degrees * .pi / 180 // convert it to radians
        let newX = Double(origin.x) + radius * cos(newAzimuth)
        let newY = Double(origin.y) + radius * sin(newAzimuth)
        print(newX, newY)
        print(self, origin, Coordinate(Int(round(newX)), Int(round(newY))))
        return Coordinate(Int(round(newX)), Int(round(newY)))
    }
    
    func rotatingAround(origin: (x: Double, y: Double), by degrees: CGFloat) -> Coordinate {
        let dx = Double(x) - origin.x
        let dy = Double(y) - origin.y
        print(dx, dy)
        let radius = sqrt(dx * dx + dy * dy)
        print(radius)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + degrees * .pi / 180 // convert it to radians
        let newX = Double(origin.x) + radius * cos(newAzimuth)
        let newY = Double(origin.y) + radius * sin(newAzimuth)
        print(newX, newY)
        print(self, origin, Coordinate(Int(round(newX)), Int(round(newY))))
        return Coordinate(Int(round(newX)), Int(round(newY)))
    }
}
