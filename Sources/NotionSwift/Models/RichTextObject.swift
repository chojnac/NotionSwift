//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public struct RichText {
    public struct Annotations {
        let bold: Bool
        let italic: Bool
        let strikethrough: Bool
        let underline: Bool
        let code: Bool
        let color: String
    }

    public enum TextType: String {
        case text
        case mention
        case equation
    }

    let plain_text: String
    let href: String?
    let annotations: Annotations
    let type: TextType
}

extension RichText: Decodable {}

extension RichText.Annotations: Decodable {}
extension RichText.TextType: Decodable {}
