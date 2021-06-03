//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public struct RichText {
    public struct Annotations: Equatable {
        public let bold: Bool
        public let italic: Bool
        public let strikethrough: Bool
        public let underline: Bool
        public let code: Bool
        public let color: String

        public init(
            bold: Bool = false,
            italic: Bool = false,
            strikethrough: Bool = false,
            underline: Bool = false,
            code: Bool = false,
            color: String = "default"
        ) {
            self.bold = bold
            self.italic = italic
            self.strikethrough = strikethrough
            self.underline = underline
            self.code = code
            self.color = color
        }

        public static let `default` = Annotations()
        public static let bold = Annotations(bold: true)
        public static let italic = Annotations(italic: true)
        public static let strikethrough = Annotations(strikethrough: true)
        public static let underline = Annotations(underline: true)
        public static let code = Annotations(code: true)
    }

    public let plainText: String?
    public let href: String?
    public let annotations: Annotations
    public let type: RichTextType

    public init(
        plainText: String?,
        href: String? = nil,
        annotations: RichText.Annotations = .default,
        type: RichTextType
    ) {
        self.plainText = plainText
        self.href = href
        self.annotations = annotations
        self.type = type
    }

    public init(string: String, annotations: RichText.Annotations = .default) {
        self.init(
            plainText: nil,
            href: nil,
            annotations: annotations,
            type: .text(.init(content: string))
        )
    }
}

public enum RichTextType {
    case text(TextTypeValue)
    case mention(Mention)
    case equation(EquationTypeValue)
    case unknown
}

extension RichTextType {
    public struct TextTypeValue {
        public let content: String
        public let link: NotionLink?

        public init(content: String, link: NotionLink? = nil) {
            self.content = content
            self.link = link
        }
    }

    public struct EquationTypeValue {
        public let expression: String

        public init(expression: String) {
            self.expression = expression
        }
    }
}

extension RichText: Codable {
    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
        case href
        case annotations
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.plainText = try container.decode(String?.self, forKey: .plainText)
        self.href = try container.decode(String?.self, forKey: .href)
        self.annotations = try container.decode(Annotations.self, forKey: .annotations)
        self.type = try RichTextType(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(plainText, forKey: .plainText)
        try container.encodeIfPresent(href, forKey: .href)
        if annotations != .default {
            try container.encode(annotations, forKey: .annotations)
        }
        try type.encode(to: encoder)
    }
}
extension RichText.Annotations: Codable {}
extension RichTextType: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case text
        case mention
        case equation
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case CodingKeys.text.stringValue:
            let value = try container.decode(TextTypeValue.self, forKey: .text)
            self = .text(value)
        case CodingKeys.mention.stringValue:
            let value = try container.decode(Mention.self, forKey: .mention)
            self = .mention(value)
        case CodingKeys.equation.stringValue:
            let value = try container.decode(EquationTypeValue.self, forKey: .equation)
            self = .equation(value)
        default:
            self = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .text(let value):
//            try container.encode(CodingKeys.text.stringValue, forKey: .type)
            try container.encode(value, forKey: .text)
        case .mention(let value):
//            try container.encode(CodingKeys.mention.stringValue, forKey: .type)
            try container.encode(value, forKey: .mention)
        case .equation(let value):
//            try container.encode(CodingKeys.equation.stringValue, forKey: .type)
            try container.encode(value, forKey: .equation)
        case .unknown:
            break
        }
    }
}
extension RichTextType.TextTypeValue: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encodeIfPresent(link, forKey: .link)
    }
}
extension RichTextType.EquationTypeValue: Codable {}
