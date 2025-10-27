//
//  LoadFavoriteUseCaseProtocol.swift
//  Domain
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

public protocol LoadFavoriteUseCaseProtocol {
    func execute(query: String)  async throws -> [WeatherEntity]
}
