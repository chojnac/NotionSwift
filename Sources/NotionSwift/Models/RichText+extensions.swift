//
//  Created by Wojciech Chojnacki on 21/03/2022.
//

import Foundation

extension RichText: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .init(string: value)
    }
}
