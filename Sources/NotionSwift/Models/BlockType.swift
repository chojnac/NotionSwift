//
//  Created by Wojciech Chojnacki on 02/06/2021.
//

import Foundation

public enum BlockType {
    case paragraph(TextAndChildrenBlockValue)
    case heading1(HeadingBlockValue)
    case heading2(HeadingBlockValue)
    case heading3(HeadingBlockValue)
    case bulletedListItem(TextAndChildrenBlockValue)
    case numberedListItem(TextAndChildrenBlockValue)
    case toDo(ToDoBlockValue)
    case toggle(TextAndChildrenBlockValue)
    case code(CodeBlockValue)
    case childPage(ChildPageBlockValue)
    case childDatabase(ChildDatabaseBlockValue)
    case embed(EmbedBlockValue)
    case callout(CalloutBlockValue)
    case quote(QuoteBlockValue)
    case video(FileBlockValue)
    case audio(FileBlockValue)
    case image(FileBlockValue)
    case file(FileBlockValue)
    case pdf(FileBlockValue)
    case bookmark(BookmarkBlockValue)
    case equation(EquationBlockValue)
    case divider
    case tableOfContents
    case breadcrumb
    case column(ChildrenBlockValue)
    case columnList(ChildrenBlockValue)
    case unsupported(type: String)

    // MARK: - helper builders

    public static func paragraph(text: [RichText], children: [BlockType]? = nil) -> BlockType {
        return .paragraph(.init(text: text, children: children))
    }

    public static func heading1(text: [RichText]) -> BlockType {
        return .heading1(.init(text: text))
    }

    public static func heading2(text: [RichText]) -> BlockType {
        return .heading2(.init(text: text))
    }

    public static func heading3(text: [RichText]) -> BlockType {
        return .heading3(.init(text: text))
    }

    public static func bulletedListItem(text: [RichText], children: [BlockType]? = nil) -> BlockType {
        return .bulletedListItem(.init(text: text, children: children))
    }

    public static func numberedListItem(text: [RichText], children: [BlockType]? = nil) -> BlockType {
        return .numberedListItem(.init(text: text, children: children))
    }

    public static func toDo(text: [RichText], checked: Bool? = nil, children: [BlockType]? = nil) -> BlockType {
        return .toDo(.init(text: text, checked: checked, children: children))
    }

    public static func toggle(text: [RichText], children: [BlockType]? = nil) -> BlockType {
        return .toggle(.init(text: text, children: children))
    }

    public static func code(text: [RichText], language: String? = nil) -> BlockType {
        return .code(.init(text: text, language: language))
    }

    public static func childPage(_ title: String) -> BlockType {
        return .childPage(.init(title: title))
    }

    public static func childDatabase(_ title: String) -> BlockType {
        return .childPage(.init(title: title))
    }

    public static func embed(url: String, caption: [RichText]) -> BlockType {
        return .embed(.init(url: url, caption: caption))
    }

    public static func callout(text: [RichText], children: [BlockType]? = nil, icon: IconFile? = nil) -> BlockType {
        return .callout(.init(text: text, children: children, icon: icon))
    }

    public static func quote(text: [RichText], children: [BlockType]? = nil) -> BlockType {
        return .quote(.init(text: text, children: children))
    }

    public static func video(file: FileFile, caption: [RichText] = []) -> BlockType {
        return .video(.init(file: file, caption: caption))
    }

    public static func audio(file: FileFile, caption: [RichText] = []) -> BlockType {
        return .audio(.init(file: file, caption: caption))
    }

    public static func image(file: FileFile, caption: [RichText] = []) -> BlockType {
        return .image(.init(file: file, caption: caption))
    }

    public static func file(file: FileFile, caption: [RichText] = []) -> BlockType {
        return .file(.init(file: file, caption: caption))
    }

    public static func pdf(file: FileFile, caption: [RichText] = []) -> BlockType {
        return .pdf(.init(file: file, caption: caption))
    }

    public static func bookmark(url: String, caption: [RichText] = []) -> BlockType {
        return .bookmark(.init(url: url, caption: caption))
    }

    public static func equation(expression: String) -> BlockType {
        return .equation(.init(expression: expression))
    }

}

extension BlockType {

    public struct ChildrenBlockValue {
        /// field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?

