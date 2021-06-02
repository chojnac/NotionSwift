//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

/// Just a placeholder entity. User ReadBlock / WriteBlock structs.
public enum Block {
    public typealias Identifier = EntityIdentifier<Block, UUIDv4>
}

/// Block object read from server
public struct ReadBlock: CustomStringConvertible {
    public let id: Block.Identifier
    public let createdTime: Date
    public let lastEditedTime: Date
    public let type: BlockType
    public let hasChildren: Bool

    init(
        id: Block.Identifier,
        type: BlockType,
        createdTime: Date,
        lastEditedTime: Date,
        hasChildren: Bool
    ) {
        self.id = id
        self.createdTime = createdTime
        self.lastEditedTime = lastEditedTime
        self.type = type
        self.hasChildren = hasChildren
    }

    public var description: String {
        "ReadBlock:\(id),\(type),\(createdTime),\(lastEditedTime),\(hasChildren)"
    }
}

/// Block object used in adding new content
public struct WriteBlock {
    public let type: BlockType
    public let hasChildren: Bool

    public init(type: BlockType, hasChildren: Bool = false) {
        self.type = type
        self.hasChildren = hasChildren
    }
}

// MARK: - Codable

extension Block {
    enum CodingKeys: String, CodingKey {
        case id
        case type
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
        createdTime = try container.decode(Date.self, forKey: .createdTime)
        lastEditedTime = try container.decode(Date.self, forKey: .lastEditedTime)
        type = try BlockType(from: decoder)
        hasChildren = try container.decode(Bool.self, forKey: .hasChildren)
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
