//
//  MockRemoveFavoriteUseCase.swift
//  Favorite
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils

final class MockRemoveFavoriteUseCase: RemoveFavoriteUseCaseProtocol {
    var shouldThrow = false
    var favoriteData: [WeatherEntity] = [WeatherEntity.mock()]
    
    func execute(id: Int) async throws -> [WeatherEntity] {
        if shouldThrow {
            throw GenericError.somethingWentWrong
        }
        return favoriteData
    }
}
