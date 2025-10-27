//
//  FavoriteLocalProtocol.swift
//  Data
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

public protocol FavoriteLocalProtocol {
    func saveFavorite(_ data: WeatherEntity) async throws
    func removeFavorite(_ id: Int) async throws
    func fetchAllFavorites() async throws -> [WeatherEntity]
}
