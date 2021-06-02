//
//  Created by Wojciech Chojnacki on 30/05/2021.
//

import Foundation

struct GenericCodingKeys: CodingKey {
    var intValue: Int?
    var stringValue: String

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}
