//
//  FavoriteRepository.swift
//  Data
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import Domain
import Utils
import Models
import Networks

public typealias RemoteFavoriteLoaderProtocols = FavoriteRepositoryProtocol

public struct FavoriteRepository: RemoteFavoriteLoaderProtocols {
    private let localDataSource: FavoriteLocalProtocol
    private let httpClient: HTTPClientProtocol
    public init(localDataSource: FavoriteLocalProtocol, httpClient: HTTPClientProtocol) {
        self.localDataSource = localDataSource
        self.httpClient = httpClient
    }
    public func getCityForecast(query: String) async throws -> WeatherEntity {
        let networkAvailable = await NetworkMonitor.shared.currentStatus()
        do {
            if networkAvailable {
                let dto = try await httpClient.sendRequest(ApiBuilder.cityForecast(query),
                                                           model: CurrentWeatherDTO.self)
                guard let entity = dto.toEntity() else {
                    throw GenericError.mappingFailed
                }
                try await localDataSource.saveFavorite(entity)
                return entity
            } else {
                throw GenericError.internetNotAvailable
            }
        } catch {
            throw error
        }
    }

}
