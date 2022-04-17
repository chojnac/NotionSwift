//
//  Created by Wojciech Chojnacki on 17/04/2022.
//
import Foundation

public enum BlockColor: Equatable {
    case `default`
    case gray
    case brown
    case orange
    case yellow
    case green
    case blue
    case purple
    case pink
    case red
    case grayBackground
    case brownBackground
    case orangeBackground
    case yellowBackground
    case greenBackground
    case blueBackground
    case purpleBackground
    case pinkBackground
    case redBackground
    case unknown(String)
    
    init?(_ rawValue: String) {
        let cases: [Self] = [.default,
                     .gray,
                     .brown,
                     .orange,
                     .yellow,
                     .green,
                     .blue,
                     .purple,
                     .pink,
                     .red,
                     .grayBackground,
                     .brownBackground,
                     .orangeBackground,
                     .yellowBackground,
                     .greenBackground,
                     .blueBackground,
                     .purpleBackground,
                     .pinkBackground,
                     .redBackground
        ]
        let value = rawValue.lowercased().trimmingCharacters(in: CharacterSet.whitespaces)
        guard let item = cases.first(where: { $0.rawValue == value }) else {
            return nil
        }
        
        self = item
    }
    
    public var rawValue: String {
        switch self {
        case .default:
            return "default"
        case .gray:
            return "gray"
        case .brown:
            return "brown"
        case .orange:
            return "orange"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        case .blue:
            return "blue"
        case .purple:
            return "purple"
        case .pink:
            return "pink"
        case .red:
            return "red"
        case .grayBackground:
            return "gray_background"
        case .brownBackground:
            return "brown_background"
        case .orangeBackground:
            return "orange_background"
        case .yellowBackground:
            return "yellow_background"
        case .greenBackground:
            return "green_background"
        case .blueBackground:
            return "blue_background"
        case .purpleBackground:
            return "purple_background"
        case .pinkBackground:
            return "pink_background"
        case .redBackground:
            return "red_background"
        case .unknown(let value):
            return value
        }
    }
}

extension BlockColor: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let value = Self(rawValue) else {
            self = .unknown(rawValue)
            return
        }
        
        self = value
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
