//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

// MARK: - Databases

extension NotionClient {
    public func database(databaseId: Database.Identifier, completed: @escaping (Result<Database, Network.Errors>) -> Void) {
        networkClient.get(
            URL(string: "/v1/databases/\(databaseId.rawValue)", relativeTo: Network.notionBaseURL  )!,
            headers: headers(),
            completed: completed
        )
    }

    public func databaseQuery(databaseId: Database.Identifier, params: DatabaseQueryParams = .init(), completed: @escaping (Result<ListResponse<Page>, Network.Errors>) -> Void) {
        networkClient.post(
            URL(string: "/v1/databases/\(databaseId.rawValue)/query", relativeTo: Network.notionBaseURL)!,
            body: params,
            headers: headers(),
            completed: completed
        )
    }

    public func databaseList(
        params: DatabaseListParams = .init(),
        completed: @escaping (Result<ListResponse<Database>, Network.Errors>) -> Void
    ) {

        networkClient.get(
            URL(string: "/v1/databases", relativeTo: Network.notionBaseURL  )!,
            headers: headers(),
            completed: completed
        )
    }
}

public struct DatabaseListParams: BaseQueryParams {
    public let startCursor: String?
    public let pageSize: Int32?

    enum CodingKeys: String, CodingKey {
        case startCursor = "start_cursor"
        case pageSize = "page_size"
    }

    public init(startCursor: String? = nil, pageSize: Int32? = nil) {
        self.startCursor = startCursor
        self.pageSize = pageSize
    }
}

public struct DatabaseQueryParams: BaseQueryParams {
    public let filter: String?
    public let sorts: [SortObject]?
    public let startCursor: String?
    public let pageSize: Int32?

    enum CodingKeys: String, CodingKey {
        case filter
        case sorts
        case startCursor = "start_cursor"
        case pageSize = "page_size"
    }

    public init(filter: String? = nil, sorts: [SortObject]? = nil, startCursor: String? = nil, pageSize: Int32? = nil) {
        self.filter = filter
        self.sorts = sorts
        self.startCursor = startCursor
        self.pageSize = pageSize
    }

}
