//
//  Created by Wojciech Chojnacki on 02/06/2021.
//

import Foundation

import XCTest
@testable import NotionSwift

// swiftlint:disable line_length
final class PageCreateRequestTests: XCTestCase {
    func test_propertiesEncoding_case01() throws {
        let parentId = Page.Identifier("12345")
        let given = PageCreateRequest(
            parent: .page(parentId),
            properties: ["title": .init(type: .title([.init(string: "Lorem ipsum")]))],
            children: []
        )

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"{"children":[],"parent":{"type":"page_id","page_id":"12345"},"properties":{"title":{"title":[{"text":{"content":"Lorem ipsum"}}]}}}"#)
    }

    func test_propertiesAndChildrenEncoding_case01() throws {
        let parentId = Page.Identifier("12345")
        let children: [WriteBlock] = [
            .init(type: .paragraph(.init(text: [
                .init(string: "Lorem ipsum dolor sit amet, ")
            ])))
        ]
        let given = PageCreateRequest(
            parent: .page(parentId),
            properties: ["title": .init(type: .title([.init(string: "Lorem ipsum")]))],
            children: children
        )

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"{"children":[{"has_children":false,"object":"block","paragraph":{"text":[{"text":{"content":"Lorem ipsum dolor sit amet, "}}]},"type":"paragraph"}],"parent":{"type":"page_id","page_id":"12345"},"properties":{"title":{"title":[{"text":{"content":"Lorem ipsum"}}]}}}"#)
    }

    func test_childrenEncoding_case01() throws {
        let parentId = Page.Identifier("12345")
        let children: [WriteBlock] = [
            .init(type: .paragraph(.init(text: [
                .init(string: "Lorem ipsum dolor sit amet, ")
            ])))
        ]

        let given = PageCreateRequest(
            parent: .page(parentId),
            properties: [:],
            children: children
        )

        let result = try encodeToJson(given)

        XCTAssertEqual(result, #"{"children":[{"has_children":false,"object":"block","paragraph":{"text":[{"text":{"content":"Lorem ipsum dolor sit amet, "}}]},"type":"paragraph"}],"parent":{"type":"page_id","page_id":"12345"},"properties":{}}"#)
    }
    
    /// Please test this with a page that has an image block as first block
    func testImageBlock() {
        let expectation = XCTestExpectation(description: "Testing block image support")
        
        let parentId = Block.Identifier("id")
        NotionClient(accessKeyProvider: StringAccessKeyProvider(accessKey: "secret")).blockChildren(blockId: parentId) { result in
            switch result {
            case .success(let blocks):
                XCTAssertNotNil(blocks.results.first?.type)
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
