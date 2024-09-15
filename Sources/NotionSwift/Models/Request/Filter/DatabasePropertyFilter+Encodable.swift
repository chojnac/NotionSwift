//
//  Created by Wojciech Chojnacki on 02/06/2021.
//

import Foundation

extension DatabasePropertyFilter: Encodable {
    enum CodingKeys: String, CodingKey {
        case title
        case richText = "rich_text"
        case url
        case email
        case phoneNumber = "phone_number"
        case number
        case checkbox
        case select
        case multiSelect = "multi_select"
        case date
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
        case createdBy = "created_by"
        case lastEditedBy = "last_edited_by"
        case files
        case relation
        case formula
        case property
        case status
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(property, forKey: .property)

        switch filterType {
        case .title(let contition):
            try container.encode(contition, forKey: .title)
        case .richText(let contition):
            try container.encode(contition, forKey: .richText)
        case .url(let contition):
            try container.encode(contition, forKey: .url)
        case .email(let contition):
            try container.encode(contition, forKey: .email)
        case .phoneNumber(let contition):
            try container.encode(contition, forKey: .phoneNumber)
        case .number(let contition):
            try container.encode(contition, forKey: .number)
        case .checkbox(let contition):
            try container.encode(contition, forKey: .checkbox)
        case .select(let contition):
            try container.encode(contition, forKey: .select)
        case .multiSelect(let contition):
            try container.encode(contition, forKey: .multiSelect)
        case .date(let contition):
            try container.encode(contition, forKey: .date)
        case .createdTime(let contition):
            try container.encode(contition, forKey: .createdTime)
        case .lastEditedTime(let contition):
            try container.encode(contition, forKey: .lastEditedTime)
        case .dateBy(let contition):
            try container.encode(contition, forKey: .date) // date by is operating also on .date !!!
        case .createdBy(let contition):
            try container.encode(contition, forKey: .createdBy)
        case .lastEditedBy(let contition):
            try container.encode(contition, forKey: .lastEditedBy)
        case .files(let contition):
            try container.encode(contition, forKey: .files)
        case .relation(let contition):
            try container.encode(contition, forKey: .relation)
        case .formula(let contition):
            try container.encode(contition, forKey: .formula)
        case .status(let condition):
            try container.encode(condition, forKey: .status)
        }
    }
}

extension DatabasePropertyFilter.CheckboxCondition: Encodable {
    enum CodingKeys: String, CodingKey {
        case equals
        case doesNotEqual = "does_not_equal"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .equals(let value):
            try container.encode(value, forKey: .equals)
        case .doesNotEqual(let value):
            try container.encode(value, forKey: .doesNotEqual)
        }
    }
}

extension DatabasePropertyFilter.DateCondition: Encodable {
    enum CodingKeys: String, CodingKey {
        case equals
        case before
        case after
        case onOrBefore = "on_or_before"
        case isEmpty = "is_empty"
        case isNotEmpty = "is_not_empty"
        case onOrAfter = "on_or_after"
        case pastWeek = "past_week"
        case pastMonth = "past_month"
        case pastYear = "past_year"
        case thisWeek = "this_week"
        case nextWeek = "next_week"
        case nextMonth = "next_month"
        case nextYear = "next_year"
    }

    private struct Empty: Encodable {}

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .equals(let value):
            try container.encode(value, forKey: .equals)
        case .before(let value):
            try container.encode(value, forKey: .before)
        case .after(let value):
            try container.encode(value, forKey: .after)
        case .onOrBefore(let value):
            try container.encode(value, forKey: .onOrBefore)
        case .isEmpty:
            try container.encode(true, forKey: .isEmpty)
        case .isNotEmpty:
            try container.encode(true, forKey: .isNotEmpty)
        case .onOrAfter(let value):
            try container.encode(value, forKey: .onOrAfter)
        case .pastWeek:
            try container.encode(Empty(), forKey: .pastWeek)
        case .pastMonth:
            try container.encode(Empty(), forKey: .pastMonth)
        case .pastYear:
            try container.encode(Empty(), forKey: .pastYear)
        case .thisWeek:
            try container.encode(Empty(), forKey: .thisWeek)
        case .nextWeek:
            try container.encode(Empty(), forKey: .nextWeek)
        case .nextMonth:
            try container.encode(Empty(), forKey: .nextMonth)
        case .nextYear:
            try container.encode(Empty(), forKey: .nextYear)
        }
    }
}

