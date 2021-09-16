//
//  Created by Wojciech Chojnacki on 16/09/2021.
//

import Foundation

public enum CoverFile {
    case external(url: String)
    case unknown(typeName: String)
}

extension CoverFile: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case external
    }

    private struct _ExternalFileLink: Decodable {
        enum CodingKeys: String, CodingKey {
            case url
        }
        let url: String
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if type == "external" {
            let external = try container.decode(_ExternalFileLink.self, forKey: .external)
            self = .external(url: external.url)
        } else {
            self = .unknown(typeName: type)
        }
    }
}
