//
//  Created by Wojciech Chojnacki on 21/03/2022.
//

import Foundation

/// Block object from a server response
public struct ReadBlock: CustomStringConvertible {
    public let id: Block.Identifier
    public let createdTime: Date
    public let lastEditedTime: Date
    public let archived: Bool
    public let type: BlockType
    public let hasChildren: Bool
    public let createdBy: PartialUser
    public let lastEditedBy: PartialUser
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
        createdBy: PartialUser,
        lastEditedBy: PartialUser,
        children: [ReadBlock] = []
    ) {
        self.id = id
        self.archived = archived
        self.createdTime = createdTime
        self.lastEditedTime = lastEditedTime
        self.type = type
        self.hasChildren = hasChildren
        self.createdBy = createdBy
        self.lastEditedBy = lastEditedBy
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
            createdBy: self.createdBy,
            lastEditedBy: self.lastEditedBy,
            children: children
        )
    }
}

// MARK: - Codable

extension ReadBlock: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Block.CodingKeys.self)
        id = try container.decode(Block.Identifier.self, forKey: .id)
        archived = try container.decode(Bool.self, forKey: .archived)
        createdTime = try container.decode(Date.self, forKey: .createdTime)
        lastEditedTime = try container.decode(Date.self, forKey: .lastEditedTime)
        createdBy = try container.decode(PartialUser.self, forKey: .createdBy)
        lastEditedBy = try container.decode(PartialUser.self, forKey: .lastEditedBy)
        type = try BlockType(from: decoder)
        hasChildren = try container.decode(Bool.self, forKey: .hasChildren)
        children = []
    }
}

@available(iOS 13.0, *)
extension ReadBlock: Identifiable {}
