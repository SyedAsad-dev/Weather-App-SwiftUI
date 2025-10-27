//
//  ForecastRepository.swift
//  Data
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import Domain
import Utils
import Network
import Models
import Networks

public typealias RemoteLoaderProtocols = ForecastRepositoryProtocol

public struct ForecastRepository: RemoteLoaderProtocols {
    private let localDataSource: LocalDataSourceProtocol
    private let httpClient: HTTPClientProtocol
    public init(localDataSource: LocalDataSourceProtocol, httpClient: HTTPClientProtocol) {
        self.localDataSource = localDataSource
        self.httpClient = httpClient
    }
    public func loadTodayForecast(lat: String, lon: String) async throws -> WeatherEntity {
        let networkAvailable = await NetworkMonitor.shared.currentStatus()
        do {
            if networkAvailable {
                let dto = try await httpClient.sendRequest(ApiBuilder.todayForecast(lat, lon),
                                                           model: CurrentWeatherDTO.self)
                guard let entity = dto.toEntity() else {
                    throw GenericError.mappingFailed
                }
                try await localDataSource.saveTodayForecast(entity)
                return entity
            } else {
                do {
                    return try await localDataSource.getTodayForecast()
                } catch {
                    throw GenericError.internetNotAvailable
                }
            }
        } catch {
            do {
                return try await localDataSource.getTodayForecast()
            } catch {
                throw error
            }
        }
    }
    public func loadWeeklyForecast(lat: String, lon: String) async throws -> WeeklyForecastEntity {
        let networkAvailable = await NetworkMonitor.shared.currentStatus()
        do {
            if networkAvailable {
                let dto = try await httpClient.sendRequest(ApiBuilder.weeklyForecast(lat, lon),
                                                           model: WeeklyForecastResponseDTO.self)
                let entity = dto.toEntity()
                try await localDataSource.saveWeeklyForecast(entity)
                return entity
            } else {
                return try await localDataSource.getWeeklyForecast()
            }
        } catch {
            do {
                return try await localDataSource.getWeeklyForecast()
            } catch {
                throw error
            }
        }
    }

}
