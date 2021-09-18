//
//  Created by Wojciech Chojnacki on 16/09/2021.
//

import Foundation

public enum NetworkClientHelpers {
    public static func extractError(data: Data?, response: URLResponse?, error: Error?) -> NotionClientError? {
        if let error = error {
            return .genericError(error)
        }

        return extractError(data: data, response: response)
    }

    public static func extractError(data: Data?, response: URLResponse?) -> NotionClientError? {
        guard let response = response as? HTTPURLResponse else {
            return .unsupportedResponseError
        }

        if (400..<503).contains(response.statusCode) {
            if let data = data {
                if let err = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    return .apiError(status: err.status, code: err.code, message: err.message)
                } else {
                    return .genericError(Network.Errors.HTTPError(code: response.statusCode))
                }
            } else {
                return .genericError(Network.Errors.HTTPError(code: response.statusCode))
            }
        }

        return nil
    }
}
