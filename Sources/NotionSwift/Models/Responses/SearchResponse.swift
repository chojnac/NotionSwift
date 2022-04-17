//
//  Created by Wojciech Chojnacki on 03/06/2021.
//

import Foundation

public enum SearchResultItem {
    case page(Page)
    case database(Database)
    case unknown
    
    public var database: Database? {
        guard case .database(let value) = self else {
            return nil
        }
        return value
    }
    
    public var page: Page? {
        guard case .page(let value) = self else {
            return nil
        }
        return value
    }
}

extension SearchResultItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case object
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let object = try container.decode(String.self, forKey: .object)

        switch object {
        case "page":
            self = try .page(Page(from: decoder))
        case "database":
            self = try .database(Database(from: decoder))
        default:
            self = .unknown
        }
    }
}

public typealias SearchResponse = ListResponse<SearchResultItem>
