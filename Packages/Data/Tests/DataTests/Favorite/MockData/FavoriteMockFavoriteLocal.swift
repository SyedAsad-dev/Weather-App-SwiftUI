//
//  FavoriteMockFavoriteLocal.swift
//  Data
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils

final class FavoriteMockFavoriteLocal: FavoriteLocalProtocol {
    var saved: [WeatherEntity] = []
    var shouldThrow = false
    func saveFavorite(_ data: WeatherEntity) async throws {
        if shouldThrow { throw GenericError.failed }
        saved.append(data)
    }
    func removeFavorite(_ id: Int) async throws {
        if shouldThrow { throw GenericError.failed }
        saved.removeAll { $0.id == id }
    }
    func fetchAllFavorites() async throws -> [WeatherEntity] {
        if shouldThrow { throw GenericError.failed }
        return saved
    }
}
