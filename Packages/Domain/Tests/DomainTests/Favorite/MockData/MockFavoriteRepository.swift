//
//  MockFavoriteRepository.swift
//  Domain
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils

final class MockFavoriteRepository: FavoriteRepositoryProtocol {
    var shouldThrow = false
    var lastQuery: String?
    var result: WeatherEntity?

    func getCityForecast(query: String) async throws -> WeatherEntity {
        lastQuery = query
        if shouldThrow {
            throw GenericError.invalidData("network failed")
        }
        return result ?? .mock() // assume WeatherEntity.mock() exists
    }
}
