//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import XCTest
@testable import NotionSwift

// swiftlint:disable line_length
final class FiltersTests: XCTestCase {

    func test_encode_simpleProperty() throws {
        let given: DatabaseFilter = .property(name: "title", type: .title(.contains("Hello world")))

        let result = try encodeToJson(given)
        XCTAssertEqual(result, #"{"property":"title","title":{"contains":"Hello world"}}"#)
    }

    func test_encode_simpleOrCondition() throws {
        let given: DatabaseFilter = .or([
            .property(name: "title", type: .title(.contains("Hello world"))),
            .property(name: "body", type: .richText(.contains("Hello world")))
        ])

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"{"or":[{"property":"title","title":{"contains":"Hello world"}},{"property":"body","rich_text":{"contains":"Hello world"}}]}"#)
    }

    func test_encode_simpleAndCondition() throws {
        let given: DatabaseFilter = .and([
            .property(name: "title", type: .title(.contains("Hello world"))),
            .property(name: "body", type: .richText(.contains("Hello world")))
        ])

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"{"and":[{"property":"title","title":{"contains":"Hello world"}},{"property":"body","rich_text":{"contains":"Hello world"}}]}"#)
    }

    func test_encode_docExample01() throws {
        let given: DatabaseFilter = .or([
            .property(name: "In stock", type: .checkbox(.equals(true))),
            .property(name: "Cost of next trip", type: .number(.greaterThanOrEqualTo(2)))
        ])

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"{"or":[{"checkbox":{"equals":true},"property":"In stock"},{"number":{"greater_than_or_equal_to":2},"property":"Cost of next trip"}]}"#)
    }
    
    func test_encode_numberFilters() throws {
        let given: DatabaseFilter = .or([
            .property(name: "Count", type: .number(.equals(1))),
            .property(name: "Count", type: .number(.doesNotEqual(1))),
            .property(name: "Count", type: .number(.greaterThan(1))),
            .property(name: "Count", type: .number(.greaterThanOrEqualTo(1))),
            .property(name: "Count", type: .number(.lessThan(1))),
            .property(name: "Count", type: .number(.lessThanOrEqualTo(1))),
            .property(name: "Count", type: .number(.isEmpty)),
            .property(name: "Count", type: .number(.isNotEmpty))
        ])

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"{"or":[{"number":{"equals":1},"property":"Count"},{"number":{"does_not_equal":1},"property":"Count"},{"number":{"greater_than":1},"property":"Count"},{"number":{"greater_than_or_equal_to":1},"property":"Count"},{"number":{"less_than":1},"property":"Count"},{"number":{"less_than_or_equal_to":1},"property":"Count"},{"number":{"is_empty":true},"property":"Count"},{"number":{"is_not_empty":true},"property":"Count"}]}"#)
    }
}
