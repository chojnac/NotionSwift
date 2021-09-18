//
//  Created by Wojciech Chojnacki on 16/09/2021.
//

import Foundation

public enum CoverFile {
    case external(url: String)
    case unknown(typeName: String)
}

extension CoverFile: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case external
    }

    private struct _ExternalFileLink: Codable {
        enum CodingKeys: String, CodingKey {
            case url
        }
        let url: String
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if type == CodingKeys.external.rawValue {
            let external = try container.decode(_ExternalFileLink.self, forKey: .external)
            self = .external(url: external.url)
        } else {
            self = .unknown(typeName: type)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .external(url):
            try container.encode(CodingKeys.external.rawValue, forKey: .type)
            try container.encode(_ExternalFileLink(url: url), forKey: .external)
        case .unknown:
            break
        }
    }
}
