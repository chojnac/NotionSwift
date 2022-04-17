//
//  Created by Wojciech Chojnacki on 16/09/2021.
//

import Foundation

public enum NotionClientError: Error {
    case genericError(Error)
    case apiError(status: Int, code: String, message: String)
    case bodyEncodingError(Error)
    case decodingError(Error)
    case unsupportedResponseError
    case builderError(message: String)
}

public enum NotionErrorCode: String {
    case invalidJson = "invalid_json"
    case invalidRequestURL = "invalid_request_url"
    case invalidRequest = "invalid_request"
    case validationError = "validation_error"
    case missingVersion = "missing_version"
    case unauthorized = "unauthorized"
    case restrictedResource = "restricted_resource"
    case objectNotFound = "object_not_found"
    case conflictError = "conflict_error"
    case rateLimited = "rate_limited"
    case internalServerError = "internal_server_error"
    case serviceUnavailable = "service_unavailable"
    case databaseConnectionUnavailable = "database_connection_unavailable"
}
