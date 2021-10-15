//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

public struct Database {
    public typealias Identifier = EntityIdentifier<Database, UUIDv4>
    public typealias PropertyName = String
    public let id: Identifier
    public let url: String
    public let title: [RichText]
    public let icon: IconFile?
    public let cover: CoverFile?
    public let createdTime: Date
    public let lastEditedTime: Date
    public let properties: [PropertyName: DatabaseProperty]
    public let parent: DatabaseParent

    public init(
        id: Database.Identifier,
        url: String,
        title: [RichText],
        icon: IconFile?,
        cover: CoverFile?,
        createdTime: Date,
        lastEditedTime: Date,
        properties: [Database.PropertyName: DatabaseProperty],
        parent: DatabaseParent
    ) {
        self.id = id
        self.url = url
        self.title = title
        self.icon = icon
        self.cover = cover
        self.createdTime = createdTime
        self.lastEditedTime = lastEditedTime
        self.properties = properties
        self.parent = parent
    }
}

extension Database: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case title
        case icon
        case cover
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
        case properties
        case parent
    }
}

@available(iOS 13.0, *)
extension Database: Identifiable {}
