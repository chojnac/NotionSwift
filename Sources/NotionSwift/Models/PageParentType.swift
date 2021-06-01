//
//  File.swift
//  
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
    enum CodingKeys: CodingKey {
        case type
        case page_id
        case database_id
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type).lowercased()
        switch type {
        case "database_id":
            let value = try container.decode(String.self, forKey: .database_id)
            self = .database(.init(value))
        case "page_id":
            let value = try container.decode(String.self, forKey: .page_id)
            self = .page(.init(value))
        case "workspace":
            self = .workspace
        default:
            self = .unknown
        }
    }
}
