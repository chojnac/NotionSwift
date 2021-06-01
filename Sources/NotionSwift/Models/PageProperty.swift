//
//  File.swift
//  
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
    case rich_text([RichText])
    case number(Int)
    case select(SelectPropertyValue)
    case multi_select([SelectPropertyValue])
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
    case phone_number(String)
    case created_time(Date)
    case created_by(User)
    case last_edited_time(Date)
    case last_edited_by(User)
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
    public init(from decoder: Decoder) throws {
        let idKey = GenericCodingKeys(stringValue: "id")!

        let container = try decoder.container(keyedBy: GenericCodingKeys.self)
        self.id = try container.decode(Identifier.self, forKey: idKey)
        self.type = try PagePropertyType(from: decoder)
    }
}

extension PagePropertyType: Decodable {
    private struct PageRelation: Decodable {
        let id: Page.Identifier
    }

    public init(from decoder: Decoder) throws {
        let typeKey = GenericCodingKeys(stringValue: "type")!

        let container = try decoder.container(keyedBy: GenericCodingKeys.self)
        let type = try container.decode(String.self, forKey: typeKey).lowercased()
        switch type {
        case "rich_text":
            let value = try container.decode(
                [RichText].self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .rich_text(value)
        case "number":
            let value = try container.decode(
                Int.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .number(value)
        case "select":
            let value = try container.decode(
                PagePropertyType.SelectPropertyValue.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .select(value)
        case "multi_select":
            let value = try container.decode(
                [PagePropertyType.SelectPropertyValue].self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .multi_select(value)
        case "date":
            let value = try container.decode(
                PagePropertyType.DatePropertyValue.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .date(value)
        case "formula":
            let value = try container.decode(
                PagePropertyType.FormulaPropertyValue.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .formula(value)
        case "relation":
            let value = try container.decode(
                [PageRelation].self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .relation(value.map(\.id))
        case "rollup":
            let value = try container.decode(
                PagePropertyType.RollupPropertyValue.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .rollup(value)
        case "title":
            let value = try container.decode(
                [RichText].self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .title(value)
        case "people":
            let value = try container.decode(
                [User].self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .people(value)
        case "files":
            let value = try container.decode(
                [PagePropertyType.FilesPropertyValue].self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .files(value)
        case "checkbox":
            let value = try container.decode(
                Bool.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .checkbox(value)
        case "url":
            let value = try container.decode(
                String.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .url(URL(string: value))
        case "email":
            let value = try container.decode(
                String.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .email(value)
        case "phone_number":
            let value = try container.decode(
                String.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .phone_number(value)
        case "created_time":
            let value = try container.decode(
                Date.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .created_time(value)
        case "created_by":
            let value = try container.decode(
                User.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .created_by(value)
        case "last_edited_time":
            let value = try container.decode(
                Date.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .last_edited_time(value)
        case "last_edited_by":
            let value = try container.decode(
                User.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self = .last_edited_by(value)
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
