//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

public protocol AccessKeyProvider {
    var accessKey: String? { get }
}

public struct StringAccessKeyProvider: AccessKeyProvider, ExpressibleByStringLiteral {

    public let accessKey: String?

    public init(accessKey: String) {
        self.accessKey = accessKey
    }

    public init(stringLiteral value: String) {
        self.init(accessKey: value)
    }
}
