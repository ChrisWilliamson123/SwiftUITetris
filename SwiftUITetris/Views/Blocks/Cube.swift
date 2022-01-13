import SwiftUI

//108,236,239
struct Cube: View {
    static let lightBlue: Cube = Cube(colour: UIColor(red: 108/255, green: 236/255, blue: 239/255, alpha: 1))
    static let darkBlue: Cube = Cube(colour: UIColor(red: 0/255, green: 31/255, blue: 230/255, alpha: 1))
    static let orange: Cube = Cube(colour: UIColor(red: 229/255, green: 162/255, blue: 56/255, alpha: 1))
    static let yellow: Cube = Cube(colour: UIColor(red: 242/255, green: 238/255, blue: 79/255, alpha: 1))
    static let green: Cube = Cube(colour: UIColor(red: 110/255, green: 234/255, blue: 71/255, alpha: 1))
    static let purple: Cube = Cube(colour: UIColor(red: 145/255, green: 44/255, blue: 232/255, alpha: 1))
    static let red: Cube = Cube(colour: UIColor(red: 221/255, green: 47/255, blue: 33/255, alpha: 1))
    
    let colour: UIColor

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(uiColor: colour))
            TopShade().fill(Color(uiColor: colour.lighter(by: 30)!))
            BottomShade().fill(Color(uiColor: colour.darker(by: 50)!))
            LeftShade().fill(Color(uiColor: colour.darker(by: 15)!))
            RightShade().fill(Color(uiColor: colour.darker(by: 15)!))
        }
    }
    
    struct BottomShade: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: .init(x: rect.maxX*0.133, y: rect.maxY*0.866))
            path.addLine(to: .init(x: rect.maxX * 0.866, y: rect.maxY*0.866))
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            
            return path
        }
    }
    
    struct TopShade: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX * 0.866, y: rect.maxY*0.133))
            path.addLine(to: .init(x: rect.maxX*0.133, y: rect.maxY*0.133))
            
            return path
        }
    }
    
    struct LeftShade: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX*0.133, y: rect.maxY*0.133))
            path.addLine(to: .init(x: rect.maxX * 0.133, y: rect.maxY*0.866))
            path.addLine(to: .init(x: rect.minX, y: rect.maxY))
            
            return path
        }
    }
    
    struct RightShade: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX*0.866, y: rect.maxY*0.133))
            path.addLine(to: .init(x: rect.maxX * 0.866, y: rect.maxY*0.866))
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            
            return path
        }
    }
}

struct Cube_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            Cube.lightBlue
            Cube.darkBlue
            Cube.orange
            Cube.yellow
            Cube.green
            Cube.purple
            Cube.red
        }
    }
}
