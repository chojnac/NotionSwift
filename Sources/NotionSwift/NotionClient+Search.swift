//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

// MARK: - Search

extension NotionClient {
    public func search(
        request: SearchRequest,
        completed: @escaping (Result<SearchResponse, Network.Errors>) -> Void
    ) {
        networkClient.post(
            urlBuilder.url(path: "/v1/search"),
            body: request,
            headers: headers(),
            completed: completed
        )
    }
}
