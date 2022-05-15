//
//  Created by Wojciech Chojnacki on 30/05/2021.
//

import Foundation

public struct PageProperty {
    public typealias Identifier = EntityIdentifier<PageProperty, String>
    public let id: Identifier
    public let type: PagePropertyType

    public init(id: PageProperty.Identifier, type: PagePropertyType) {
        self.id = id
        self.type = type
    }
}

public struct WritePageProperty {
    public let type: PagePropertyType
    
    public init(type: PagePropertyType) {
        self.type = type
    }
}

public enum PagePropertyType {
    case richText([RichText])
    case number(Int?)
    case select(SelectPropertyValue?)
    case multiSelect([MultiSelectPropertyValue])
    case date(DateRange?)
    case formula(FormulaPropertyValue)
    case relation([Page.Identifier])
    case rollup(RollupPropertyValue)
    case title([RichText])
    case people([User])
    case files([FilesPropertyValue])
    case checkbox(Bool)
    case url(URL?)
    case email(String?)
    case phoneNumber(String?)
    case createdTime(Date)
    case createdBy(User)
    case lastEditedTime(Date)
    case lastEditedBy(User)
    case unknown(type: String)
}

extension PagePropertyType {
    public struct SelectPropertyValue {
        public let id: EntityIdentifier<SelectPropertyValue, String>?
        public let name: String?
        public let color: String?

        public init(
            id: EntityIdentifier<SelectPropertyValue, String>?,
            name: String?,
            color: String?
        ) {
            self.id = id
            self.name = name
            self.color = color
        }
    }

    public struct MultiSelectPropertyValue {
        public let id: EntityIdentifier<MultiSelectPropertyValue, UUIDv4>?
        public let name: String?
        public let color: String?

        public init(
            id: EntityIdentifier<MultiSelectPropertyValue, UUIDv4>?,
            name: String?,
            color: String?
        ) {
            self.id = id
            self.name = name
            self.color = color
        }
    }

    public struct FilesPropertyValue {
        public enum FileLink {
            case external(url: String)
            case file(url: String, expiryTime: Date)
            case unknown(typeName: String)
        }

        public let name: String
        public let link: FileLink

        public init(_ name: String, type: FileLink) {
            self.name = name
            self.link = type
        }
    }

    public enum FormulaPropertyValue {
        case string(String?)
        case number(Int?)
        case boolean(Bool?)
        case date(DateRange?)
        case unknown
    }

    public enum RollupPropertyValue {
        case array([PagePropertyType])
        case number(Int)
        case date(DateRange?)
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

extension WritePageProperty: Encodable {
    public func encode(to encoder: Encoder) throws {
        try type.encode(to: encoder)
    }
}

extension PagePropertyType: Codable {
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
    
    private struct PageRelation: Codable {
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
            let value = try container.decodeIfPresent(
                Int.self,
                forKey: .number
            )
            self = .number(value)
        case CodingKeys.select.stringValue:
            let value = try container.decodeIfPresent(
                PagePropertyType.SelectPropertyValue.self,
                forKey: .select
            )
            self = .select(value)
        case CodingKeys.multiSelect.stringValue:
            let value = try container.decode(
                [PagePropertyType.MultiSelectPropertyValue].self,
                forKey: .multiSelect
            )
            self = .multiSelect(value)
        case CodingKeys.date.stringValue:
            let value = try container.decodeIfPresent(
                DateRange.self,
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
            let value = try container.decodeIfPresent(
                String.self,
                forKey: .email
            )
            self = .email(value)
        case CodingKeys.phoneNumber.stringValue:
            let value = try container.decodeIfPresent(
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
            self = .unknown(type: type)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .richText(let value):
            try container.encode(value, forKey: .richText)
        case .number(let value):
            try container.encode(value, forKey: .number)
        case .select(let value):
            try container.encode(value, forKey: .select)
        case .multiSelect(let value):
            try container.encode(value, forKey: .multiSelect)
        case .date(let value):
            try container.encode(value, forKey: .date)
        case .formula(let value):
            try container.encode(value, forKey: .formula)
        case .relation(let value):
            try container.encode(value.map(PageRelation.init(id:)), forKey: .relation)
        case .rollup(let value):
            try container.encode(value, forKey: .rollup)
        case .title(let value):
            try container.encode(value, forKey: .title)
        case .people(let value):
            try container.encode(value, forKey: .people)
        case .files(let value):
            try container.encode(value, forKey: .files)
        case .checkbox(let value):
            try container.encode(value, forKey: .checkbox)
        case .url(let value):
            try container.encode(value, forKey: .url)
        case .email(let value):
            try container.encode(value, forKey: .email)
        case .phoneNumber(let value):
            try container.encode(value, forKey: .phoneNumber)
        case .createdTime(let value):
            try container.encode(value, forKey: .createdTime)
        case .createdBy(let value):
            try container.encode(value, forKey: .createdBy)
        case .lastEditedTime(let value):
            try container.encode(value, forKey: .lastEditedTime)
        case .lastEditedBy(let value):
            try container.encode(value, forKey: .lastEditedBy)
        case .unknown:
            break
        }
    }
}

extension PagePropertyType.SelectPropertyValue: Codable {}
extension PagePropertyType.MultiSelectPropertyValue: Codable {}

extension PagePropertyType.FilesPropertyValue: Codable {

