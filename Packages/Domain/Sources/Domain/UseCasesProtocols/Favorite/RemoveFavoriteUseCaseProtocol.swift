//
//  RemoveFavoriteUseCaseProtocol.swift
//  Domain
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

public protocol RemoveFavoriteUseCaseProtocol {
    func execute(id: Int)  async throws -> [WeatherEntity]
}
