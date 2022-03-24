//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation
@testable import NotionSwift

func encodeToJson<T: Encodable>(_ entity: T) throws -> String {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
    encoder.outputFormatting = [.sortedKeys]
    let data = try encoder.encode(entity)
    return String(data: data, encoding: .utf8)!
}

func buildDayDate(day: Int, month: Int, year: Int) -> Date {
    var c = DateComponents()
    c.setValue(day, for: .day)
    c.setValue(month, for: .month)
    c.setValue(year, for: .year)

    return Calendar.current.date(from: c)!
}

func buildTimeDate(day: Int, month: Int, year: Int, hour: Int, min: Int, sec: Int) -> Date {
    var c = DateComponents()
    c.setValue(day, for: .day)
    c.setValue(month, for: .month)
    c.setValue(year, for: .year)
    c.setValue(hour, for: .hour)
    c.setValue(min, for: .minute)
    c.setValue(sec, for: .second)

    return Calendar.current.date(from: c)!
}

