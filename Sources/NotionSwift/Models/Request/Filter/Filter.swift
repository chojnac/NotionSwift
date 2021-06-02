//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public struct Filter {
    let array: [FilterType]

    public static func property(name: String, type: DatabasePropertyFilter.PropertyType) -> Filter {
        Filter(array: [.databaseProperty(.init(property: name, filterType: type))])
    }

    public static func or(_ filters: [Filter]) -> Filter {
        let flatFilters: [FilterType] = filters.map(\.array).flatMap({ $0 })
        let array: [FilterType] = [
            .compound(.or(flatFilters))
        ]

        return .init(array: array)
    }

    public static func and(_ filters: [Filter]) -> Filter {
        let flatFilters: [FilterType] = filters.map(\.array).flatMap({ $0 })
        let array: [FilterType] = [
            .compound(.and(flatFilters))
        ]

        return .init(array: array)
    }
}

// MARK: - Codable

extension Filter: Encodable {
    public func encode(to encoder: Encoder) throws {
        try array.encode(to: encoder)
    }
}
