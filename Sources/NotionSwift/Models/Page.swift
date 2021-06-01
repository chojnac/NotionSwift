//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

/// The Page object contains **the property values** of a single Notion page.
public struct Page {
    public typealias Identifier = EntityIdentifier<Page, UUIDv4>
    public let id: Identifier
    public let created_time: Date
    public let last_edited_time: Date
    public let parent: PageParentType
    public let archived: Bool
    public let properties: [String: PageProperty]
}

extension Page: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case created_time = "created_time"
        case last_edited_time = "last_edited_time"
        case archived = "archived"
        case parent
        case properties
    }
}
