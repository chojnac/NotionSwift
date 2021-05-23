//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public struct SortObject: Encodable {
    public enum TimestampValue: String, Encodable {
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
    }
    public enum DirectionValue: String, Encodable {
        case ascending
        case descending
    }

    let property: String
    let timestamp: TimestampValue?
    let direction: DirectionValue?
}
