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
    case childPage(ChildBlockValue)
    case image(ImageBlockValue)
    case unsupported

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

    public static func childPage(_ title: String) -> BlockType {
        return .childPage(.init(title: title))
    }
    
    public static func image(caption: [RichText], file: ImageBlockValue.FileBlock?) -> BlockType {
        return .image(.init(caption: caption, file: file))
    }
}

extension BlockType {
    public struct TextAndChildrenBlockValue {
        public let text: [RichText]
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
        public let children: [BlockType]?

        public init(text: [RichText], checked: Bool? = nil, children: [BlockType]? = nil) {
            self.text = text
            self.checked = checked
            self.children = children
        }
    }

    public struct ChildBlockValue {
        public let title: String

        public init(title: String) {
            self.title = title
        }
    }
    
    public struct ImageBlockValue {
        public struct FileBlock: Codable {
            public let url: String
            public let expiryTime: Date
            
            enum CodingKeys: String, CodingKey {
                case url
                case expiryTime = "expiry_time"
            }
        }
        
        public let caption: [RichText]
        public let file: FileBlock?

        public init(caption: [RichText], file: FileBlock?) {
            self.caption = caption
            self.file = file
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
        case image = "image"
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
        case .image:
            return .image
        case .unsupported:
            return .unsupported
        }
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        guard let key = CodingKeys(stringValue: type) else {
            self = .unsupported
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
        case .childPage:
            let value = try container.decode(ChildBlockValue.self, forKey: key)
            self = .childPage(value)
        case .image:
            let value = try container.decode(ImageBlockValue.self, forKey: key)
            self = .image(value)
        case .type, .unsupported:
            self = .unsupported
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
        case .image(let value):
            try container.encode(value, forKey: key)
        case .unsupported:
            break
        }
    }
}

extension BlockType.TextAndChildrenBlockValue: Codable {}
extension BlockType.HeadingBlockValue: Codable {}
extension BlockType.ToDoBlockValue: Codable {}
extension BlockType.ChildBlockValue: Codable {}
extension BlockType.ImageBlockValue: Codable {}
