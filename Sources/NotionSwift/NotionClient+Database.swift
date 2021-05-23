//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

// MARK: - Databases

extension NotionClient {
    public func database(databaseId: Database.Identifier, completed: (Result<Database, Network.Errors>) -> Void) {

    }

    public func databaseQuery(databaseId: Database.Identifier, params: Any, completed: (Result<[Page], Network.Errors>) -> Void) {

    }

    public func databaseList(params: DatabaseListParams, completed: @escaping (Result<[Database], Network.Errors>) -> Void) {
        networkClient.get(
            URL(string: "/v1/databases")!,
            headers: headers(),
            completed: completed
        )
    }
}

public struct DatabaseListParams: BaseQueryParams {
    public let startCursor: String
    public let pageSize: Int32

    enum CodingKeys: String, CodingKey {
        case startCursor = "start_cursor"
        case pageSize = "page_size"
    }
}

public struct DatabaseQueryParams: BaseQueryParams {
    public let filter: String
    public let sorts: [SortObject]
    public let startCursor: String
    public let pageSize: Int32

    enum CodingKeys: String, CodingKey {
        case filter
        case sorts
        case startCursor = "start_cursor"
        case pageSize = "page_size"
    }
}
