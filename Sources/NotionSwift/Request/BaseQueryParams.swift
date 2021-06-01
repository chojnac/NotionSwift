//
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

open class BaseQueryParams: Encodable {
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

    public var asParams: [String: String] {
        var result: [String: String] = [:]

        if let value = startCursor {
            result[CodingKeys.startCursor.rawValue] = value
        }

        if let value = pageSize {
            result[CodingKeys.pageSize.rawValue] = String(value)
        }

        return result
    }
}
