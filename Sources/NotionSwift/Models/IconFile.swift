//
//  Created by Wojciech Chojnacki on 16/09/2021.
//

import Foundation

public enum IconFile {
    case external(url: String)
    case file(url: String, expiryTime: Date)
    case emoji(String)
    case unknown(typeName: String)
}

extension IconFile: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case url
        case expiryTime = "expiry_time"
        case emoji
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if type == "external" {
            let url = try container.decode(String.self, forKey: .url)
            self = .external(url: url)
        } else if type == "file" {
            let url = try container.decode(String.self, forKey: .url)
            let expiryTime = try container.decode(Date.self, forKey: .expiryTime)
            self = .file(url: url, expiryTime: expiryTime)
        } else if type == "emoji" {
            let emoji = try container.decode(String.self, forKey: .emoji)
            self = .emoji(emoji)
        } else {
            self = .unknown(typeName: type)
        }
    }
}
