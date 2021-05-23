//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public typealias UUIDv4 = String

public struct EntityIdentifier<Marker, T: Codable> {
    public let rawValue: T

    public init(_ rawValue: T) {
        self.rawValue = rawValue
    }
}

extension EntityIdentifier: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(T.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
