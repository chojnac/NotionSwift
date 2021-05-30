//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 29/05/2021.
//

import Foundation

public struct DatabaseProperty {
    public typealias Identifier = EntityIdentifier<DatabaseProperty, String>
    public let id: Identifier
    public let type: DatabasePropertyType
}

extension DatabaseProperty: Decodable {

    public init(from decoder: Decoder) throws {
        let typeKey = GenericCodingKeys(stringValue: "type")!
        let idKey = GenericCodingKeys(stringValue: "id")!

        let container = try decoder.container(keyedBy: GenericCodingKeys.self)
        self.id = try container.decode(Identifier.self, forKey: idKey)
        let type = try container.decode(String.self, forKey: typeKey).lowercased()
        switch type {
        case "title":
            self.type = .title
        case "rich_text":
            self.type = .rich_text
        case "number":
            let value = try container.decode(
                DatabasePropertyType.NumberPropertyConfiguration.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self.type = .number(value)
        case "select":
            let value = try container.decode(
                DatabasePropertyType.SelectPropertyConfiguration.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self.type = .select(value)
        case "multi_select":
            let value = try container.decode(
                DatabasePropertyType.MultiSelectPropertyConfiguration.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self.type = .multi_select(value)
        case "date":
            self.type = .date
        case "people":
            self.type = .people
        case "file":
            self.type = .file
        case "checkbox":
            self.type = .checkbox
        case "url":
            self.type = .url
        case "email":
            self.type = .email
        case "phone_number":
            self.type = .phone_number
        case "formula":
            let value = try container.decode(
                DatabasePropertyType.FormulaPropertyConfiguration.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self.type = .formula(value)
        case "relation":
            let value = try container.decode(
                DatabasePropertyType.RelationPropertyConfiguration.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self.type = .relation(value)
        case "rollup":
            let value = try container.decode(
                DatabasePropertyType.RollupPropertyConfiguration.self,
                forKey: GenericCodingKeys(stringValue: type)!
            )
            self.type = .rollup(value)
        case "created_time":
            self.type = .created_time
        case "created_by":
            self.type = .created_by
        case "last_edited_time":
            self.type = .last_edited_time
        case "last_edited_by":
            self.type = .last_edited_by
        default:
            self.type = .unknown
        }
    }
}
