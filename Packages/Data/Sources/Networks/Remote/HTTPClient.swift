//
//  HTTPClient.swift
//  Data
//
//  Created by Rizvi Naqvi on 18/10/2025.
//

import Foundation
import Utils

struct ErrorResponse: Decodable, Error {
    let cod: String
    let message: String
}

public protocol HTTPClientProtocol {
    func sendRequest<T: EndPointType, P: Codable>(_ requestBuilder: T, model: P.Type) async throws -> P
}

public struct HTTPClient: HTTPClientProtocol {
    public init() {}
    public func sendRequest<T: EndPointType, P: Codable>(_ requestBuilder: T, model: P.Type) async throws -> P {
        let router = Router<T>()
        do {
            let(data, response) = try await router.request(requestBuilder)
            do {
                return try self.handleNetworkResponse(response, data, model: P.self)
            } catch {
                throw error
            }
        } catch {
            throw error
        }
    }
    fileprivate func handleNetworkResponse<T: Codable>(_ response: URLResponse,
                                                       _ data: Data, model: T.Type) throws -> T {
        guard let response = response as? HTTPURLResponse else {throw GenericError.badRequest}
        let statusCode = response.statusCode
        switch statusCode {
        case 200...299:
            return try map(data, model: T.self)
        case 401...500:
            let apiError = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw GenericError.invalidData(apiError.message)
        case 501...599:
            throw GenericError.badRequest
        case 600:
            throw GenericError.outdated
        default:
            throw GenericError.failed
        }
    }
    private func map<T: Codable>(_ data: Data, model: T.Type) throws -> T {
        do {
            _ = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let obj: T = try JSONDecoder().decode(T.self, from: data)
            return obj
        } catch let error as NetworkError {
            throw GenericError.invalidData(error.errorDescription ?? "")
        } catch {
            throw GenericError.somethingWentWrong
        }
    }
}
