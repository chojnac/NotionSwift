//
//  Created by Wojciech Chojnacki on 30/05/2021.
//

import Foundation

public enum PageParentType {
    case database(Database.Identifier)
    case page(Page.Identifier)
    case workspace
    case unknown
}

extension PageParentType: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case pageId = "page_id"
        case databaseId = "database_id"
        case workspace
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type).lowercased()
        switch type {
        case CodingKeys.databaseId.stringValue:
            let value = try container.decode(String.self, forKey: .databaseId)
            self = .database(.init(value))
        case CodingKeys.pageId.stringValue:
            let value = try container.decode(String.self, forKey: .pageId)
            self = .page(.init(value))
        case CodingKeys.workspace.stringValue:
            self = .workspace
        default:
            self = .unknown
        }
    }
}
