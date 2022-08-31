//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public struct DatabaseSort {
    public enum TimestampValue: String {
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
    }
    public enum DirectionValue: String {
        case ascending
        case descending
    }

    public let property: String?
    public let timestamp: TimestampValue?
    public let direction: DirectionValue?
}

extension DatabaseSort {
    public static func ascending(
        property: String,
        timestamp: TimestampValue? = nil
    ) -> Self {
        .init(property: property, timestamp: timestamp, direction: .ascending)
    }

    public static func descending(
        property: String,
        timestamp: TimestampValue? = nil
    ) -> Self {
        .init(property: property, timestamp: timestamp, direction: .descending)
    }

    public static func ascending(
        timestamp: TimestampValue
    ) -> Self {
        .init(property: nil, timestamp: timestamp, direction: .ascending)
    }

    public static func descending(
        timestamp: TimestampValue
    ) -> Self {
        .init(property: nil, timestamp: timestamp, direction: .descending)
    }
}

// MARK: - Codable

extension DatabaseSort: Encodable {}
extension DatabaseSort.TimestampValue: Encodable {}
extension DatabaseSort.DirectionValue: Encodable {}
