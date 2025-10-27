//
//  FavoriteRepositoryProtocol.swift
//  Domain
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

public protocol FavoriteRepositoryProtocol {
    func getCityForecast(query: String) async throws -> WeatherEntity
}
