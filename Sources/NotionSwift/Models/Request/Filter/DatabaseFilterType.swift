//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public enum DatabaseFilterType {
    case databaseProperty(DatabasePropertyFilter)
    case compound(CompountFilterType)
}

extension DatabaseFilterType: Encodable {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .databaseProperty(let value):
            try value.encode(to: encoder)
        case .compound(let value):
            try value.encode(to: encoder)
        }
    }
}
