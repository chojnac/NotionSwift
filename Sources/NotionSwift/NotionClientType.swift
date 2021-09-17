//
//  Created by Wojciech Chojnacki on 06/06/2021.
//

import Foundation

public protocol NotionClientType: AnyObject {

    // MARK: - block

    func blockChildren(
        blockId: Block.Identifier,
        params: BaseQueryParams,
        completed: @escaping (Result<ListResponse<ReadBlock>, NotionClientError>) -> Void
    )

    func blockAppend(
        blockId: Block.Identifier,
        children: [WriteBlock],
        completed: @escaping (Result<ListResponse<ReadBlock>, NotionClientError>) -> Void
    )

    func blockUpdate(
        blockId: Block.Identifier,
        value: UpdateBlock,
        completed: @escaping (Result<ReadBlock, NotionClientError>) -> Void
    )

    func blockDelete(
        blockId: Block.Identifier,
        completed: @escaping (Result<ReadBlock, NotionClientError>) -> Void
    )

    // MARK: - database

    func database(
        databaseId: Database.Identifier,
        completed: @escaping (Result<Database, NotionClientError>) -> Void
    )
    
    func databaseQuery(
        databaseId: Database.Identifier,
        params: DatabaseQueryParams,
        completed: @escaping (Result<ListResponse<Page>, NotionClientError>) -> Void
    )

    func databaseCreate(
        request: DatabaseCreateRequest,
        completed: @escaping (Result<Database, NotionClientError>) -> Void
    )

    // MARK: - page

    func page(
        pageId: Page.Identifier,
        completed: @escaping (Result<Page, NotionClientError>) -> Void
    )

    func pageCreate(
        request: PageCreateRequest,
        completed: @escaping (Result<Page, NotionClientError>) -> Void
    )

    func pageUpdateProperties(
        pageId: Page.Identifier,
        request: PageProperiesUpdateRequest,
        completed: @escaping (Result<Page, NotionClientError>) -> Void
    )

    // MARK: - user

    func user(
        userId: User.Identifier,
        completed: @escaping (Result<User, NotionClientError>) -> Void
    )

    func usersList(
        params: BaseQueryParams,
        completed: @escaping (Result<ListResponse<User>, NotionClientError>) -> Void
    )

    // MARK: - search
    
    func search(
        request: SearchRequest,
        completed: @escaping (Result<SearchResponse, NotionClientError>) -> Void
    )
}

// MARK: - default arguments

extension NotionClientType {

    public func blockChildren(
        blockId: Block.Identifier,
        completed: @escaping (Result<ListResponse<ReadBlock>, NotionClientError>) -> Void
    ) {
        self.blockChildren(blockId: blockId, params: .init(), completed: completed)
    }

    public func databaseQuery(
        databaseId: Database.Identifier,
        completed: @escaping (Result<ListResponse<Page>, NotionClientError>) -> Void
    ) {
        self.databaseQuery(databaseId: databaseId, params: .init(), completed: completed)
    }

    public func usersList(
        completed: @escaping (Result<ListResponse<User>, NotionClientError>) -> Void
    ) {
        self.usersList(params: .init(), completed: completed)
    }

    public func search(
        completed: @escaping (Result<SearchResponse, NotionClientError>) -> Void
    ) {
        self.search(request: .init(), completed: completed)
    }
}
