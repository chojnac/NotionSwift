//
//  Created by Wojciech Chojnacki on 22/05/2021.
//

import Foundation
import os

public enum Network {
    public typealias HTTPHeaders = [String: String]

    public static let notionBaseURL = URL(string: "https://api.notion.com/")!

    public enum HTTPMethod: String {
        case GET, POST, PUT, PATCH
    }

    public enum Errors: Error {
        case unauthorized
        case HTTPError(code: Int)
        case bodyEncodingError(Error)
        case decodingError(Error)
        case genericError(Error)
        case unsupportedResponseError
        case requestLimitExceeded
    }
}

public protocol NetworkClient: AnyObject {
    func get<R: Decodable>(
        _ url: URL,
        headers: Network.HTTPHeaders,
        completed: @escaping (Result<R, Network.Errors>) -> Void
    )

    func post<T: Encodable, R: Decodable>(
        _ url: URL,
        body: T,
        headers: Network.HTTPHeaders,
        completed: @escaping (Result<R, Network.Errors>) -> Void
    )

    func patch<T: Encodable, R: Decodable>(
        _ url: URL,
        body: T,
        headers: Network.HTTPHeaders,
        completed: @escaping (Result<R, Network.Errors>) -> Void
    )
}

public class DefaultNetworkClient: NetworkClient {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init() {
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)

        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
    }

    public func get<R: Decodable>(_ url: URL, headers: Network.HTTPHeaders, completed: @escaping (Result<R, Network.Errors>) -> Void) {
        let request = buildRequest(method: .GET, url: url, headers: headers)
        executeRequest(request: request, completed: completed)
    }

    public func post<T: Encodable, R: Decodable>(_ url: URL, body: T, headers: Network.HTTPHeaders, completed: @escaping (Result<R, Network.Errors>) -> Void) {
        var request = buildRequest(method: .POST, url: url, headers: headers)
        let requestBody: Data

        do {
            requestBody = try encoder.encode(body)
        } catch {
            completed(.failure(.bodyEncodingError(error)))
            return
        }

        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        executeRequest(request: request, completed: completed)
    }

    public func patch<T: Encodable, R: Decodable>(_ url: URL, body: T, headers: Network.HTTPHeaders, completed: @escaping (Result<R, Network.Errors>) -> Void) {
        var request = buildRequest(method: .PATCH, url: url, headers: headers)
        let requestBody: Data

        do {
            requestBody = try encoder.encode(body)
        } catch {
            completed(.failure(.bodyEncodingError(error)))
            return
        }

        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        executeRequest(request: request, completed: completed)
    }

    private func buildRequest(
        method: Network.HTTPMethod,
        url: URL,
        headers: Network.HTTPHeaders
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        for item in headers {
            request.setValue(item.value, forHTTPHeaderField: item.key)
        }

        return request
    }

    private func executeRequest<T: Decodable>(
        request: URLRequest,
        completed: @escaping (Result<T, Network.Errors>) -> Void
    ) {
        #if DEBUG
        print("Request: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        #endif
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            var completeResult: Result<T, Network.Errors>?

            if let error = error {
                completeResult = .failure(Network.Errors.genericError(error))
            } else if let data = data {
                // this is a basic implementation supporting only positive path
                // TODO: Implement support for handling errors and non 200 response codes
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 401 {
                        completeResult = .failure(.unauthorized)
                    } else if response.statusCode == 429 {
                        completeResult = .failure(.requestLimitExceeded)
                    } else if response.statusCode != 200, response.statusCode != 220  {
                        completeResult = .failure(.HTTPError(code: response.statusCode))
                    }
                }

                if completeResult == nil {
                    do {
                        #if DEBUG
                        print(String(data: data, encoding: .utf8) ?? "")
                        #endif
                        let result = try self.decoder.decode(T.self, from: data)
                        completeResult = .success(result)
                    } catch let decodingError as Swift.DecodingError {
                        completeResult = .failure(.decodingError(decodingError))
                    } catch {
                        completeResult = .failure(.genericError(error))
                    }
                }
            } else {
                completeResult = .failure(.unsupportedResponseError)
            }

            DispatchQueue.main.async {
                guard let completeResult = completeResult else {
                    fatalError("Something is wrong, no result!")
                }
                completed(completeResult)
            }
        }
        task.resume()
    }
}
