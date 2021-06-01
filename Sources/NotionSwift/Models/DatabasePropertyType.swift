//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 29/05/2021.
//

import Foundation

public enum DatabasePropertyType {
    case title
    case rich_text
    case number(NumberPropertyConfiguration)
    case select(SelectPropertyConfiguration)
    case multi_select(MultiSelectPropertyConfiguration)
    case date
    case people
    case file
    case checkbox
    case url
    case email
    case phone_number
    case formula(FormulaPropertyConfiguration)
    case relation(RelationPropertyConfiguration)
    case rollup(RollupPropertyConfiguration)
    case created_time
    case created_by
    case last_edited_time
    case last_edited_by
    case unknown
}

extension DatabasePropertyType {
    public struct NumberPropertyConfiguration {
        public enum Format: String {
            case number
            case number_with_commas
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
        public let database_id: Database.Identifier
        public let synced_property_name: String?
        public let synced_property_id: DatabaseProperty.Identifier?
    }
}

extension DatabasePropertyType {
    public struct RollupPropertyConfiguration {
        public let relation_property_name: String
        public let relation_property_id: DatabaseProperty.Identifier
        public let rollup_property_name: String
        public let rollup_property_id: DatabaseProperty.Identifier
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
extension DatabasePropertyType.RelationPropertyConfiguration: Decodable {}
extension DatabasePropertyType.RollupPropertyConfiguration: Decodable {}
