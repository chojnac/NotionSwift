//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

/// Just a placeholder entity. User ReadBlock / WriteBlock structs.
public enum Block {
    public typealias Identifier = EntityIdentifier<Block, UUIDv4>
}

/// Block object from a server response
public struct ReadBlock: CustomStringConvertible {
    public let id: Block.Identifier
    public let createdTime: Date
    public let lastEditedTime: Date
    public let archived: Bool
    public let type: BlockType
    public let hasChildren: Bool
    /// Notion API doesn't directly provide block children. To load blok's children use `NotionClient.blockChildren` method
    /// and create a new instance of this struct using `.updateChildren(_)` method.
    public let children: [ReadBlock]

    public init(
        id: Block.Identifier,
        archived: Bool,
        type: BlockType,
        createdTime: Date,
        lastEditedTime: Date,
        hasChildren: Bool,
        children: [ReadBlock] = []
    ) {
        self.id = id
        self.archived = archived
        self.createdTime = createdTime
        self.lastEditedTime = lastEditedTime
        self.type = type
        self.hasChildren = hasChildren
        self.children = children
    }

    public var description: String {
        "ReadBlock:\(id),\(type),\(createdTime),\(lastEditedTime),\(hasChildren)"
    }

    public func updateChildren(_ children: [ReadBlock]) -> Self {
        return .init(
            id: self.id,
            archived: self.archived,
            type: self.type,
            createdTime: self.createdTime,
            lastEditedTime: self.lastEditedTime,
            hasChildren: self.hasChildren,
            children: children
        )
    }
}

/// Block object used in adding a new content
public struct WriteBlock {
    public let type: BlockType
    public let hasChildren: Bool

    public init(type: BlockType, hasChildren: Bool = false) {
        self.type = type
        self.hasChildren = hasChildren
    }
}

public struct UpdateBlock {
    public let value: BlockType?
    public let archived: Bool?

    public init(value: BlockType?, archived: Bool? = nil) {
        self.value = value
        self.archived = archived
    }
}

// MARK: - Codable

extension Block {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case archived
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
        case hasChildren = "has_children"
        case object
    }
}

extension ReadBlock: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Block.CodingKeys.self)
        id = try container.decode(Block.Identifier.self, forKey: .id)
        archived = try container.decode(Bool.self, forKey: .archived)
        createdTime = try container.decode(Date.self, forKey: .createdTime)
        lastEditedTime = try container.decode(Date.self, forKey: .lastEditedTime)
        type = try BlockType(from: decoder)
        hasChildren = try container.decode(Bool.self, forKey: .hasChildren)
        children = []
    }
}

extension WriteBlock: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Block.CodingKeys.self)
        try type.encode(to: encoder)
        try container.encode(hasChildren, forKey: .hasChildren)
        try container.encode("block", forKey: .object)
    }
}

extension UpdateBlock: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Block.CodingKeys.self)
        if let value = value {
            try value.encode(to: encoder)
        }
        try container.encodeIfPresent(archived, forKey: .archived)
    }
}

@available(iOS 13.0, *)
extension ReadBlock: Identifiable {}
