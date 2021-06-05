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

    public init(
        id: Database.Identifier,
        title: [RichText],
        createdTime: Date,
        lastEditedTime: Date,
        properties: [Database.PropertyName: DatabaseProperty]
    ) {
        self.id = id
        self.title = title
        self.createdTime = createdTime
        self.lastEditedTime = lastEditedTime
        self.properties = properties
    }
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

@available(iOS 13.0, *)
extension Database: Identifiable {}
