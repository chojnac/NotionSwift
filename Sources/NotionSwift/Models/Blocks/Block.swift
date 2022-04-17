//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

/// Just a placeholder entity. User ReadBlock / WriteBlock structs.
public enum Block {
    public typealias Identifier = EntityIdentifier<Block, UUIDv4>
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
        case color
        case object
    }
}
