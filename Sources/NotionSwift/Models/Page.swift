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
    public let archived: Bool
    //public let properties: [String: PageProperty]
}

public struct PageProperty {
    public enum PropertyType {
        case rich_text
        case number
        case select
        case multi_select
        case date
        case formula
        case relation
        case rollup
        case title
        case people
        case files
        case checkbox
        case url
        case email
        case phone_number
        case created_time
        case created_by
        case last_edited_time
        case last_edited_by
    }
    public let id: String
    public let type: PropertyType
}

extension Page: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case created_time = "created_time"
        case last_edited_time = "last_edited_time"
        case archived = "archived"
    }
}

//extension PageProperty: Decodable {
//
//}

//extension PageProperty.PropertyType: Decodable {
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: GenericCodingKeys.self)
//    }
//}
