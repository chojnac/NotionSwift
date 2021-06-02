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
    enum CodingKeys: String, CodingKey {
        case title
        case richText = "rich_text"
        case number
        case select
        case multiSelect = "multi_select"
        case date
        case people
        case file
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
        case id
        case type
    }
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Identifier.self, forKey: .id)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case CodingKeys.title.rawValue:
            self.type = .title
        case CodingKeys.richText.rawValue:
            self.type = .richText
        case CodingKeys.number.rawValue:
            let value = try container.decode(
                DatabasePropertyType.NumberPropertyConfiguration.self,
                forKey: .number
            )
            self.type = .number(value)
        case CodingKeys.select.rawValue:
            let value = try container.decode(
                DatabasePropertyType.SelectPropertyConfiguration.self,
                forKey: .select
            )
            self.type = .select(value)
        case CodingKeys.multiSelect.rawValue:
            let value = try container.decode(
                DatabasePropertyType.MultiSelectPropertyConfiguration.self,
                forKey: .multiSelect
            )
            self.type = .multiSelect(value)
        case CodingKeys.date.rawValue:
            self.type = .date
        case CodingKeys.people.rawValue:
            self.type = .people
        case CodingKeys.file.rawValue:
            self.type = .file
        case CodingKeys.checkbox.rawValue:
            self.type = .checkbox
        case CodingKeys.url.rawValue:
            self.type = .url
        case CodingKeys.email.rawValue:
            self.type = .email
        case CodingKeys.phoneNumber.rawValue:
            self.type = .phoneNumber
        case CodingKeys.formula.rawValue:
            let value = try container.decode(
                DatabasePropertyType.FormulaPropertyConfiguration.self,
                forKey: .formula
            )
            self.type = .formula(value)
        case CodingKeys.relation.rawValue:
            let value = try container.decode(
                DatabasePropertyType.RelationPropertyConfiguration.self,
                forKey: .relation
            )
            self.type = .relation(value)
        case CodingKeys.rollup.rawValue:
            let value = try container.decode(
                DatabasePropertyType.RollupPropertyConfiguration.self,
                forKey: .rollup
            )
            self.type = .rollup(value)
        case CodingKeys.createdTime.rawValue:
            self.type = .createdTime
        case CodingKeys.createdBy.rawValue:
            self.type = .createdBy
        case CodingKeys.lastEditedTime.rawValue:
            self.type = .lastEditedTime
        case CodingKeys.lastEditedBy.rawValue:
            self.type = .lastEditedBy
        default:
            self.type = .unknown
        }
    }
}
