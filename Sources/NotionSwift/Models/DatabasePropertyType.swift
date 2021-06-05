//
//  Created by Wojciech Chojnacki on 29/05/2021.
//

import Foundation

public enum DatabasePropertyType {
    case title
    case richText
    case number(NumberPropertyConfiguration)
    case select([SelectOption])
    case multiSelect([SelectOption])
    case date
    case people
    case file
    case checkbox
    case url
    case email
    case phoneNumber
    case formula(expression: String)
    case relation(RelationPropertyConfiguration)
    case rollup(RollupPropertyConfiguration)
    case createdTime
    case createdBy
    case lastEditedTime
    case lastEditedBy
    case unknown
}

extension DatabasePropertyType {
    public enum NumberPropertyConfiguration: String {
        case number
        case numberWithCommas = "number_with_commas"
        case percent
        case dollar
        case euro
        case pound
        case yen
        case ruble
        case rupee
        case won
        case yua
        case unknown
    }
}

extension DatabasePropertyType {
    public struct SelectOption {
        public typealias Identifier = EntityIdentifier<SelectOption, UUIDv4>
        public let name: String
        public let id: Identifier
        public let color: String

        public init(
            name: String,
            id: Identifier,
            color: String = "default"
        ) {
            self.name = name
            self.id = id
            self.color = color
        }
    }
}

extension DatabasePropertyType {
    public struct RelationPropertyConfiguration {
        public let databaseId: Database.Identifier
        public let syncedPropertyName: String?
        public let syncedPropertyId: DatabaseProperty.Identifier?

        public init(
            databaseId: Database.Identifier,
            syncedPropertyName: String? = nil,
            syncedPropertyId: DatabaseProperty.Identifier? = nil
        ) {
            self.databaseId = databaseId
            self.syncedPropertyName = syncedPropertyName
            self.syncedPropertyId = syncedPropertyId
        }
    }
}

extension DatabasePropertyType {

    public struct RollupPropertyConfiguration {
        public let relationPropertyName: String
        public let relationPropertyId: DatabaseProperty.Identifier
        public let rollupPropertyName: String
        public let rollupPropertyId: DatabaseProperty.Identifier
        public let function: String

        public init(
            relationPropertyName: String,
            relationPropertyId: DatabaseProperty.Identifier,
            rollupPropertyName: String,
            rollupPropertyId: DatabaseProperty.Identifier,
            function: String
        ) {
            self.relationPropertyName = relationPropertyName
            self.relationPropertyId = relationPropertyId
            self.rollupPropertyName = rollupPropertyName
            self.rollupPropertyId = rollupPropertyId
            self.function = function
        }
    }
}

extension DatabasePropertyType.SelectOption: Decodable {}

extension DatabasePropertyType.NumberPropertyConfiguration: Decodable {
    enum CodingKeys: String, CodingKey {
        case format
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let format = try container.decode(String.self, forKey: .format)
        
        guard let value = Self(rawValue: format) else {
            self = .unknown
            return
        }

        self = value
    }

}

extension DatabasePropertyType.RelationPropertyConfiguration: Decodable {
    enum CodingKeys: String, CodingKey {
        case databaseId = "database_id"
        case syncedPropertyName = "synced_property_name"
        case syncedPropertyId = "synced_property_id"
    }
}
extension DatabasePropertyType.RollupPropertyConfiguration: Decodable {
    enum CodingKeys: String, CodingKey {
        case relationPropertyName = "relation_property_name"
        case relationPropertyId = "relation_property_id"
        case rollupPropertyName = "rollup_property_name"
        case rollupPropertyId = "rollup_property_id"
        case function
    }
}
