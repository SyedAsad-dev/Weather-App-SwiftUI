//
//  ListFavoriteUseCaseProtocol.swift
//  Domain
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

public protocol ObserveFavoritesUseCaseProtocol {
    func geyAllList() async throws -> [WeatherEntity]
}
