//
//  Created by Wojciech Chojnacki on 15/11/2021.
//

import Foundation

public enum DateValue {
    case dateOnly(Date)
    case dateAndTime(Date)
}


extension DateValue: Codable {
    static let errorMessage = "Date string does not match format expected by formatter."
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        if let date = DateFormatter.iso8601Full.date(from: value) {
            self = .dateAndTime(date)
            return
        }

        if let date = DateFormatter.iso8601DateOnly.date(from: value) {
            self = .dateOnly(date)
            return
        }

        throw Swift.DecodingError.dataCorruptedError(
            in: container,
            debugDescription: Self.errorMessage
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        let value: String
        switch self {
        case .dateOnly(let date):
            value = DateFormatter.iso8601DateOnly.string(from: date)
        case .dateAndTime(let date):
            value = DateFormatter.iso8601Full.string(from: date)
        }

        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
