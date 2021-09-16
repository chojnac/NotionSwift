//
//  Created by Wojciech Chojnacki on 06/06/2021.
//

import Foundation

public protocol NotionClientType: AnyObject {

    // MARK: - block

    func blockChildren(
        blockId: Block.Identifier,
        params: BaseQueryParams,
        completed: @escaping (Result<ListResponse<ReadBlock>, Network.Errors>) -> Void
    )

    func blockAppend(
        blockId: Block.Identifier,
        children: [WriteBlock],
        completed: @escaping (Result<ListResponse<ReadBlock>, Network.Errors>) -> Void
    )

    // MARK: - database

    func database(
        databaseId: Database.Identifier,
        completed: @escaping (Result<Database, Network.Errors>) -> Void
    )
    
    func databaseQuery(
        databaseId: Database.Identifier,
        params: DatabaseQueryParams,
        completed: @escaping (Result<ListResponse<Page>, Network.Errors>) -> Void
    )

    func databaseList(
        params: BaseQueryParams,
        completed: @escaping (Result<ListResponse<Database>, Network.Errors>) -> Void
    )

    // MARK: - page

    func page(
        pageId: Page.Identifier,
        completed: @escaping (Result<Page, Network.Errors>) -> Void
    )

    func pageCreate(
        request: PageCreateRequest,
        completed: @escaping (Result<Page, Network.Errors>) -> Void
    )

    func pageUpdateProperties(
        pageId: Page.Identifier,
        request: PageProperiesUpdateRequest,
        completed: @escaping (Result<Page, Network.Errors>) -> Void
    )

    // MARK: - user

    func user(
        userId: User.Identifier,
        completed: @escaping (Result<User, Network.Errors>) -> Void
    )

    func usersList(
        params: BaseQueryParams,
        completed: @escaping (Result<ListResponse<User>, Network.Errors>) -> Void
    )

    // MARK: - search
    
    func search(
        request: SearchRequest,
        completed: @escaping (Result<SearchResponse, Network.Errors>) -> Void
    )
}

// MARK: - default arguments

extension NotionClientType {

    public func blockChildren(
        blockId: Block.Identifier,
        completed: @escaping (Result<ListResponse<ReadBlock>, Network.Errors>) -> Void
    ) {
        self.blockChildren(blockId: blockId, params: .init(), completed: completed)
    }

    public func databaseQuery(
        databaseId: Database.Identifier,
        completed: @escaping (Result<ListResponse<Page>, Network.Errors>) -> Void
    ) {
        self.databaseQuery(databaseId: databaseId, params: .init(), completed: completed)
    }

    public func databaseList(
        completed: @escaping (Result<ListResponse<Database>, Network.Errors>) -> Void
    ) {
        self.databaseList(params: .init(), completed: completed)
    }

    public func usersList(
        completed: @escaping (Result<ListResponse<User>, Network.Errors>) -> Void
    ) {
        self.usersList(params: .init(), completed: completed)
    }

    public func search(
        completed: @escaping (Result<SearchResponse, Network.Errors>) -> Void
    ) {
        self.search(request: .init(), completed: completed)
    }
}
