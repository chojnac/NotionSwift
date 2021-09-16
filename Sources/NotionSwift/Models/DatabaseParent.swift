//
//  DatabaseParent.swift
//  NotionSwift
//
//  Created by Wojciech Chojnacki on 16/09/2021.
//

import Foundation

public enum DatabaseParent {
    case page(pageId: Page.Identifier)
    case workspace
    case unknown(typeName: String)
}

extension DatabaseParent: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case pageId = "page_id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if type == "page" {
            let pageId = try container.decode(Page.Identifier.self, forKey: .pageId)
            self = .page(pageId: pageId)
        } else if type == "workspace" {
            self = .workspace
        } else {
            self = .unknown(typeName: type)
        }
    }
}
