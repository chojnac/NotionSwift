//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

/// The Page object contains **the property values** of a single Notion page.
public struct Page {
    public typealias Identifier = EntityIdentifier<Page, UUIDv4>
    public typealias PropertyName = String
    public let id: Identifier
    public let createdTime: Date
    public let lastEditedTime: Date
    public let parent: PageParentType
    public let archived: Bool
    public let properties: [PropertyName: PageProperty]
}

extension Page: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
        case archived
        case parent
        case properties
    }
}
