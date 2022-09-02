//
//  Created by Michal Zolnieruk on 02/09/2022.
//

import Foundation

import XCTest
@testable import NotionSwift

// swiftlint:disable line_length
final class PageTests: XCTestCase {

    func test_rollupwithnullnumber_deserialization() throws {
        let json = """
            {
              "object": "page",
              "id": "0556881a-b22c-42f8-a841-e64cdf1507aa",
              "created_time": "2022-09-02T16:14:00.000Z",
              "last_edited_time": "2022-09-02T16:14:00.000Z",
              "created_by": {
                "object": "user",
                "id": "25c72bb8-e257-4525-b508-abe1436dc6c1"
              },
              "last_edited_by": {
                "object": "user",
                "id": "25c72bb8-e257-4525-b508-abe1436dc6c1"
              },
              "cover": null,
              "icon": null,
              "parent": {
                "type": "database_id",
                "database_id": "b33717ea-7c4b-4848-b456-9cb4f9c99441"
              },
              "archived": false,
              "properties": {
                "Progress": {
                  "id": "fmwt",
                  "type": "rollup",
                  "rollup": {
                    "type": "number",
                    "number": null,
                    "function": "percent_checked"
                  }
                },
                "Name": {
                  "id": "title",
                  "type": "title",
                  "title": [
                    {
                      "type": "text",
                      "text": {
                        "content": "Test",
                        "link": null
                      },
                      "annotations": {
                        "bold": false,
                        "italic": false,
                        "strikethrough": false,
                        "underline": false,
                        "code": false,
                        "color": "default"
                      },
                      "plain_text": "Test",
                      "href": null
                    }
                  ]
                }
              },
              "url": "https://www.notion.so/Test-0556881ab22c42f8a841e64cdf1507aa"
            }
            """

        let _ : Page = try decodeFromJson(json)
    }
}
