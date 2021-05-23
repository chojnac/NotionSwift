//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

public struct Database {
    public typealias Identifier = EntityIdentifier<Database, UUIDv4>

    public let id: Identifier
    public let title: String
}

extension Database: Decodable {}
