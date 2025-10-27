//
//  MockLoadFavoriteUseCase.swift
//  Favorite
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils

final class MockLoadFavoriteUseCase: LoadFavoriteUseCaseProtocol {
    var shouldThrow = false
    var favoriteData: [WeatherEntity] = [WeatherEntity.mock()]
    
    func execute(query: String) async throws -> [WeatherEntity] {
        if shouldThrow {
            throw GenericError.somethingWentWrong
        }
        return favoriteData
    }
}

// MARK: - Mock Data
extension WeatherEntity {
    static func mock() -> WeatherEntity {
        return WeatherEntity(
            id: 1,
            name: "London",
            coordinate: CoordinateEntity(lon: 51.5074, lat: -0.1278),
            main: .clear,
            temp: "--", tempMin: "--", tempMax: "--"
        )
    }
}
