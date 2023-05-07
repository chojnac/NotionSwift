//
//  Created by Wojciech Chojnacki on 21/03/2022.
//

import Foundation

public struct UpdateBlock {
    @available(*, deprecated, renamed: "type")
    public var value: BlockType {
        type
    }
    public let type: BlockType
    public let archived: Bool?

    @available(*, deprecated, message: "Please use init(type:archived:) instead")
    public init(value: BlockType, archived: Bool? = nil) {
        self.type = value
        self.archived = archived
    }
    
    public init(type: BlockType, archived: Bool? = nil) {
        self.type = type
        self.archived = archived
    }
}

// MARK: - Codable

extension UpdateBlock: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Block.CodingKeys.self)
        try type.encode(to: encoder)
        try container.encodeIfPresent(archived, forKey: .archived)
    }
}

