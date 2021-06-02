//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

public struct Database {
    public typealias Identifier = EntityIdentifier<Database, UUIDv4>
    public typealias PropertyName = String
    public let id: Identifier
    public let title: [RichText]
    public let createdTime: Date
    public let lastEditedTime: Date
    public let properties: [PropertyName: DatabaseProperty]
}

extension Database: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
        case properties
    }
}