        public init(children: [BlockType]? = nil) {
            self.children = children
        }

        public static let none = ChildrenBlockValue(children: nil)
    }

    public struct TextAndChildrenBlockValue {
        public let text: [RichText]
        /// field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?

        public init(text: [RichText], children: [BlockType]? = nil) {
            self.text = text
            self.children = children
        }
    }

    public struct HeadingBlockValue {
        public let text: [RichText]

        public init(text: [RichText]) {
            self.text = text
        }
    }

    public struct ToDoBlockValue {
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

    public struct ChildPageBlockValue {
        public let title: String

        public init(title: String) {
            self.title = title
        }
    }

    public struct ChildDatabaseBlockValue {
        public let title: String

        public init(title: String) {
            self.title = title
        }
    }

    public struct CodeBlockValue {
        public let text: [RichText]
        public let language: String?

        public init(text: [RichText], language: String? = nil) {
            self.text = text
            self.language = language
        }
    }

    public struct CalloutBlockValue {
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

    public struct QuoteBlockValue {
        public let text: [RichText]
        // field used only for encoding for adding/appending new blocks
        public let children: [BlockType]?

        public init(text: [RichText], children: [BlockType]? = nil) {
            self.text = text
            self.children = children
        }
    }

    public struct EmbedBlockValue {
        public let url: String
        public let caption: [RichText]

        public init(url: String, caption: [RichText]) {
            self.url = url
            self.caption = caption
        }
    }

    public struct BookmarkBlockValue {
        public let url: String
        public let caption: [RichText]

        public init(url: String, caption: [RichText]) {
            self.url = url
            self.caption = caption
        }
    }

    public struct FileBlockValue {
        public let file: FileFile
        public let caption: [RichText]

        public init(file: FileFile, caption: [RichText]) {
            self.file = file
            self.caption = caption
        }
    }

    public struct EquationBlockValue {
        public let expression: String

        public init(expression: String) {
            self.expression = expression
        }
    }
}

// MARK: - Codable
extension BlockType: Codable {

    enum CodingKeys: String, CodingKey {
        case type
        case paragraph
        case heading1 = "heading_1"
        case heading2 = "heading_2"
        case heading3 = "heading_3"
        case bulletedListItem = "bulleted_list_item"
        case numberedListItem = "numbered_list_item"
        case toDo = "to_do"
        case toggle
        case childPage = "child_page"
        case childDatabase = "child_database"
        case code
        case embed
        case callout
        case quote
        case video
        case audio
        case image
        case file
        case pdf
        case bookmark
        case equation
        case divider
        case tableOfContents = "table_of_contents"
        case breadcrumb
        case column
        case columnList = "column_list"
        case unsupported
    }

