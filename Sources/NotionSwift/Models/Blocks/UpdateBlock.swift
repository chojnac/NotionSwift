//
//  Created by Wojciech Chojnacki on 21/03/2022.
//

import Foundation

public struct UpdateBlock {
    public let value: BlockType?
    public let archived: Bool?
    public let color: BlockColor

    public init(value: BlockType?, archived: Bool? = nil, color: BlockColor = .default) {
        self.value = value
        self.archived = archived
        self.color = color
    }
}

// MARK: - Codable

extension UpdateBlock: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Block.CodingKeys.self)
        if let value = value {
            try value.encode(to: encoder)
        }
        try container.encodeIfPresent(archived, forKey: .archived)
        try container.encode(color, forKey: .color)
    }
}

