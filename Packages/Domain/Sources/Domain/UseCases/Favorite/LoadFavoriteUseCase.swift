//
//  LoadFavoriteUseCase.swift
//  Domain
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import Foundation

public struct LoadFavoriteUseCase: LoadFavoriteUseCaseProtocol {
    private let repository: FavoriteRepositoryProtocol
    private let localDataSource: FavoriteLocalProtocol
    public init(repository: FavoriteRepositoryProtocol, localDataSource: FavoriteLocalProtocol) {
        self.repository = repository
        self.localDataSource = localDataSource
    }
    public func execute(query: String)  async throws -> [WeatherEntity] {
        do {
           _ = try await repository.getCityForecast(query: query)
            return try await localDataSource.fetchAllFavorites()
        } catch {
            throw error
        }
    }
}
