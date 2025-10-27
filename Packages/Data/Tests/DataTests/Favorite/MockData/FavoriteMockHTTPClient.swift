//
//  MockHTTPClient.swift
//  Data
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils
import Networks

final class FavoriteMockHTTPClient: HTTPClientProtocol {
    var shouldThrow = false
    var mockResponse: Codable?
    func sendRequest<T, P>(_ requestBuilder: T, model: P.Type)
    async throws -> P where T: EndPointType, P: Decodable, P: Encodable {
        if shouldThrow {
            throw GenericError.invalidData("Mock error")
        }
        guard let mockResponse = mockResponse as? P else {
            throw GenericError.mappingFailed
        }
        return mockResponse
    }
}
