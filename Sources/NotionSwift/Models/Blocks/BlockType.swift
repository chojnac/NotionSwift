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
    case linkToPage(LinkToPageBlockValue)
    case syncedBlock(SyncedBlockValue)
    case template(TemplateBlockValue)
    case unsupported(type: String)
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
        case linkToPage = "link_to_page"
        case syncedBlock = "synced_block"
        case template
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
        case .linkToPage:
            return .linkToPage
        case .syncedBlock:
            return .syncedBlock
        case .template:
            return .template
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
        case .linkToPage:
            let value = try container.decode(LinkToPageBlockValue.self, forKey: key)
            self = .linkToPage(value)
        case .syncedBlock:
            let value = try container.decode(SyncedBlockValue.self, forKey: key)
            self = .syncedBlock(value)
        case .template:
            let value = try container.decode(TemplateBlockValue.self, forKey: key)
            self = .template(value)
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
        case .linkToPage(let value):
            try container.encode(value, forKey: key)
        case .syncedBlock(let value):
            try container.encode(value, forKey: key)
        case .template(let value):
            try container.encode(value, forKey: key)
        case .columnList(let value):
            try container.encode(value, forKey: key)
        case .column(let value):
            try container.encode(value, forKey: key)
        case .divider, .tableOfContents, .breadcrumb:
            try container.encode([String: String](), forKey: key)
            break
        case .unsupported:
            break
        }
    }
}
