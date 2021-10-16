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
    ) -> AnyPublisher<ListResponse<ReadBlock>, NotionClientError> {
        convertToPublisher { promise in
            self.blockChildren(blockId: blockId, params: params, completed: promise)
        }
    }

    public func blockAppend(
        blockId: Block.Identifier,
        children: [WriteBlock]
    ) -> AnyPublisher<ListResponse<ReadBlock>, NotionClientError> {
        convertToPublisher { promise in
            self.blockAppend(blockId: blockId, children: children, completed: promise)
        }
    }

    public func blockDelete(
        blockId: Block.Identifier,
        completed: @escaping (Result<ReadBlock, NotionClientError>) -> Void
    ) -> AnyPublisher<ReadBlock, NotionClientError> {
        convertToPublisher { promise in
            self.blockDelete(blockId: blockId, completed: promise)
        }
    }

    // MARK: - database

    public func database(
        databaseId: Database.Identifier
    ) -> AnyPublisher<Database, NotionClientError> {
        convertToPublisher { promise in
            self.database(databaseId: databaseId, completed: promise)
        }
    }

    public func databaseQuery(
        databaseId: Database.Identifier,
        params: DatabaseQueryParams = .init()
    ) -> AnyPublisher<ListResponse<Page>, NotionClientError> {
        convertToPublisher { promise in
            self.databaseQuery(databaseId: databaseId, params: params, completed: promise)
        }
    }

    public func databaseCreate(
        request: DatabaseCreateRequest
    ) -> AnyPublisher<Database, NotionClientError> {
        convertToPublisher { promise in
            self.databaseCreate(request: request, completed: promise)
        }
    }

    func databaseUpdate(
        databaseId: Database.Identifier,
        request: DatabaseUpdateRequest
    ) -> AnyPublisher<Database, NotionClientError> {
        convertToPublisher { promise in
            self.databaseUpdate(databaseId: databaseId, request: request, completed: promise)
        }
    }

    // MARK: - page

    public func page(
        pageId: Page.Identifier
    ) -> AnyPublisher<Page, NotionClientError> {
        convertToPublisher { promise in
            self.page(pageId: pageId, completed: promise)
        }
    }

    public func pageCreate(
        request: PageCreateRequest
    ) -> AnyPublisher<Page, NotionClientError> {
        convertToPublisher { promise in
            self.pageCreate(request: request, completed: promise)
        }
    }

    public func pageUpdateProperties(
        pageId: Page.Identifier,
        request: PageProperiesUpdateRequest
    ) -> AnyPublisher<Page, NotionClientError> {
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
    ) -> AnyPublisher<User, NotionClientError> {
        convertToPublisher { promise in
            self.user(userId: userId, completed: promise)
        }
    }

    public func usersList(
        params: BaseQueryParams = .init()
    ) -> AnyPublisher<ListResponse<User>, NotionClientError> {
        convertToPublisher { promise in
            self.usersList(params: params, completed: promise)
        }
    }

    public func usersMe() -> AnyPublisher<User, NotionClientError> {
        convertToPublisher { promise in
            self.usersMe(completed: promise)
        }
    }

    // MARK: - search

    public func search(
        request: SearchRequest
    ) -> AnyPublisher<SearchResponse, NotionClientError> {
        convertToPublisher { promise in
            self.search(request: request, completed: promise)
        }
    }
}

@available(iOS 13.0, macOS 10.15, *)
private func convertToPublisher<Output>(
    _ attemptToFulfill: @escaping (@escaping Future<Output, NotionClientError>.Promise) -> Void
) -> AnyPublisher<Output, NotionClientError> {
    return Deferred { Future(attemptToFulfill) }.eraseToAnyPublisher()
}

#endif
