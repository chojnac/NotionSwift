//
//  Created by Wojciech Chojnacki on 17/04/2022.
//

import XCTest
@testable import NotionSwift

final class BlockColorTest: XCTestCase {
    func testEncodeValue() throws {
        let underTest = BlockColor.brownBackground

        let result = try encodeToJson(underTest)

        XCTAssertEqual(result, "\"brown_background\"")
    }
    
    func testEncodeUnknownValue() throws {
        let underTest = BlockColor.unknown("some_color")

        let result = try encodeToJson(underTest)

        XCTAssertEqual(result, "\"some_color\"")
    }
    
    func testDecodeValue() throws {
        let underTest = "\"brown_background\""

        let result: BlockColor = try decodeFromJson(underTest)

        XCTAssertEqual(result, BlockColor.brownBackground)
    }
    
    func testDecodeUnknownValue() throws {
        let underTest = "\"something\""

        let result: BlockColor = try decodeFromJson(underTest)

        XCTAssertEqual(result, BlockColor.unknown("something"))
    }
}
