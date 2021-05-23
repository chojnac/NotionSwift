//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

struct GenericCodingKeys: CodingKey {
    var intValue: Int?
    var stringValue: String

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}

extension FilterType: Encodable {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .databaseProperty(let value):
            try value.encode(to: encoder)
        case .compound(let value):
            try value.encode(to: encoder)
        }
    }
}

extension CompountFilterType: Encodable {
    enum CodingKeys: String, CodingKey {
        case and
        case or
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .and(let value):
            try container.encode(value, forKey: .and)
        case .or(let value):
            try container.encode(value, forKey: .or)
        }
    }
}

extension DatabasePropertyFilter: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericCodingKeys.self)
        let propertyKey = GenericCodingKeys(stringValue: "property")!

        try container.encode(property, forKey: propertyKey)

        switch filterType {
        case .title(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "title")!)
        case .rich_text(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "rich_text")!)
        case .url(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "url")!)
        case .email(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "email")!)
        case .phone(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "phone")!)
        case .number(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "number")!)
        case .checkbox(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "checkbox")!)
        case .select(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "select")!)
        case .multiSelect(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "multi_select")!)
        case .date(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "date")!)
        case .created_time(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "created_time")!)
        case .last_edited_time(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "last_edited_time")!)
        case .dateBy(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "date")!)
        case .created_by(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "created_by")!)
        case .last_edited_by(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "last_edited_by")!)
        case .files(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "files")!)
        case .relation(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "relation")!)
        case .formula(let contition):
            try container.encode(contition, forKey: GenericCodingKeys(stringValue: "formula")!)
        }
    }
}

extension DatabasePropertyFilter.CheckboxCondition: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericCodingKeys.self)
        switch self {
        case .equals(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "equals")!)
        case .doesNotEqual(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "does_not_equal")!)
        }
    }
}

extension DatabasePropertyFilter.DateCondition: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericCodingKeys.self)
        switch self {
        }
    }
}

extension DatabasePropertyFilter.FormulaCondition: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericCodingKeys.self)
        switch self {
        }
    }
}

extension DatabasePropertyFilter.FilesCondition: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericCodingKeys.self)
        switch self {
        case .isEmpty:
            try container.encode(true, forKey: GenericCodingKeys(stringValue: "is_empty")!)
        case .isNotEmpty:
            try container.encode(true, forKey: GenericCodingKeys(stringValue: "is_not_empty")!)
        }
    }
}

extension DatabasePropertyFilter.NumberCondition: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericCodingKeys.self)
        switch self {
        case .equals(let number):
            try container.encode(number, forKey: GenericCodingKeys(stringValue: "number")!)
        case .doesNotEqual(let number):
            try container.encode(number, forKey: GenericCodingKeys(stringValue: "does_not_equal")!)
        case .greaterThan(let number):
            try container.encode(number, forKey: GenericCodingKeys(stringValue: "greater_than")!)
        case .lessThan(let number):
            try container.encode(number, forKey: GenericCodingKeys(stringValue: "less_than")!)
        case .greaterThanOrEqualTo(let number):
            try container.encode(number, forKey: GenericCodingKeys(stringValue: "greater_than_or_equal_to")!)
        case .lessThanOrEqualTo(let number):
            try container.encode(number, forKey: GenericCodingKeys(stringValue: "less_than_or_equal_to")!)
        case .isEmpty:
            try container.encode(true, forKey: GenericCodingKeys(stringValue: "is_empty")!)
        case .isNotEmpty:
            try container.encode(true, forKey: GenericCodingKeys(stringValue: "is_not_empty")!)
        }
    }
}

extension DatabasePropertyFilter.SimpleGenericCondition: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericCodingKeys.self)
        switch self {
        case .contains(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "contains")!)
        case .doesNotContain(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "does_not_contain")!)
        case .isEmpty:
            try container.encode(true, forKey: GenericCodingKeys(stringValue: "is_empty")!)
        case .isNotEmpty:
            try container.encode(true, forKey: GenericCodingKeys(stringValue: "is_not_empty")!)
        }
    }
}

extension DatabasePropertyFilter.TextCondition: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericCodingKeys.self)
        switch self {
        case .equals(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "equals")!)
        case .doesNotEqual(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "does_not_equal")!)
        case .contains(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "contains")!)
        case .doesNotContain(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "does_not_contain")!)
        case .startsWith(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "starts_with")!)
        case .endsWith(let value):
            try container.encode(value, forKey: GenericCodingKeys(stringValue: "ends_with")!)
        case .isEmpty:
            try container.encode(true, forKey: GenericCodingKeys(stringValue: "is_empty")!)
        case .isNotEmpty:
            try container.encode(true, forKey: GenericCodingKeys(stringValue: "is_not_empty")!)
        }
    }
}
