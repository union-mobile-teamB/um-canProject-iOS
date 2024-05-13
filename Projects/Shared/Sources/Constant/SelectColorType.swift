

import Foundation

public enum SelectColorType: CaseIterable {
    case eggtart
    case sausage
    case lemon
    case lime
    case soda
    case grape
    case olive
    case blueberry
    case melon
    
    public var displayName: String {
        switch self {
        case .eggtart:
            return "에그타르트"
        case .sausage:
            return "소세지"
        case .lemon:
            return "레몬"
        case .lime:
            return "라임"
        case .soda:
            return "소다"
        case .grape:
            return "포도"
        case .olive:
            return "올리브"
        case .blueberry:
            return "블루베리"
        case .melon:
            return "멜론"
        }
    }
    
    public var displayColor: String {
        switch self {
        case .eggtart:
            return "#FFCF72"
        case .sausage:
            return "#FFBDBD"
        case .lemon:
            return "#FFF496"
        case .lime:
            return "#D9F273"
        case .soda:
            return "#B4E8FF"
        case .grape:
            return "#DCC0FF"
        case .olive:
            return "#CAD77A"
        case .blueberry:
            return "#C2D6FD"
        case .melon:
            return "#BCF0AF"
        }
    }
    
}
