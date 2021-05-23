//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import XCTest
@testable import NotionSwift

final class FiltersTests: XCTestCase {

    func test_encode_simpleProperty() throws {
        let given: Filter = .property(name: "title", type: .title(.contains("Hello world")))

        let result = try encodeToJson(given)
        XCTAssertEqual(result, #"[{"title":{"contains":"Hello world"},"property":"title"}]"#)
    }

    func test_encode_simpleOrCondition() throws {
        let given: Filter = .or([
            .property(name: "title", type: .title(.contains("Hello world"))),
            .property(name: "body", type: .rich_text(.contains("Hello world")))
        ])

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"[{"or":[{"title":{"contains":"Hello world"},"property":"title"},{"rich_text":{"contains":"Hello world"},"property":"body"}]}]"#)
    }

    func test_encode_simpleAndCondition() throws {
        let given: Filter = .and([
            .property(name: "title", type: .title(.contains("Hello world"))),
            .property(name: "body", type: .rich_text(.contains("Hello world")))
        ])

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"[{"and":[{"title":{"contains":"Hello world"},"property":"title"},{"rich_text":{"contains":"Hello world"},"property":"body"}]}]"#)
    }

    func test_encode_docExample01() throws {
        let given: Filter = .or([
            .property(name: "In stock", type: .checkbox(.equals(true))),
            .property(name: "Cost of next trip", type: .number(.greaterThanOrEqualTo(2)))
        ])

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"[{"or":[{"property":"In stock","checkbox":{"equals":true}},{"number":{"greater_than_or_equal_to":2},"property":"Cost of next trip"}]}]"#)
    }
}
