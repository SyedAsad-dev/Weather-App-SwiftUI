//
//  FavoriteLocalRepositoryImplement.swift
//  Data
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import Domain
import Models

public struct FavoriteLocalRepositoryImplement: FavoriteLocalProtocol {
    let favoriteDataSource: SwiftDataGenericActorDataSource<WeatherLocalModel>
    public init(
        favoriteDataSource: SwiftDataGenericActorDataSource<WeatherLocalModel>
    ) {
        self.favoriteDataSource = favoriteDataSource
    }
    public func saveFavorite(_ data: WeatherEntity) async throws {
        let model = WeatherLocalModel(from: data)
        try await favoriteDataSource.save(model)
    }
    public func removeFavorite(_ id: Int) async throws {
        try await favoriteDataSource.delete(by: id)
    }
    public func fetchAllFavorites() async throws -> [WeatherEntity] {
        let models = try await favoriteDataSource.fetchAll()
        let entities = models.map { $0.toEntity() }
        return entities
    }
}