    private var codingKey: CodingKeys {
        switch self {
        case .paragraph:
            return .paragraph
        case .heading1:
            return .heading1
        case .heading2:
            return .heading2
        case .heading3:
            return .heading3
        case .bulletedListItem:
            return .bulletedListItem
        case .numberedListItem:
            return .numberedListItem
        case .toDo:
            return .toDo
        case .toggle:
            return .toggle
        case .childPage:
            return .childPage
        case .childDatabase:
            return .childDatabase
        case .embed:
            return .embed
        case .callout:
            return .callout
        case .quote:
            return .quote
        case .video:
            return .video
        case .audio:
            return .audio
        case .image:
            return .image
        case .file:
            return .file
        case .pdf:
            return .pdf
        case .bookmark:
            return .bookmark
        case .equation:
            return .equation
        case .divider:
            return .divider
        case .tableOfContents:
            return .tableOfContents
        case .unsupported:
            return .unsupported
        case .code:
            return .code
        case .column:
            return .column
        case .columnList:
            return .columnList
        case .breadcrumb:
            return .breadcrumb
        }
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        guard let key = CodingKeys(stringValue: type) else {
            self = .unsupported(type: type)
            return
        }

        switch key {
        case .paragraph:
            let value = try container.decode(TextAndChildrenBlockValue.self, forKey: key)
            self = .paragraph(value)
        case .heading1:
            let value = try container.decode(HeadingBlockValue.self, forKey: key)
            self = .heading1(value)
        case .heading2:
            let value = try container.decode(HeadingBlockValue.self, forKey: key)
            self = .heading2(value)
        case .heading3:
            let value = try container.decode(HeadingBlockValue.self, forKey: key)
            self = .heading3(value)
        case .bulletedListItem:
            let value = try container.decode(TextAndChildrenBlockValue.self, forKey: key)
            self = .bulletedListItem(value)
        case .numberedListItem:
            let value = try container.decode(TextAndChildrenBlockValue.self, forKey: key)
            self = .numberedListItem(value)
        case .toDo:
            let value = try container.decode(ToDoBlockValue.self, forKey: key)
            self = .toDo(value)
        case .toggle:
            let value = try container.decode(TextAndChildrenBlockValue.self, forKey: key)
            self = .toggle(value)
        case .code:
            let value = try container.decode(CodeBlockValue.self, forKey: key)
            self = .code(value)
        case .childPage:
            let value = try container.decode(ChildPageBlockValue.self, forKey: key)
            self = .childPage(value)
        case .childDatabase:
            let value = try container.decode(ChildDatabaseBlockValue.self, forKey: key)
            self = .childDatabase(value)
        case .embed:
            let value = try container.decode(EmbedBlockValue.self, forKey: key)
            self = .embed(value)
        case .callout:
            let value = try container.decode(CalloutBlockValue.self, forKey: key)
            self = .callout(value)
        case .quote:
            let value = try container.decode(QuoteBlockValue.self, forKey: key)
            self = .quote(value)
        case .video:
            let value = try container.decode(FileBlockValue.self, forKey: key)
            self = .video(value)
        case .audio:
            let value = try container.decode(FileBlockValue.self, forKey: key)
            self = .audio(value)
        case .image:
            let value = try container.decode(FileBlockValue.self, forKey: key)
            self = .image(value)
        case .file:
            let value = try container.decode(FileBlockValue.self, forKey: key)
            self = .file(value)
        case .pdf:
            let value = try container.decode(FileBlockValue.self, forKey: key)
            self = .pdf(value)
        case .bookmark:
            let value = try container.decode(BookmarkBlockValue.self, forKey: key)
            self = .bookmark(value)
        case .equation:
            let value = try container.decode(EquationBlockValue.self, forKey: key)
            self = .equation(value)
        case .divider:
            self = .divider
        case .tableOfContents:
            self = .tableOfContents
        case .breadcrumb:
            self = .breadcrumb
        case .column:
            let value = try container.decode(ChildrenBlockValue.self, forKey: key)
            self = .column(value)
        case .columnList:
            let value = try container.decode(ChildrenBlockValue.self, forKey: key)
            self = .columnList(value)
        case .type, .unsupported:
            self = .unsupported(type: type)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let key = self.codingKey
        try container.encode(key.stringValue, forKey: .type)
        switch self {
        case .paragraph(let value):
            try container.encode(value, forKey: key)
        case .heading1(let value):
            try container.encode(value, forKey: key)
        case .heading2(let value):
            try container.encode(value, forKey: key)
        case .heading3(let value):
            try container.encode(value, forKey: key)
        case .bulletedListItem(let value):
            try container.encode(value, forKey: key)
        case .numberedListItem(let value):
            try container.encode(value, forKey: key)
        case .toDo(let value):
            try container.encode(value, forKey: key)
        case .toggle(let value):
            try container.encode(value, forKey: key)
        case .childPage(let value):
            try container.encode(value, forKey: key)
        case .code(let value):
            try container.encode(value, forKey: key)
        case .childDatabase(let value):
            try container.encode(value, forKey: key)
        case .embed(let value):
            try container.encode(value, forKey: key)
        case .callout(let value):
            try container.encode(value, forKey: key)
        case .quote(let value):
            try container.encode(value, forKey: key)
        case .video(let value):
            try container.encode(value, forKey: key)
        case .audio(let value):
            try container.encode(value, forKey: key)
        case .image(let value):
            try container.encode(value, forKey: key)
        case .file(let value):
            try container.encode(value, forKey: key)
        case .pdf(let value):
            try container.encode(value, forKey: key)
        case .bookmark(let value):
            try container.encode(value, forKey: key)
        case .equation(let value):
            try container.encode(value, forKey: key)
        case .divider, .tableOfContents, .breadcrumb, .column, .columnList:
            try container.encode([String: String](), forKey: key)
            break
        case .unsupported:
            break
        }
    }
}

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
