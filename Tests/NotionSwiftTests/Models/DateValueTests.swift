//
//  Created by Wojciech Chojnacki on 15/11/2021.
//

import XCTest
@testable import NotionSwift

final class DateValueTests: XCTestCase {
    func testEncodeDateOnly() throws {
        let underTest = DateValue.dateOnly(buildDayDate(day: 10, month: 11, year: 2021))

        let result = try encodeToJson(underTest)

        XCTAssertEqual(result, "\"2021-11-10\"")
    }

    func testEncodeDateAndTime() throws {
        let underTest = DateValue.dateAndTime(buildTimeDate(day: 10, month: 11, year: 2021, hour: 23, min: 22, sec: 45))

        let result = try encodeToJson(underTest)

        XCTAssertEqual(result, "\"2021-11-10T23:22:45.000Z\"")
    }
}

