//
//  Created by Wojciech Chojnacki on 03/06/2021.
//

import Foundation

public struct PageProperiesUpdateRequest {
    public enum Key: Hashable, Equatable  {
        case name(Page.PropertyName)
        case id(PageProperty.Identifier)
    }

    public let properties: [Key: WritePageProperty]

    public init(properties: [Key: WritePageProperty]) {
        self.properties = properties
    }
}

extension PageProperiesUpdateRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case properties
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // default encoder wasn't happy with out properties type and was converting it to an array.
        let entries: [(String, WritePageProperty)] = self.properties.map { entry in
            let key: String
            switch entry.0 {
            case .name(let value):
                key = value
            case .id(let value):
                key = value.rawValue
            }
            return (key, entry.1)
        }

        let properties = Dictionary(uniqueKeysWithValues: entries)
        try container.encode(properties, forKey: .properties)
    }
}

extension PageProperiesUpdateRequest.Key: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .name(let value):
            try container.encode(value)
        case .id(let value):
            try container.encode(value)
        }
    }
}