    enum CodingKeys: String, CodingKey {
        case name
        case type
        case file
        case external
    }

    private struct _ExternalFileLink: Codable {
        let url: String
    }

    private struct _FileLink: Codable {
        let url: String
        // swiftlint:disable:next identifier_name
        let expiry_time: Date
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let type = try container.decode(String.self, forKey: .type)

        if type == CodingKeys.external.rawValue {
            let value = try container.decode(_ExternalFileLink.self, forKey: .external)
            link = .external(url: value.url)
        } else if type == CodingKeys.file.rawValue {
            let value = try container.decode(_FileLink.self, forKey: .file)
            link = .file(url: value.url, expiryTime: value.expiry_time)
        } else {
            link = .unknown(typeName: type)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        switch link {
        case let .external(url):
            try container.encode(CodingKeys.external.rawValue, forKey: .type)
            try container.encode(_ExternalFileLink(url: url), forKey: .external)
        case let .file(url, expiryTime):
            try container.encode(CodingKeys.file.rawValue, forKey: .type)
            try container.encode(_FileLink(url: url, expiry_time: expiryTime), forKey: .file)
        case .unknown:
            break
        }
    }
}

extension PagePropertyType.FormulaPropertyValue: Codable {
    enum CodingKeys: String, CodingKey {
        case string
        case number
        case boolean
        case date
        case type
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case CodingKeys.string.rawValue:
            let value = try container.decode(String?.self, forKey: .string)
            self = .string(value)
        case CodingKeys.number.rawValue:
            let value = try container.decode(Int?.self, forKey: .number)
            self = .number(value)
        case CodingKeys.boolean.rawValue:
            let value = try container.decode(Bool?.self, forKey: .boolean)
            self = .boolean(value)
        case CodingKeys.date.rawValue:
            let value = try container.decode(DateRange?.self, forKey: .date)
            self = .date(value)
        default:
            self = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value):
            try container.encode(CodingKeys.string.rawValue, forKey: .type)
            try container.encode(value, forKey: .string)
        case .number(let value):
            try container.encode(CodingKeys.number.rawValue, forKey: .type)
            try container.encode(value, forKey: .number)
        case .boolean(let value):
            try container.encode(CodingKeys.boolean.rawValue, forKey: .type)
            try container.encode(value, forKey: .boolean)
        case .date(let value):
            try container.encode(CodingKeys.date.rawValue, forKey: .type)
            try container.encode(value, forKey: .date)
        case .unknown:
            break
        }
    }
}
extension PagePropertyType.RollupPropertyValue: Codable {
    enum CodingKeys: String, CodingKey {
        case array
        case number
        case date
        case type
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case CodingKeys.array.rawValue:
            let value = try container.decode([PagePropertyType].self, forKey: .array)
            self = .array(value)
        case CodingKeys.number.rawValue:
            let value = try container.decode(Int.self, forKey: .number)
            self = .number(value)
        case CodingKeys.date.rawValue:
            let value = try container.decodeIfPresent(DateRange.self, forKey: .date)
            self = .date(value)
        default:
            self = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .array(let value):
            try container.encode(CodingKeys.array.rawValue, forKey: .type)
            try container.encode(value, forKey: .array)
        case .number(let value):
            try container.encode(CodingKeys.number.rawValue, forKey: .type)
            try container.encode(value, forKey: .number)
        case .date(let value):
            try container.encode(CodingKeys.date.rawValue, forKey: .type)
            try container.encode(value, forKey: .date)
        case .unknown:
            break
        }
    }
}
