//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public struct SortObject {
    public enum TimestampValue: String {
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
    }
    public enum DirectionValue: String {
        case ascending
        case descending
    }

    let property: String
    let timestamp: TimestampValue?
    let direction: DirectionValue?
}

// MARK: - Codable

extension SortObject: Encodable {}
extension SortObject.TimestampValue: Encodable {}
extension SortObject.DirectionValue: Encodable {}
