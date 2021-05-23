//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

public final class NotionClient {
    private let accessKeyProvider: AccessKeyProvider
    let networkClient: NetworkClient

    private let APIVersion = "2021-05-13"

    public init(
        accessKeyProvider: AccessKeyProvider,
        networkClient: NetworkClient = DefaultNetworkClient()
    ) {
        self.accessKeyProvider = accessKeyProvider
        self.networkClient = networkClient
    }

    func headers() -> Network.HTTPHeaders {
        var headers = [
            "Notion-Version": APIVersion,
        ]
        if let accessKey = accessKeyProvider.accessKey {
            headers["Authorization"] = "Bearer \(accessKey)"
        }

        return headers
    }
}

