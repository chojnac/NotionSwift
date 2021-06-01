//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation

public class Block {
    public typealias Identifier = EntityIdentifier<Block, UUIDv4>

}

/// Block object read from server
public final class ReadBlock: Block {
    public let id: Identifier
}

/// Block object used in adding new content
public final class WriteBlock: Block {

}

extension ReadBlock: Decodable {}

extension WriteBlock: Encodable {}
