//
//
//  Created by Wojciech Chojnacki on 23/05/2021.
//

import Foundation

public protocol BaseQueryParams: Encodable {
    var startCursor: String { get }
    var pageSize: Int32 { get }
}
