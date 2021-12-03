//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public struct ListResponse<T> {
    public let results: [T]
    public let nextCursor: String?
    public let hasMore: Bool

    public init(results: [T], nextCursor: String?, hasMore: Bool) {
        self.results = results
        self.nextCursor = nextCursor
        self.hasMore = hasMore
    }
}

extension ListResponse: Decodable where T: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
        case nextCursor = "next_cursor"
        case hasMore = "has_more"
    }
}
