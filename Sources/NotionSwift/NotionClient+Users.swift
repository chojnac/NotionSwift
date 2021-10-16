//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

// MARK: - Users

extension NotionClient {

    public func user(
        userId: User.Identifier,
        completed: @escaping (Result<User, NotionClientError>) -> Void
    ) {
        networkClient.get(
            urlBuilder.url(path: "/v1/users/{identifier}", identifier: userId),
            headers: headers(),
            completed: completed
        )
    }

    public func usersList(
        params: BaseQueryParams,
        completed: @escaping (Result<ListResponse<User>, NotionClientError>) -> Void
    ) {
        networkClient.get(
            urlBuilder.url(path: "/v1/users", params: params.asParams),
            headers: headers(),
            completed: completed
        )
    }

    public func usersMe(
        completed: @escaping (Result<User, NotionClientError>) -> Void
    ) {
        networkClient.get(
            urlBuilder.url(path: "/v1/users/me"),
            headers: headers(),
            completed: completed
        )
    }
}
