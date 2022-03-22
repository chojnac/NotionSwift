//
//  Created by Wojciech Chojnacki on 21/03/2022.
//

import Foundation

public extension WriteBlock {
    // Helper type
    struct Column {
        let children: [BlockType]
        public static func column(_ children: [BlockType]) -> Self {
            return .init(children: children)
        }
    }
    
    static func paragraph(
        _ text: [RichText],
        children: [BlockType]? = nil
    ) -> Self {
        .init(type: .paragraph(text, children: children))
    }
    
    static func heading1(_ text: [RichText]) -> Self {
        .init(type: .heading1(text))
    }
    
    static func heading2(_ text: [RichText]) -> Self {
        .init(type: .heading2(text))
    }
    
    static func heading3(_ text: [RichText]) -> Self {
        .init(type: .heading3(text))
    }
    
    static func bulletedListItem(
        _ text: [RichText],
        children: [BlockType]? = nil
    ) -> Self {
        .init(type: .bulletedListItem(text, children: children))
    }
    static func numberedListItem(
        _ text: [RichText],
        children: [BlockType]? = nil
    ) -> Self {
        .init(type: .numberedListItem(text, children: children))
    }
    static func toDo(
        _ text: [RichText],
        children: [BlockType]? = nil,
        checked: Bool = false
    ) -> Self {
        .init(type: .toDo(text, checked: checked, children: children))
    }
    static func toggle(
        _ text: [RichText],
        children: [BlockType]? = nil
    ) -> Self {
        .init(type: .toggle(text, children: children))
    }
    static func code(
        _ text: [RichText],
        language: String? = nil
    ) -> Self {
        .init(type: .code(text, language: language))
    }
    
    static func embed(
        url: String,
        caption: [RichText] = []
    ) -> Self {
        .init(type: .embed(url: url, caption: caption))
    }
    
    static func callout(
        _ text: [RichText],
        children: [BlockType]? = nil,
        icon: IconFile? = nil
    ) -> Self {
        .init(type: .callout(text, children: children, icon: icon))
    }
    
    static func quote(
        _ text: [RichText],
        children: [BlockType]? = nil
    ) -> Self {
        .init(type: .quote(text, children: children))
    }
    
    static func video(
        file: FileFile,
        caption: [RichText]
    ) -> Self {
        .init(type: .video(file: file, caption: caption))
    }
    
    static func audio(
        file: FileFile,
        caption: [RichText]
    ) -> Self {
        .init(type: .audio(file: file, caption: caption))
    }
    
    static func image(
        file: FileFile,
        caption: [RichText]
    ) -> Self {
        .init(type: .image(file: file, caption: caption))
    }
    
    static func file(
        file: FileFile,
        caption: [RichText]
    ) -> Self {
        .init(type: .file(file: file, caption: caption))
    }
    
    static func pdf(
        file: FileFile,
        caption: [RichText]
    ) -> Self {
        .init(type: .pdf(file: file, caption: caption))
    }
    
    static func bookmark(
        url: String,
        caption: [RichText]
    ) -> Self {
        .init(type: .bookmark(url: url, caption: caption))
    }
    
    static func equation(expression: String) -> Self {
        .init(type: .equation(expression: expression))
    }
    
    static func divider() -> Self {
        .init(type: .divider)
    }
    
    static func tableOfContents() -> Self {
        .init(type: .tableOfContents)
    }
    
    static func breadcrumb() -> Self {
        .init(type: .breadcrumb)
    }
    
    static func column(
        children: [BlockType]? = nil
    ) -> Self {
        .init(type: .column(.init(children: children)))
    }
    
    static func columnList(
        columns: [Column]
    ) -> Self {
        let columnBlocks: [BlockType] = columns.map {
            BlockType.column(.init(children: $0.children))
        }
        return .init(type: .columnList(.init(children: columnBlocks)))
    }
    
    static func template(
        _ text: [RichText],
        children: [BlockType]? = nil
    ) -> Self {
        .init(type: .template(text, children: children))
    }
}
