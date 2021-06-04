//
//  Created by Wojciech Chojnacki on 04/06/2021.
//

import Foundation

public final class DatabaseQueryParams: BaseQueryParams {
    public let filter: DatabaseFilter?
    public let sorts: [DatabaseSort]?

    enum CodingKeys: String, CodingKey {
        case filter
        case sorts
        case startCursor = "start_cursor"
        case pageSize = "page_size"
    }

    public init(filter: DatabaseFilter? = nil, sorts: [DatabaseSort]? = nil, startCursor: String? = nil, pageSize: Int32? = nil) {
        self.filter = filter
        self.sorts = sorts
        super.init(startCursor: startCursor, pageSize: pageSize)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filter, forKey: .filter)
        try container.encode(sorts, forKey: .sorts)
    }
}
