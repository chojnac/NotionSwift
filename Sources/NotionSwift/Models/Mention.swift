//
//  Created by Wojciech Chojnacki on 02/06/2021.
//

import Foundation

public struct MentionTypeValue {
    public enum MentionType {
        case user(User)
        case page(PageMentionValue)
        case database(DatabaseMentionValue)
        case date(DateRange)
        case unknown
    }

    public let type: MentionType

    public init(type: MentionType) {
        self.type = type
    }
}

extension MentionTypeValue {

    public struct PageMentionValue {
        public let id: Page.Identifier

        public init(_ id: Page.Identifier) {
            self.id = id
        }
    }

    public struct DatabaseMentionValue {
        public let id: Database.Identifier

        public init(_ id: Database.Identifier) {
            self.id = id
        }
    }
}

extension MentionTypeValue: Codable {

    public init(from decoder: Decoder) throws {
        self.type = try MentionType(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try type.encode(to: encoder)
    }
}

extension MentionTypeValue.MentionType: Codable {
    enum CodingKeys: String, CodingKey {
        case user
        case page
        case database
        case date
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case CodingKeys.user.stringValue:
            let value = try container.decode(User.self, forKey: .user)
            self = .user(value)
        case CodingKeys.page.stringValue:
            let value = try container.decode(MentionTypeValue.PageMentionValue.self, forKey: .page)
            self = .page(value)
        case CodingKeys.database.stringValue:
            let value = try container.decode(MentionTypeValue.DatabaseMentionValue.self, forKey: .database)
            self = .database(value)
        case CodingKeys.date.stringValue:
            let value = try container.decode(DateRange.self, forKey: .date)
            self = .date(value)
        default:
            self = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .user(let value):
            try container.encode(CodingKeys.user.stringValue, forKey: .type)
            try container.encode(value, forKey: .user)
        case .page(let value):
            try container.encode(CodingKeys.page.stringValue, forKey: .type)
            try container.encode(value, forKey: .page)
        case .database(let value):
            try container.encode(CodingKeys.database.stringValue, forKey: .type)
            try container.encode(value, forKey: .database)
        case .date(let value):
            try container.encode(CodingKeys.date.stringValue, forKey: .type)
            try container.encode(value, forKey: .date)
        case .unknown:
            break
        }
    }
}

extension MentionTypeValue.PageMentionValue: Codable {}
extension MentionTypeValue.DatabaseMentionValue: Codable {}
