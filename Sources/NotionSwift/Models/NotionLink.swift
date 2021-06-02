//
//  Created by Wojciech Chojnacki on 02/06/2021.
//

import Foundation

public struct NotionLink {
    public let url: String?

    public init(url: String?) {
        self.url = url
    }
}

extension NotionLink: Codable {}
