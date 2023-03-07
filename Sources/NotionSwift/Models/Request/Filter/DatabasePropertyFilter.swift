//
//  Created by Wojciech Chojnacki on 02/06/2021.
//

import Foundation

public struct DatabasePropertyFilter {
    public let property: String
    public let filterType: PropertyType
}

extension DatabasePropertyFilter {
    public enum PropertyType {
        case title(TextCondition)
        case richText(TextCondition)
        case url(TextCondition)
        case email(TextCondition)
        case phoneNumber(TextCondition)
        case number(NumberCondition)
        case checkbox(CheckboxCondition)
        case select(SimpleGenericCondition<String>)
        case multiSelect(SimpleGenericCondition<String>)
        case date(DateCondition)
        case createdTime(DateCondition)
        case lastEditedTime(DateCondition)
        case dateBy(SimpleGenericCondition<UUIDv4>)
        case createdBy(SimpleGenericCondition<UUIDv4>)
        case lastEditedBy(SimpleGenericCondition<UUIDv4>)
        case files(FilesCondition)
        case relation(SimpleGenericCondition<UUIDv4>)
        case formula(FormulaCondition)
    }
}

extension DatabasePropertyFilter {
    public enum FormulaCondition {
        case string(TextCondition)
        case checkbox(CheckboxCondition)
        case number(NumberCondition)
        case date(DateCondition)
    }
}

extension DatabasePropertyFilter {
    public enum FilesCondition {
        case isEmpty
        case isNotEmpty
    }
}

extension DatabasePropertyFilter {
    public enum DateCondition {
        case equals(Date)
        case before(Date)
        case after(Date)
        case onOrBefore(Date)
        case isEmpty
        case isNotEmpty
        case onOrAfter(Date)
        case pastWeek
        case pastMonth
        case pastYear
        case thisWeek
        case nextWeek
        case nextMonth
        case nextYear
    }
}

extension DatabasePropertyFilter {
    public enum SimpleGenericCondition<T: Encodable> {
        case contains(T)
        case doesNotContain(T)
        case isEmpty
        case isNotEmpty
    }
}

extension DatabasePropertyFilter {
    public enum CheckboxCondition {
        case equals(Bool)
        case doesNotEqual(Bool)
    }
}

extension DatabasePropertyFilter {
    public enum NumberCondition {
        case equals(Double)
        case doesNotEqual(Double)
        case greaterThan(Double)
        case lessThan(Double)
        case greaterThanOrEqualTo(Double)
        case lessThanOrEqualTo(Double)
        case isEmpty
        case isNotEmpty
    }
}

extension DatabasePropertyFilter {
    public enum TextCondition {
        case equals(String)
        case doesNotEqual(String)
        case contains(String)
        case doesNotContain(String)
        case startsWith(String)
        case endsWith(String)
        case isEmpty
        case isNotEmpty
    }
}
