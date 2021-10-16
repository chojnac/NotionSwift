//
//  Created by Wojciech Chojnacki on 16/10/2021.
//

import Foundation

public enum FileFile {
    case external(url: String)
    case file(url: String, expiryTime: Date)
    case unknown(typeName: String)
}

extension FileFile: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case external
        case file
    }

    private struct _ExternalFileLink: Codable {
        let url: String
    }

    private struct _FileLink: Codable {
        let url: String
        // swiftlint:disable:next identifier_name
        let expiry_time: Date
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if type == CodingKeys.external.rawValue {
            let value = try container.decode(_ExternalFileLink.self, forKey: .external)
            self = .external(url: value.url)
        } else if type == CodingKeys.file.rawValue {
            let value = try container.decode(_FileLink.self, forKey: .file)
            self = .file(url: value.url, expiryTime: value.expiry_time)
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
        case let .file(url, expiryTime):
            try container.encode(CodingKeys.file.rawValue, forKey: .type)
            try container.encode(_FileLink(url: url, expiry_time: expiryTime), forKey: .file)
        case .unknown:
            break
        }
    }
}
