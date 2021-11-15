//
//  Created by Wojciech Chojnacki on 15/11/2021.
//

public struct DateRange {
    public let start: DateValue
    public let end: DateValue?

    public init(start: DateValue, end: DateValue?) {
        self.start = start
        self.end = end
    }
}

extension DateRange: Codable {}
