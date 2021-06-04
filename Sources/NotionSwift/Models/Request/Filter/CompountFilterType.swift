//
//  Created by Wojciech Chojnacki on 02/06/2021.
//

import Foundation

public enum CompountFilterType {
    case or([DatabaseFilterType])
    case and([DatabaseFilterType])
}

// MARK: - Codable

extension CompountFilterType: Encodable {
    enum CodingKeys: String, CodingKey {
        case and
        case or
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .and(let value):
            try container.encode(value, forKey: .and)
        case .or(let value):
            try container.encode(value, forKey: .or)
        }
    }
}
