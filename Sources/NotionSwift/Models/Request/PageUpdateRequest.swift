//
//  Created by Wojciech Chojnacki on 03/06/2021.
//

import Foundation

public struct PageUpdateRequest {
    public enum Key: Hashable, Equatable  {
        case name(Page.PropertyName)
        case id(PageProperty.Identifier)
    }

    public let properties: [Key: WritePageProperty]?
    public let archived: Bool?
    public let icon: IconFile?
    public let cover: CoverFile?

    public init(
        properties: [Key: WritePageProperty]? = nil,
        archived: Bool? = nil,
        icon: IconFile? = nil,
        cover: CoverFile? = nil
    ) {
        self.properties = properties
        self.archived = archived
        self.icon = icon
        self.cover = cover
    }

}

extension PageUpdateRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case properties
        case archived
        case icon
        case cover
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let properties = self.properties {
            // default encoder wasn't happy with out properties type and was converting it to an array.
            let entries: [(String, WritePageProperty)] = properties.map { entry in
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
        try container.encodeIfPresent(archived, forKey: .archived)
        try container.encodeIfPresent(icon, forKey: .icon)
        try container.encodeIfPresent(cover, forKey: .cover)
    }
}

extension PageUpdateRequest.Key: Encodable {
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
