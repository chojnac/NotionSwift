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
    case files
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
    case status(StatusPropertConfirguration)
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
            id: Identifier = .init(),
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

extension DatabasePropertyType {
    public struct StatusPropertConfirguration {
        public typealias OptionIdentifier = EntityIdentifier<SelectOption, UUIDv4>
        
        public struct StatusOption {
            public let id: OptionIdentifier
            /// Name of the option as it appears in Notion.
            public let name: String
            public let color: String
            
            public init(
                id: OptionIdentifier,
                name: String,
                color: String
            ) {
                self.id = id
                self.name = name
                self.color = color
            }
        }
        
        public struct StatusGroup {
            public let id: OptionIdentifier
            public let name: String
            public let color: String
            /// Sorted list of ids of all options that belong to a group.
            public let optionIds: [OptionIdentifier]
            
            public init(
                id: OptionIdentifier,
                name: String,
                color: String,
                optionIds: [OptionIdentifier]
            ) {
                self.id = id
                self.name = name
                self.color = color
                self.optionIds = optionIds
            }
        }
        
        /// Sorted list of options available for this property.
        public let options: [StatusOption]
        /// Sorted list of groups available for this property.
        public let groups: [StatusGroup]
        
        public init(
            options: [StatusOption],
            groups: [StatusGroup]
        ) {
            self.options = options
            self.groups = groups
        }
    }
    
}

extension DatabasePropertyType.SelectOption: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case color
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(color, forKey: .color)
    }
}

extension DatabasePropertyType.NumberPropertyConfiguration: Codable {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawValue, forKey: .format)
    }

}

extension DatabasePropertyType.RelationPropertyConfiguration: Codable {
    enum CodingKeys: String, CodingKey {
        case databaseId = "database_id"
        case syncedPropertyName = "synced_property_name"
        case syncedPropertyId = "synced_property_id"
    }
}

extension DatabasePropertyType.RollupPropertyConfiguration: Codable {
    enum CodingKeys: String, CodingKey {
        case relationPropertyName = "relation_property_name"
        case relationPropertyId = "relation_property_id"
        case rollupPropertyName = "rollup_property_name"
        case rollupPropertyId = "rollup_property_id"
        case function
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(relationPropertyName, forKey: .relationPropertyName)
        try container.encode(rollupPropertyName, forKey: .rollupPropertyName)
        try container.encode(function, forKey: .function)
    }
}

extension DatabasePropertyType.StatusPropertConfirguration: Codable {}
extension DatabasePropertyType.StatusPropertConfirguration.StatusOption: Codable {}
extension DatabasePropertyType.StatusPropertConfirguration.StatusGroup: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
        case optionIds = "option_ids"
    }
}

extension DatabasePropertyType: Codable {
    enum CodingKeys: String, CodingKey {
        case type

        case title
        case richText = "rich_text"
        case number
        case select
        case multiSelect = "multi_select"
        case date
        case people
        case files
        case checkbox
        case url
        case email
        case phoneNumber = "phone_number"
        case formula
        case relation
        case rollup
        case createdTime = "created_time"
        case createdBy = "created_by"
        case lastEditedTime = "last_edited_time"
        case lastEditedBy = "last_edited_by"
        case status
    }

    private struct _SelectOptionValueHelper: Codable {
        let options: [DatabasePropertyType.SelectOption]
    }

    private struct _FormulaValueHelper: Codable {
        let expression: String
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case CodingKeys.title.rawValue:
            self = .title
        case CodingKeys.richText.rawValue:
            self = .richText
        case CodingKeys.number.rawValue:
            let value = try container.decode(
                DatabasePropertyType.NumberPropertyConfiguration.self,
                forKey: .number
            )
            self = .number(value)
        case CodingKeys.select.rawValue:
            let value = try container.decode(
                _SelectOptionValueHelper.self,
                forKey: .select
            )
            self = .select(value.options)
        case CodingKeys.multiSelect.rawValue:
            let value = try container.decode(
                _SelectOptionValueHelper.self,
                forKey: .multiSelect
            )
            self = .multiSelect(value.options)
        case CodingKeys.date.rawValue:
            self = .date
        case CodingKeys.people.rawValue:
            self = .people
        case CodingKeys.files.rawValue:
            self = .files
        case CodingKeys.checkbox.rawValue:
            self = .checkbox
        case CodingKeys.url.rawValue:
            self = .url
        case CodingKeys.email.rawValue:
            self = .email
        case CodingKeys.phoneNumber.rawValue:
            self = .phoneNumber
        case CodingKeys.formula.rawValue:
            let value = try container.decode(
                _FormulaValueHelper.self,
                forKey: .formula
            )
            self = .formula(expression: value.expression)
        case CodingKeys.relation.rawValue:
            let value = try container.decode(
                DatabasePropertyType.RelationPropertyConfiguration.self,
                forKey: .relation
            )
            self = .relation(value)
        case CodingKeys.rollup.rawValue:
            let value = try container.decode(
                DatabasePropertyType.RollupPropertyConfiguration.self,
                forKey: .rollup
            )
            self = .rollup(value)
        case CodingKeys.createdTime.rawValue:
            self = .createdTime
        case CodingKeys.createdBy.rawValue:
            self = .createdBy
        case CodingKeys.lastEditedTime.rawValue:
            self = .lastEditedTime
        case CodingKeys.lastEditedBy.rawValue:
            self = .lastEditedBy
        case CodingKeys.status.rawValue:
            let value = try container.decode(
                DatabasePropertyType.StatusPropertConfirguration.self,
                forKey: .status
            )
            self = .status(value)
        default:
            self = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let emptyObject: [String: String] = [:]

        switch self {
        case .title:
            try container.encode(emptyObject, forKey: .title)
        case .richText:
            try container.encode(emptyObject, forKey: .richText)
        case .number(let config):
            try container.encode(config, forKey: .number)
        case .select(let options):
            try container.encode(_SelectOptionValueHelper(options: options), forKey: .select)
        case .multiSelect(let options):
            try container.encode(_SelectOptionValueHelper(options: options), forKey: .multiSelect)
        case .date:
            try container.encode(emptyObject, forKey: .date)
        case .people:
            try container.encode(emptyObject, forKey: .people)
        case .files:
            try container.encode(emptyObject, forKey: .files)
        case .checkbox:
            try container.encode(emptyObject, forKey: .checkbox)
        case .url:
            try container.encode(emptyObject, forKey: .url)
        case .email:
            try container.encode(emptyObject, forKey: .email)
        case .phoneNumber:
            try container.encode(emptyObject, forKey: .phoneNumber)
        case .formula(let expression):
            try container.encode(_FormulaValueHelper(expression: expression), forKey: .formula)
        case .relation(let config):
            try container.encode(config, forKey: .relation)
        case .rollup(let config):
            try container.encode(config, forKey: .rollup)
        case .createdTime:
            try container.encode(emptyObject, forKey: .createdTime)
        case .createdBy:
            try container.encode(emptyObject, forKey: .createdBy)
        case .lastEditedTime:
            try container.encode(emptyObject, forKey: .lastEditedTime)
        case .lastEditedBy:
            try container.encode(emptyObject, forKey: .lastEditedBy)
        case .status(let config):
            try container.encode(config, forKey: .status)
        case .unknown:
            break
        }
    }
}
