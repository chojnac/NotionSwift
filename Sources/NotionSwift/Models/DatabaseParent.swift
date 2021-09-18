//
//  Created by Wojciech Chojnacki on 16/09/2021.
//

import Foundation

public enum DatabaseParent {
    case pageId(Page.Identifier)
    case workspace
    case unknown(typeName: String)
}

extension DatabaseParent: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case pageId = "page_id"
        case workspace
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if type == CodingKeys.pageId.rawValue {
            let pageId = try container.decode(Page.Identifier.self, forKey: .pageId)
            self = .pageId(pageId)
        } else if type == CodingKeys.workspace.rawValue {
            self = .workspace
        } else {
            self = .unknown(typeName: type)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .pageId(let pageId):
            try container.encode(CodingKeys.pageId.rawValue, forKey: .type)
            try container.encode(pageId, forKey: .pageId)
        case .workspace:
            try container.encode(CodingKeys.workspace.rawValue, forKey: .type)
        default:
            break
        }
    }
}
