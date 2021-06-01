//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

public class Block {

    public typealias Identifier = EntityIdentifier<Block, UUIDv4>
    public let type: BlockType
    public let created_time: Date
    public let last_edited_time: Date
    public let has_children: Bool

    init(type: BlockType, created_time: Date, last_edited_time: Date, has_children: Bool) {
        self.type = type
        self.created_time = created_time
        self.last_edited_time = last_edited_time
        self.has_children = has_children
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(BlockType.self, forKey: .type)
        created_time = try container.decode(Date.self, forKey: .created_time)
        last_edited_time = try container.decode(Date.self, forKey: .last_edited_time)
        has_children = try container.decode(Bool.self, forKey: .has_children)
    }
}

public enum BlockType: String {
    case paragraph
    case heading_1
    case heading_2
    case heading_3
    case bulleted_list_item
    case numbered_list_item
    case to_do
    case toggle
    case child_page
    case unsupported
}

/// Block object read from server
public final class ReadBlock: Block, Decodable {
    public let id: Identifier

    init(id: Identifier, type: BlockType, created_time: Date, last_edited_time: Date, has_children: Bool) {
        self.id = id
        super.init(type: type, created_time: created_time, last_edited_time: last_edited_time, has_children: has_children)
    }

    public override init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Identifier.self, forKey: .id)
        try super.init(from: decoder)
    }
}

/// Block object used in adding new content
public final class WriteBlock: Block {}

extension BlockType: Codable {}

extension Block {
    enum CodingKeys: CodingKey {
        case id
        case type
        case created_time
        case last_edited_time
        case has_children
    }
}

extension WriteBlock: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(created_time, forKey: .created_time)
        try container.encode(last_edited_time, forKey: .last_edited_time)
        try container.encode(has_children, forKey: .has_children)
    }
}
