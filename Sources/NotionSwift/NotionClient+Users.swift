//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

// MARK: - Users

extension NotionClient {

    public func user(
        userId: User.Identifier,
        completed: @escaping (Result<User, Network.Errors>) -> Void
    ) {
        networkClient.get(
            urlBuilder.url(path: "/v1/users/{identifier}", identifier: userId),
            headers: headers(),
            completed: completed
        )
    }

    public func usersList(
        params: BaseQueryParams = .init(),
        completed: @escaping (Result<ListResponse<User>, Network.Errors>) -> Void
    ) {
        networkClient.get(
            urlBuilder.url(path: "/v1/users", params: params.asParams),
            headers: headers(),
            completed: completed
        )
    }
}