extension DatabasePropertyFilter.FormulaCondition: Encodable {
    enum CodingKeys: String, CodingKey {
        case string
        case checkbox
        case number
        case date
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value):
            try container.encode(value, forKey: .string)
        case .checkbox(let value):
            try container.encode(value, forKey: .checkbox)
        case .number(let value):
            try container.encode(value, forKey: .number)
        case .date(let value):
            try container.encode(value, forKey: .date)
        }
    }
}

extension DatabasePropertyFilter.FilesCondition: Encodable {
    enum CodingKeys: String, CodingKey {
        case isEmpty = "is_empty"
        case isNotEmpty = "is_not_empty"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .isEmpty:
            try container.encode(true, forKey: .isEmpty)
        case .isNotEmpty:
            try container.encode(true, forKey: .isNotEmpty)
        }
    }
}

extension DatabasePropertyFilter.NumberCondition: Encodable {
    enum CodingKeys: String, CodingKey {
        case equals
        case doesNotEqual = "does_not_equal"
        case greaterThan = "greater_than"
        case lessThan = "less_than"
        case greaterThanOrEqualTo = "greater_than_or_equal_to"
        case lessThanOrEqualTo = "less_than_or_equal_to"
        case isEmpty = "is_empty"
        case isNotEmpty = "is_not_empty"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .equals(let number):
            try container.encode(number, forKey: .equals)
        case .doesNotEqual(let number):
            try container.encode(number, forKey: .doesNotEqual)
        case .greaterThan(let number):
            try container.encode(number, forKey: .greaterThan)
        case .lessThan(let number):
            try container.encode(number, forKey: .lessThan)
        case .greaterThanOrEqualTo(let number):
            try container.encode(number, forKey: .greaterThanOrEqualTo)
        case .lessThanOrEqualTo(let number):
            try container.encode(number, forKey: .lessThanOrEqualTo)
        case .isEmpty:
            try container.encode(true, forKey: .isEmpty)
        case .isNotEmpty:
            try container.encode(true, forKey: .isNotEmpty)
        }
    }
}

extension DatabasePropertyFilter.SimpleGenericCondition: Encodable {
    enum CodingKeys: String, CodingKey {
        case contains
        case doesNotContain = "does_not_contain"
        case isEmpty = "is_empty"
        case isNotEmpty = "is_not_empty"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .contains(let value):
            try container.encode(value, forKey: .contains)
        case .doesNotContain(let value):
            try container.encode(value, forKey: .doesNotContain)
        case .isEmpty:
            try container.encode(true, forKey: .isEmpty)
        case .isNotEmpty:
            try container.encode(true, forKey: .isNotEmpty)
        }
    }
}

extension DatabasePropertyFilter.TextCondition: Encodable {
    enum CodingKeys: String, CodingKey {
        case equals
        case doesNotEqual = "does_not_equal"
        case contains
        case doesNotContain = "does_not_contain"
        case startsWith = "starts_with"
        case endsWith = "ends_with"
        case isEmpty = "is_empty"
        case isNotEmpty = "is_not_empty"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .equals(let value):
            try container.encode(value, forKey: .equals)
        case .doesNotEqual(let value):
            try container.encode(value, forKey: .doesNotEqual)
        case .contains(let value):
            try container.encode(value, forKey: .contains)
        case .doesNotContain(let value):
            try container.encode(value, forKey: .doesNotContain)
        case .startsWith(let value):
            try container.encode(value, forKey: .startsWith)
        case .endsWith(let value):
            try container.encode(value, forKey: .endsWith)
        case .isEmpty:
            try container.encode(true, forKey: .isEmpty)
        case .isNotEmpty:
            try container.encode(true, forKey: .isNotEmpty)
        }
    }
}

extension DatabasePropertyFilter.StatusCondition: Encodable {
    enum CodingKeys: String, CodingKey {
        case equals
        case doesNotEqual = "does_not_equal"
        case isEmpty = "is_empty"
        case isNotEmpty = "is_not_empty"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .equals(let value):
            try container.encode(value, forKey: .equals)
        case .doesNotEqual(let value):
            try container.encode(value, forKey: .doesNotEqual)
        case .isEmpty:
            try container.encode(true, forKey: .isEmpty)
        case .isNotEmpty:
            try container.encode(true, forKey: .isNotEmpty)
        }
    }
}

