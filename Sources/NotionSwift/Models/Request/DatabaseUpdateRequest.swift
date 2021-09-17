//
//  Created by Wojciech Chojnacki on 17/09/2021.
//

import Foundation

public struct DatabaseUpdateRequest {
    public let title: [RichText]?
    public let icon: IconFile?
    public let cover: CoverFile?
    public let properties: [Database.PropertyName: DatabasePropertyType?]

    public init(
        title: [RichText]?,
        icon: IconFile?,
        cover: CoverFile?,
        properties: [Database.PropertyName: DatabasePropertyType?]
    ) {
        self.title = title
        self.icon = icon
        self.cover = cover
        self.properties = properties
    }
}

extension DatabaseUpdateRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case title
        case icon
        case cover
        case properties
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(icon, forKey: .icon)
        try container.encodeIfPresent(cover, forKey: .cover)
        try container.encode(properties, forKey: .properties)
    }
}
