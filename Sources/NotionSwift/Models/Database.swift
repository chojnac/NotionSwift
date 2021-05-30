//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

public struct Database {
    public typealias Identifier = EntityIdentifier<Database, UUIDv4>
    public typealias PropertyName = String
    public let id: Identifier
    public let title: [RichText]
    public let created_time: Date
    public let last_edited_time: Date
    public let properties: [PropertyName: DatabaseProperty]
}

extension Database: Decodable {}
