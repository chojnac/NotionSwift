//
//  Created by Wojciech Chojnacki on 21/03/2022.
//

import Foundation

public struct UpdateBlock {

    public let type: BlockType
    public let archived: Bool?

    public init(value: BlockType, archived: Bool? = nil) {
        self.type = value
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


