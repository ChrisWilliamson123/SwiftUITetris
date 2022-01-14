enum Block: CaseIterable {
    case tBlock
    case iBlock
    case zBlock
    case sBlock
    case oBlock
    case lBlock
    case jBlock
    
    var colour: BlockColour {
        switch self {
        case .iBlock: return .lightBlue
        case .jBlock: return .darkBlue
        case .lBlock: return .orange
        case .oBlock: return .yellow
        case .sBlock: return .green
        case .tBlock: return .purple
        case .zBlock: return .red
        }
    }
    
    var spawnCoordinates: Set<Coordinate> {
        switch self {
        case .tBlock: return [.init(4, 0), .init(3, 1), .init(4, 1), .init(5, 1)]
        case .iBlock: return [.init(3, 1), .init(4, 1), .init(5, 1), .init(6, 1)]
        case .zBlock: return [.init(3, 0), .init(4, 0), .init(4, 1), .init(5, 1)]
        case .sBlock: return [.init(4, 0), .init(5, 0), .init(3, 1), .init(4, 1)]
        case .oBlock: return [.init(4, 0), .init(5, 0), .init(4, 1), .init(5, 1)]
        case .lBlock: return [.init(5, 0), .init(3, 1), .init(4, 1), .init(5, 1)]
        case .jBlock: return [.init(3, 0), .init(3, 1), .init(4, 1), .init(5, 1)]
        }
    }
}

enum BlockColour {
    case lightBlue
    case darkBlue
    case orange
    case yellow
    case green
    case purple
    case red
    
    var cube: Cube {
        switch self {
        case .lightBlue: return Cube.lightBlue
        case .darkBlue: return Cube.darkBlue
        case .orange: return Cube.orange
        case .yellow: return Cube.yellow
        case .green: return Cube.green
        case .purple: return Cube.purple
        case .red: return Cube.red
        }
    }
}
