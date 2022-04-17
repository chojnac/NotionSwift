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
    
    struct TableRow {
        let header: [RichText]?
        let cells: [[RichText]]
        
        public static func row(header: [RichText]? = nil, cells: [[RichText]]) -> Self {
            return .init(header: header, cells: cells)
        }
    }
    
    static func paragraph(
        _ text: [RichText],
        children: [BlockType]? = nil,
        color: BlockColor = .default
    ) -> Self {
        .init(type: .paragraph(text, children: children, color: color))
    }
    
    static func heading1(_ text: [RichText], color: BlockColor = .default) -> Self {
        .init(type: .heading1(text, color: color))
    }
    
    static func heading2(_ text: [RichText], color: BlockColor = .default) -> Self {
        .init(type: .heading2(text, color: color))
    }
    
    static func heading3(_ text: [RichText], color: BlockColor = .default) -> Self {
        .init(type: .heading3(text, color: color))
    }
    
    static func bulletedListItem(
        _ text: [RichText],
        children: [BlockType]? = nil,
        color: BlockColor = .default
    ) -> Self {
        .init(type: .bulletedListItem(text, children: children, color: color))
    }
    static func numberedListItem(
        _ text: [RichText],
        children: [BlockType]? = nil,
        color: BlockColor = .default
    ) -> Self {
        .init(type: .numberedListItem(text, children: children, color: color))
    }
    static func toDo(
        _ text: [RichText],
        children: [BlockType]? = nil,
        checked: Bool = false,
        color: BlockColor = .default
    ) -> Self {
        .init(type: .toDo(text, checked: checked, children: children, color: color))
    }
    static func toggle(
        _ text: [RichText],
        children: [BlockType]? = nil,
        color: BlockColor = .default
    ) -> Self {
        .init(type: .toggle(text, children: children, color: color))
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
        icon: IconFile? = nil,
        color: BlockColor = .default
    ) -> Self {
        .init(type: .callout(text, children: children, icon: icon, color: color))
    }
    
    static func quote(
        _ text: [RichText],
        children: [BlockType]? = nil,
        color: BlockColor = .default
    ) -> Self {
        .init(type: .quote(text, children: children, color: color))
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
    
    static func tableOfContents(color: BlockColor = .default) -> Self {
        .init(type: .tableOfContents(.init(color: color)))
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
    
    static func table(
        width: Int,
        headers: [[RichText]],
        rows: [TableRow]
    ) throws -> Self {
        let hasColumnHeader = !headers.isEmpty
        let hasRowHeader = rows.first(where: { $0.header != nil }) != nil
        var tableRows = rows
        if hasColumnHeader {
            if headers.count != width {
                throw NotionClientError.builderError(
                    message:  "Number of header cells must match the table width"
                )
            }
        }
        let tableWidth = hasRowHeader ? width + 1 : width
        
        // quarantee that all rows have header is needed
        if hasRowHeader {
            tableRows = rows.map {
                .init(header: $0.header ?? [""], cells: $0.cells)
            }
        }
        
        var children: [BlockType] = []
        
        if hasColumnHeader {
            children.append(.tableRow(.init(
                cells: (hasRowHeader ? [[""]] : []) + headers.map({$0})
            )))
        }
        
        for (line, row) in tableRows.enumerated() {
            if row.cells.count != width {
                throw NotionClientError.builderError(
                    message: "Number of cells in table row \(line) must match the table width"
                )
            }
            
            var cells = [[RichText]]()
            if let header = row.header {
                cells.append(header)
            }
            cells.append(contentsOf: row.cells)
            children.append(.tableRow(.init(cells: cells)))
        }
        
        return .init(type: .table(.init(
            tableWidth: tableWidth,
            hasColumnHeader: hasColumnHeader,
            hasRowHeader: hasRowHeader,
            children: children
        )))
    }
}
