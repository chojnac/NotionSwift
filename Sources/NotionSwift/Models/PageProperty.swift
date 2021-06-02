//
//  Created by Wojciech Chojnacki on 30/05/2021.
//

import Foundation

public struct PageProperty {
    public typealias Identifier = EntityIdentifier<PageProperty, String>
    public let id: Identifier
    public let type: PagePropertyType
}

public enum PagePropertyType {
    case richText([RichText])
    case number(Int)
    case select(SelectPropertyValue)
    case multiSelect([SelectPropertyValue])
    case date(DatePropertyValue)
    case formula(FormulaPropertyValue)
    case relation([Page.Identifier])
    case rollup(RollupPropertyValue)
    case title([RichText])
    case people([User])
    case files([FilesPropertyValue])
    case checkbox(Bool)
    case url(URL?)
    case email(String)
    case phoneNumber(String)
    case createdTime(Date)
    case createdBy(User)
    case lastEditedTime(Date)
    case lastEditedBy(User)
    case unknown
}

extension PagePropertyType {
    public struct SelectPropertyValue {
        public let id: EntityIdentifier<SelectPropertyValue, UUIDv4>?
        public let name: String?
        public let color: String?
    }

    public struct DatePropertyValue {
        public let start: Date
        public let end: Date?
    }

    public struct FilesPropertyValue {
        public let name: String
    }

    public enum FormulaPropertyValue {
        case string(String?)
        case number(Int?)
        case boolean(Bool?)
        case date(DatePropertyValue?)
        case unknown
    }

    public enum RollupPropertyValue {
        case array([PagePropertyType])
        case number(Int)
        case date(DatePropertyValue)
        case unknown
    }
}
extension PageProperty: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Identifier.self, forKey: .id)
        self.type = try PagePropertyType(from: decoder)
    }
}

extension PagePropertyType: Decodable {
    enum CodingKeys: String, CodingKey {
        case richText = "rich_text"
        case number
        case select
        case multiSelect = "multi_select"
        case date
        case formula
        case relation
        case rollup
        case title
        case people
        case files
        case checkbox
        case url
        case email
        case phoneNumber = "phone_number"
        case createdTime = "created_time"
        case createdBy = "created_by"
        case lastEditedTime = "last_edited_time"
        case lastEditedBy = "last_edited_by"

        case type
    }
    private struct PageRelation: Decodable {
        let id: Page.Identifier
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case CodingKeys.richText.stringValue:
            let value = try container.decode(
                [RichText].self,
                forKey: .richText
            )
            self = .richText(value)
        case CodingKeys.number.stringValue:
            let value = try container.decode(
                Int.self,
                forKey: .number
            )
            self = .number(value)
        case CodingKeys.select.stringValue:
            let value = try container.decode(
                PagePropertyType.SelectPropertyValue.self,
                forKey: .select
            )
            self = .select(value)
        case CodingKeys.multiSelect.stringValue:
            let value = try container.decode(
                [PagePropertyType.SelectPropertyValue].self,
                forKey: .multiSelect
            )
            self = .multiSelect(value)
        case CodingKeys.date.stringValue:
            let value = try container.decode(
                PagePropertyType.DatePropertyValue.self,
                forKey: .date
            )
            self = .date(value)
        case CodingKeys.formula.stringValue:
            let value = try container.decode(
                PagePropertyType.FormulaPropertyValue.self,
                forKey: .formula
            )
            self = .formula(value)
        case CodingKeys.relation.stringValue:
            let value = try container.decode(
                [PageRelation].self,
                forKey: .relation
            )
            self = .relation(value.map(\.id))
        case CodingKeys.rollup.stringValue:
            let value = try container.decode(
                PagePropertyType.RollupPropertyValue.self,
                forKey: .rollup
            )
            self = .rollup(value)
        case CodingKeys.title.stringValue:
            let value = try container.decode(
                [RichText].self,
                forKey: .title
            )
            self = .title(value)
        case CodingKeys.people.stringValue:
            let value = try container.decode(
                [User].self,
                forKey: .people
            )
            self = .people(value)
        case CodingKeys.files.stringValue:
            let value = try container.decode(
                [PagePropertyType.FilesPropertyValue].self,
                forKey: .files
            )
            self = .files(value)
        case CodingKeys.checkbox.stringValue:
            let value = try container.decode(
                Bool.self,
                forKey: .checkbox
            )
            self = .checkbox(value)
        case CodingKeys.url.stringValue:
            let value = try container.decode(
                String.self,
                forKey: .url
            )
            self = .url(URL(string: value))
        case CodingKeys.email.stringValue:
            let value = try container.decode(
                String.self,
                forKey: .email
            )
            self = .email(value)
        case CodingKeys.phoneNumber.stringValue:
            let value = try container.decode(
                String.self,
                forKey: .phoneNumber
            )
            self = .phoneNumber(value)
        case CodingKeys.createdTime.stringValue:
            let value = try container.decode(
                Date.self,
                forKey: .createdTime
            )
            self = .createdTime(value)
        case CodingKeys.createdBy.stringValue:
            let value = try container.decode(
                User.self,
                forKey: .createdBy
            )
            self = .createdBy(value)
        case CodingKeys.lastEditedTime.stringValue:
            let value = try container.decode(
                Date.self,
                forKey: .lastEditedTime
            )
            self = .lastEditedTime(value)
        case CodingKeys.lastEditedBy.stringValue:
            let value = try container.decode(
                User.self,
                forKey: .lastEditedBy
            )
            self = .lastEditedBy(value)
        default:
            self = .unknown
        }
    }
}

extension PagePropertyType.SelectPropertyValue: Decodable {}
extension PagePropertyType.DatePropertyValue: Decodable {}
extension PagePropertyType.FilesPropertyValue: Decodable {}
extension PagePropertyType.FormulaPropertyValue: Decodable {
    public init(from decoder: Decoder) throws {
        let typeKey = GenericCodingKeys(stringValue: "type")!

        let container = try decoder.container(keyedBy: GenericCodingKeys.self)
        let type = try container.decode(String.self, forKey: typeKey).lowercased()
        switch type {
        case "string":
            let value = try container.decode(
                String?.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .string(value)
        case "number":
            let value = try container.decode(
                Int?.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .number(value)
        case "boolean":
            let value = try container.decode(
                Bool?.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .boolean(value)
        case "date":
            let value = try container.decode(
                PagePropertyType.DatePropertyValue?.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .date(value)
        default:
            self = .unknown
        }
    }
}
extension PagePropertyType.RollupPropertyValue: Decodable {
    public init(from decoder: Decoder) throws {
        let typeKey = GenericCodingKeys(stringValue: "type")!

        let container = try decoder.container(keyedBy: GenericCodingKeys.self)
        let type = try container.decode(String.self, forKey: typeKey).lowercased()
        switch type {
        case "array":
            let value = try container.decode(
                [PagePropertyType].self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .array(value)
        case "number":
            let value = try container.decode(
                Int.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .number(value)
        case "date":
            let value = try container.decode(
                PagePropertyType.DatePropertyValue.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .date(value)
        default:
            self = .unknown
        }
    }
}
