//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

func encodeToJson<T: Encodable>(_ entity: T) throws -> String {
    let data = try JSONEncoder().encode(entity)
    return String(data: data, encoding: .utf8)!
}
