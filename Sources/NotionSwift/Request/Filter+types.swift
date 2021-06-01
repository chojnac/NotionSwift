//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public enum FilterType {
    case databaseProperty(DatabasePropertyFilter)
    case compound(CompountFilterType)
}

public struct DatabasePropertyFilter {
    let property: String
    let filterType: PropertyType
}

public enum CompountFilterType {
    case or([FilterType])
    case and([FilterType])
}

extension DatabasePropertyFilter {
    public enum PropertyType {
        case title(TextCondition)
        case rich_text(TextCondition)
        case url(TextCondition)
        case email(TextCondition)
        case phone(TextCondition)
        case number(NumberCondition)
        case checkbox(CheckboxCondition)
        case select(SimpleGenericCondition<String>)
        case multiSelect(SimpleGenericCondition<String>)
        case date(DateCondition)
        case created_time(DateCondition)
        case last_edited_time(DateCondition)
        case dateBy(SimpleGenericCondition<UUIDv4>)
        case created_by(SimpleGenericCondition<UUIDv4>)
        case last_edited_by(SimpleGenericCondition<UUIDv4>)
        case files(FilesCondition)
        case relation(SimpleGenericCondition<UUIDv4>)
        case formula(FormulaCondition)
    }
}

extension DatabasePropertyFilter {
    public enum FormulaCondition {
        #warning("Add implementation")
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
        #warning("Add implementation")
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
        case equals(Int)
        case doesNotEqual(Int)
        case greaterThan(Int)
        case lessThan(Int)
        case greaterThanOrEqualTo(Int)
        case lessThanOrEqualTo(Int)
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
