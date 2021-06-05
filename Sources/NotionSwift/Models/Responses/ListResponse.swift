//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public struct ListResponse<T> {
    public let results: [T]
    public let nextCursor: Int?
    public let hasMore: Bool
}

extension ListResponse: Decodable where T: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
        case nextCursor = "next_cursor"
        case hasMore = "has_more"
    }
}
