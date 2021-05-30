//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

// MARK: - Pages

extension NotionClient {

    public func page(pageId: Page.Identifier, completed: @escaping (Result<Page, Network.Errors>) -> Void) {
        networkClient.get(
            URL(string: "/v1/pages/\(pageId.rawValue)", relativeTo: Network.notionBaseURL  )!,
            headers: headers(),
            completed: completed
        )
    }

    public func pageCreate(request: Any, completed: (Result<Page, Network.Errors>) -> Void) {

    }

    public func pageUpdate(pageId: Page.Identifier, properties: Any, completed: (Result<Page, Network.Errors>) -> Void) {

    }
}
