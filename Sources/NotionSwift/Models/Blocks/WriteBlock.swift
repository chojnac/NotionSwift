//
//  Created by Wojciech Chojnacki on 21/03/2022.
//

import Foundation

/// Block object used for adding a new content
public struct WriteBlock {
    public let type: BlockType

    public init(type: BlockType) {
        self.type = type
    }
}

// MARK: - Codable

extension WriteBlock: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Block.CodingKeys.self)
        try type.encode(to: encoder)
        try container.encode("block", forKey: .object)
    }
}
