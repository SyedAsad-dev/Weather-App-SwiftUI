//
//  RemoveFavoriteUseCase.swift
//  Domain
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

public struct RemoveFavoriteUseCase: RemoveFavoriteUseCaseProtocol {
    private let localDataSource: FavoriteLocalProtocol
    public init(localDataSource: FavoriteLocalProtocol) {
        self.localDataSource = localDataSource
    }
    public func execute(id: Int) async throws -> [WeatherEntity] {
        do {
            try await localDataSource.removeFavorite(id)
            return try await localDataSource.fetchAllFavorites()
        } catch {
            throw error
        }
    }
}
