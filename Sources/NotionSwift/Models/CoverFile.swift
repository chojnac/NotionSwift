//
//  CoverFile.swift
//  NotionSwift
//
//  Created by Wojciech Chojnacki on 16/09/2021.
//

import Foundation

public enum CoverFile {
    case external(url: String, expiryTime: Date?)
    case unknown(typeName: String)
}

extension CoverFile: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case external
    }

    private struct External: Decodable {
        enum CodingKeys: String, CodingKey {
            case url
            case expiryTime = "expiry_time"
        }
        let url: String
        let expiryTime: Date?
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if type == "external" {
            let external = try container.decode(External.self, forKey: .external)
            self = .external(url: external.url, expiryTime: external.expiryTime)
        } else {
            self = .unknown(typeName: type)
        }
    }
}
