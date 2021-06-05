//
//  File.swift
//  
//
//  Created by Wojciech Chojnacki on 06/06/2021.
//

import Foundation

#if canImport(Combine)
import Combine

@available(iOS 13.0, macOS 10.15, *)
extension NotionClientType {

    // MARK: - block

    public func blockChildren(
        blockId: Block.Identifier,
        params: BaseQueryParams = .init()
    ) -> AnyPublisher<ListResponse<ReadBlock>, Network.Errors> {
        convertToPublisher { promise in
            self.blockChildren(blockId: blockId, params: params, completed: promise)
        }
    }

    public func blockAppend(
        blockId: Block.Identifier,
        children: [WriteBlock]
    ) -> AnyPublisher<ReadBlock, Network.Errors> {
        convertToPublisher { promise in
            self.blockAppend(blockId: blockId, children: children, completed: promise)
        }
    }

    // MARK: - database

    public func database(
        databaseId: Database.Identifier,
        completed: @escaping (Result<Database, Network.Errors>) -> Void
    ) -> AnyPublisher<Database, Network.Errors> {
        convertToPublisher { promise in
            self.database(databaseId: databaseId, completed: promise)
        }
    }

    public func databaseQuery(
        databaseId: Database.Identifier,
        params: DatabaseQueryParams = .init()
    ) -> AnyPublisher<ListResponse<Page>, Network.Errors> {
        convertToPublisher { promise in
            self.databaseQuery(databaseId: databaseId, params: params, completed: promise)
        }
    }

    public func databaseList(
        params: BaseQueryParams = .init()
    ) -> AnyPublisher<ListResponse<Database>, Network.Errors> {
        convertToPublisher { promise in
            self.databaseList(params: params, completed: promise)
        }
    }

    // MARK: - page

    public func page(
        pageId: Page.Identifier
    ) -> AnyPublisher<Page, Network.Errors> {
        convertToPublisher { promise in
            self.page(pageId: pageId, completed: promise)
        }
    }

    public func pageCreate(
        request: PageCreateRequest
    ) -> AnyPublisher<Page, Network.Errors> {
        convertToPublisher { promise in
            self.pageCreate(request: request, completed: promise)
        }
    }

    public func pageUpdateProperties(
        pageId: Page.Identifier,
        request: PageProperiesUpdateRequest
    ) -> AnyPublisher<Page, Network.Errors> {
        convertToPublisher { promise in
            self.pageUpdateProperties(
                pageId: pageId,
                request: request,
                completed: promise
            )
        }
    }

    // MARK: - user
    
    public func user(
        userId: User.Identifier
    ) -> AnyPublisher<User, Network.Errors> {
        convertToPublisher { promise in
            self.user(userId: userId, completed: promise)
        }
    }

    public func usersList(
        params: BaseQueryParams = .init()
    ) -> AnyPublisher<ListResponse<User>, Network.Errors> {
        convertToPublisher { promise in
            self.usersList(params: params, completed: promise)
        }
    }

    // MARK: - search

    public func search(
        request: SearchRequest
    ) -> AnyPublisher<SearchResponse, Network.Errors> {
        convertToPublisher { promise in
            self.search(request: request, completed: promise)
        }
    }
}

@available(iOS 13.0, macOS 10.15, *)
private func convertToPublisher<Output>(
    _ attemptToFulfill: @escaping (@escaping Future<Output, Network.Errors>.Promise) -> Void
) -> AnyPublisher<Output, Network.Errors> {
    return Deferred { Future(attemptToFulfill) }.eraseToAnyPublisher()
}

#endif
