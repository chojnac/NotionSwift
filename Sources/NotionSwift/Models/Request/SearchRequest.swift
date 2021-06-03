//
//  Created by Wojciech Chojnacki on 03/06/2021.
//

import Foundation

public struct SearchRequest {
    public struct Sort {
        public enum TimestampValue: String {
            case lastEditedTime = "last_edited_time"
        }

        public enum DirectionValue: String {
            case ascending
            case descending
        }

        public let timestamp: TimestampValue?
        public let direction: DirectionValue?

        public init(
            timestamp: TimestampValue?,
            direction: DirectionValue?
        ) {
            self.timestamp = timestamp
            self.direction = direction
        }
    }

    public struct Filter {
        public let value: String
        public let property: String
        public static let page = Filter(value: "page", property: "object")
        public static let database = Filter(value: "database", property: "object")
    }

    /// The query parameter matches against the page titles.
    /// If the query parameter is not provided, the response will contain all
    /// pages (and child pages) in the results.
    public let query: String?
    public let sort: Sort?
    /// The filter parameter can be used to query specifically for only pages
    /// or only databases.
    public let filter: Filter?
    public let startCursor: String?
    public let pageSize: Int32?

    public init(
        query: String? = nil,
        sort: SearchRequest.Sort? = nil,
        filter: SearchRequest.Filter? = nil,
        startCursor: String? = nil,
        pageSize: Int32? = nil
    ) {
        self.query = query
        self.sort = sort
        self.filter = filter
        self.startCursor = startCursor
        self.pageSize = pageSize
    }
}

extension SearchRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case query
        case sort
        case filter
        case startCursor = "start_cursor"
        case pageSize = "page_size"
    }
}

extension SearchRequest.Sort: Encodable {}
extension SearchRequest.Sort.TimestampValue: Encodable {}
extension SearchRequest.Sort.DirectionValue: Encodable {}
extension SearchRequest.Filter: Encodable {}
