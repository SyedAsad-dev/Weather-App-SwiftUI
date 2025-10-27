//
//  ListFavoritesUseCase.swift
//  Domain
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

public struct ObserveFavoritesUseCase: ObserveFavoritesUseCaseProtocol {
    private let localDataSource: FavoriteLocalProtocol
    public init(localDataSource: FavoriteLocalProtocol) {
        self.localDataSource = localDataSource
    }
    public func geyAllList() async throws -> [WeatherEntity] {
        return try await localDataSource.fetchAllFavorites()
    }
}
