//
//  Created by Wojciech Chojnacki on 29/05/2021.
//

import Foundation

public struct DatabaseProperty {
    public typealias Identifier = EntityIdentifier<DatabaseProperty, String>
    public let id: Identifier
    public let type: DatabasePropertyType

    public init(
        id: DatabaseProperty.Identifier,
        type: DatabasePropertyType
    ) {
        self.id = id
        self.type = type
    }
}

extension DatabaseProperty: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Identifier.self, forKey: .id)
        self.type = try DatabasePropertyType(from: decoder)
    }
}
