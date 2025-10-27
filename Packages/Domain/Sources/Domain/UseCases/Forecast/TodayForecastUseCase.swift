//
//  ForecastUseCase.swift
//  Domain
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import Foundation

public struct TodayForecastUseCase: TodayForecastUseCaseProtocol {
    private let repository: ForecastRepositoryProtocol
    public init(repository: ForecastRepositoryProtocol) {
        self.repository = repository
    }
    public func execute(lat: Double, lon: Double) async throws -> WeatherEntity {
        do {
            let response = try await repository.loadTodayForecast(lat: "\(lat)", lon: "\(lon)")
            return response
        } catch {
            throw error
        }
    }
}
