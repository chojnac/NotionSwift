//
//  Created by Wojciech Chojnacki on 29/05/2021.
//

import Foundation

public enum DatabasePropertyType {
    case title
    case richText
    case number(NumberPropertyConfiguration)
    case select(SelectPropertyConfiguration)
    case multiSelect(MultiSelectPropertyConfiguration)
    case date
    case people
    case file
    case checkbox
    case url
    case email
    case phoneNumber
    case formula(FormulaPropertyConfiguration)
    case relation(RelationPropertyConfiguration)
    case rollup(RollupPropertyConfiguration)
    case createdTime
    case createdBy
    case lastEditedTime
    case lastEditedBy
    case unknown
}

extension DatabasePropertyType {
    public struct NumberPropertyConfiguration {
        public enum Format: String {
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
        public let format: Format
    }
}

extension DatabasePropertyType {
    public struct SelectPropertyConfiguration {
        public struct Option {
            public let name: String
            public let id: EntityIdentifier<Option, UUIDv4>
            public let color: String
        }
        public let options: [Option]
    }
}

extension DatabasePropertyType {
    public struct MultiSelectPropertyConfiguration {
        public struct Option {
            public let name: String
            public let id: EntityIdentifier<Option, UUIDv4>
            public let color: String
        }
        public let options: [Option]
    }
}

extension DatabasePropertyType {
    public struct FormulaPropertyConfiguration {
        public let expression: String
    }
}

extension DatabasePropertyType {
    public struct RelationPropertyConfiguration {
        public let databaseId: Database.Identifier
        public let syncedPropertyName: String?
        public let syncedPropertyId: DatabaseProperty.Identifier?
    }
}

extension DatabasePropertyType {
    public struct RollupPropertyConfiguration {
        public let relationPropertyName: String
        public let relationPropertyId: DatabaseProperty.Identifier
        public let rollupPropertyName: String
        public let rollupPropertyId: DatabaseProperty.Identifier
        public let function: String

    }
}

extension DatabasePropertyType.FormulaPropertyConfiguration: Decodable {}
extension DatabasePropertyType.MultiSelectPropertyConfiguration: Decodable {}
extension DatabasePropertyType.MultiSelectPropertyConfiguration.Option: Decodable {}
extension DatabasePropertyType.SelectPropertyConfiguration: Decodable {}
extension DatabasePropertyType.SelectPropertyConfiguration.Option: Decodable {}
extension DatabasePropertyType.NumberPropertyConfiguration: Decodable {}
extension DatabasePropertyType.NumberPropertyConfiguration.Format: Decodable {}
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
