//
//  Created by Wojciech Chojnacki on 22/03/2022.
//

import Foundation

public extension BlockType {

    struct ChildrenBlockValue {
        /// field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?

        public init(children: [BlockType]? = nil) {
            self.children = children
        }

        public static let none = ChildrenBlockValue(children: nil)
    }

    struct TextAndChildrenBlockValue {
        public let text: [RichText]
        /// field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?

        public init(text: [RichText], children: [BlockType]? = nil) {
            self.text = text
            self.children = children
        }
    }

    struct HeadingBlockValue {
        public let text: [RichText]

        public init(text: [RichText]) {
            self.text = text
        }
    }

    struct ToDoBlockValue {
        public let text: [RichText]
        public let checked: Bool?
        // field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?

        public init(text: [RichText], checked: Bool? = nil, children: [BlockType]? = nil) {
            self.text = text
            self.checked = checked
            self.children = children
        }
    }

    struct ChildPageBlockValue {
        public let title: String

        public init(title: String) {
            self.title = title
        }
    }

    struct ChildDatabaseBlockValue {
        public let title: String

        public init(title: String) {
            self.title = title
        }
    }

    struct CodeBlockValue {
        public let text: [RichText]
        public let language: String?

        public init(text: [RichText], language: String? = nil) {
            self.text = text
            self.language = language
        }
    }

    struct CalloutBlockValue {
        public let text: [RichText]
        // field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?
        public let icon: IconFile?

        public init(text: [RichText], children: [BlockType]? = nil, icon: IconFile? = nil) {
            self.text = text
            self.children = children
            self.icon = icon
        }
    }

    struct QuoteBlockValue {
        public let text: [RichText]
        // field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?

        public init(text: [RichText], children: [BlockType]? = nil) {
            self.text = text
            self.children = children
        }
    }

    struct EmbedBlockValue {
        public let url: String
        public let caption: [RichText]

        public init(url: String, caption: [RichText]) {
            self.url = url
            self.caption = caption
        }
    }

    struct BookmarkBlockValue {
        public let url: String
        public let caption: [RichText]

        public init(url: String, caption: [RichText]) {
            self.url = url
            self.caption = caption
        }
    }

    struct FileBlockValue {
        public let file: FileFile
        public let caption: [RichText]

        public init(file: FileFile, caption: [RichText]) {
            self.file = file
            self.caption = caption
        }
    }

    struct EquationBlockValue {
        public let expression: String

        public init(expression: String) {
            self.expression = expression
        }
    }

    enum LinkToPageBlockValue {
        case page(Page.Identifier)
        case database(Database.Identifier)
        case unknown
    }

    enum SyncedBlockValue {
        case originalBlock
        case reference(Block.Identifier)
    }

    struct TemplateBlockValue {
        public let text: [RichText]
        /// field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?

        public init(text: [RichText], children: [BlockType]? = nil) {
            self.text = text
            self.children = children
        }
    }
}

// MARK: - Codable

extension BlockType.ChildrenBlockValue: Codable {}
extension BlockType.TextAndChildrenBlockValue: Codable {}
extension BlockType.HeadingBlockValue: Codable {}
extension BlockType.ToDoBlockValue: Codable {}
extension BlockType.ChildPageBlockValue: Codable {}
extension BlockType.ChildDatabaseBlockValue: Codable {}
extension BlockType.EmbedBlockValue: Codable {}
extension BlockType.CalloutBlockValue: Codable {}
extension BlockType.CodeBlockValue: Codable {}
extension BlockType.QuoteBlockValue: Codable {}
extension BlockType.BookmarkBlockValue: Codable {}
extension BlockType.EquationBlockValue: Codable {}
extension BlockType.TemplateBlockValue: Codable {}

extension BlockType.FileBlockValue: Codable {
    enum CodingKeys: String, CodingKey {
        case caption
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.caption = try container.decode([RichText].self, forKey: .caption)
        self.file = try FileFile(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(caption, forKey: .caption)
        try file.encode(to: encoder)
    }
}

extension BlockType.LinkToPageBlockValue: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case pageId = "page_id"
        case databaseId = "database_id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case CodingKeys.pageId.rawValue:
            let value = try container.decode(Page.Identifier.self, forKey: .pageId)
            self = .page(value)
        case CodingKeys.databaseId.rawValue:
            let value = try container.decode(Database.Identifier.self, forKey: .databaseId)
            self = .database(value)
        default:
            self = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .database(let value):
            try container.encode(CodingKeys.databaseId.rawValue, forKey: .type)
            try container.encode(value, forKey: .databaseId)
        case .page(let value):
            try container.encode(CodingKeys.pageId.rawValue, forKey: .type)
            try container.encode(value, forKey: .pageId)
        case .unknown:
            break
        }
    }
}

extension BlockType.SyncedBlockValue: Codable {
    enum CodingKeys: String, CodingKey {
        case syncedFrom = "synced_from"
        case children
    }

    private struct _ReferenceValue: Codable {
        let block_id: Block.Identifier
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let reference = try container.decodeIfPresent(_ReferenceValue.self, forKey: .syncedFrom) {
            self = .reference(reference.block_id)
        } else {
            self = .originalBlock
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .reference(let identifier):
            try container.encode(_ReferenceValue(block_id: identifier), forKey: .syncedFrom)
        case .originalBlock:
            try container.encode(Optional<_ReferenceValue>.none, forKey: .syncedFrom)
        }
    }
}
