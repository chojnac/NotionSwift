//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

// MARK: - Databases

extension NotionClient {
    public func database(
        databaseId: Database.Identifier,
        completed: @escaping (Result<Database, Network.Errors>) -> Void
    ) {
        networkClient.get(
            urlBuilder.url(
                path: "/v1/databases/{identifier}",
                identifier: databaseId
            ),
            headers: headers(),
            completed: completed
        )
    }

    public func databaseQuery(
        databaseId: Database.Identifier,
        params: DatabaseQueryParams,
        completed: @escaping (Result<ListResponse<Page>, Network.Errors>) -> Void
    ) {
        networkClient.post(
            urlBuilder.url(
                path: "/v1/databases/{identifier}/query",
                identifier: databaseId
            ),
            body: params,
            headers: headers(),
            completed: completed
        )
    }

    public func databaseList(
        params: BaseQueryParams,
        completed: @escaping (Result<ListResponse<Database>, Network.Errors>) -> Void
    ) {

        networkClient.get(
            urlBuilder.url(path: "/v1/databases"),
            headers: headers(),
            completed: completed
        )
    }
}
