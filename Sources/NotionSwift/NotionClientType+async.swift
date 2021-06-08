//
//  NotionClientType+async.swift
//  NotionSwift
//
//  Created by Wojciech Chojnacki on 08/06/2021.
//

import Foundation

@available(iOS 15, macOS 12.0, *)
extension NotionClientType {
    // MARK: - block

    public func blockChildren(
        blockId: Block.Identifier,
        params: BaseQueryParams = .init()
    ) async throws ->  ListResponse<ReadBlock> {
        try await withCheckedThrowingContinuation { continuation in
            self.blockChildren(blockId: blockId, params: params) {
                continuation.resume(with: $0)
            }
        }
    }

    public func blockAppend(
        blockId: Block.Identifier,
        children: [WriteBlock]
    ) async throws -> ReadBlock {
        try await withCheckedThrowingContinuation { continuation in
            self.blockAppend(blockId: blockId, children: children) {
                continuation.resume(with: $0)
            }
        }
    }

    // MARK: - database

    public func database(
        databaseId: Database.Identifier
    ) async throws -> Database {
        try await withCheckedThrowingContinuation { continuation in
            self.database(databaseId: databaseId) {
                continuation.resume(with: $0)
            }
        }
    }

    public func databaseQuery(
        databaseId: Database.Identifier,
        params: DatabaseQueryParams = .init()
    ) async throws -> ListResponse<Page> {
        try await withCheckedThrowingContinuation { continuation in
            self.databaseQuery(databaseId: databaseId, params: params) {
                continuation.resume(with: $0)
            }
        }
    }

    public func databaseList(
        params: BaseQueryParams = .init()
    ) async throws -> ListResponse<Database> {
        try await withCheckedThrowingContinuation { continuation in
            self.databaseList(params: params) {
                continuation.resume(with: $0)
            }
        }
    }

    // MARK: - page

    public func page(
        pageId: Page.Identifier
    ) async throws -> Page {
        try await withCheckedThrowingContinuation { continuation in
            self.page(pageId: pageId) {
                continuation.resume(with: $0)
            }
        }
    }

    public func pageCreate(
        request: PageCreateRequest
    ) async throws -> Page {
        try await withCheckedThrowingContinuation { continuation in
            self.pageCreate(request: request) {
                continuation.resume(with: $0)
            }
        }
    }

    public func pageUpdateProperties(
        pageId: Page.Identifier,
        request: PageProperiesUpdateRequest
    ) async throws -> Page {
        try await withCheckedThrowingContinuation { continuation in
            self.pageUpdateProperties(
                pageId: pageId,
                request: request
            ) {
                continuation.resume(with: $0)
            }
        }
    }

    // MARK: - user

    public func user(
        userId: User.Identifier
    ) async throws -> User {
        try await withCheckedThrowingContinuation { continuation in
            self.user(userId: userId) {
                continuation.resume(with: $0)
            }
        }
    }

    public func usersList(
        params: BaseQueryParams = .init()
    ) async throws -> ListResponse<User> {
        try await withCheckedThrowingContinuation { continuation in
            self.usersList(params: params) {
                continuation.resume(with: $0)
            }
        }
    }
}
