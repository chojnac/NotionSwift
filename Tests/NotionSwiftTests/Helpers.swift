//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation
@testable import NotionSwift

func encodeToJson<T: Encodable>(_ entity: T) throws -> String {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
    let data = try encoder.encode(entity)
    return String(data: data, encoding: .utf8)!
}
