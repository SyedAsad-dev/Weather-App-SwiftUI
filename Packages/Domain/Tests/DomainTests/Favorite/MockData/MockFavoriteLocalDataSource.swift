//
//  MockFavoriteLocalDataSource.swift
//  Domain
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils

final class MockFavoriteLocalDataSource: FavoriteLocalProtocol {
    var favorites: [WeatherEntity] = []
    var shouldThrow = false

    func saveFavorite(_ entity: WeatherEntity) async throws {
        if shouldThrow { throw GenericError.invalidData("save failed") }
        favorites.append(entity)
    }

    func fetchAllFavorites() async throws -> [WeatherEntity] {
        if shouldThrow { throw GenericError.invalidData("fetch failed") }
        return favorites
    }

    func removeFavorite(_ id: Int) async throws {
        if shouldThrow { throw GenericError.invalidData("remove failed") }
        favorites.removeAll { $0.id == id }
    }
}

extension WeatherEntity {
    static func mock(id: Int = 1, name: String = "TestCity") -> WeatherEntity {
        .init(
            id: id,
            name: name,
            coordinate: CoordinateEntity(lon: 10.0, lat: 20.0),
            main: .unknown,
            temp: "--", tempMin: "--", tempMax: "--"
        )
    }
}
