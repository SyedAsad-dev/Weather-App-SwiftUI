//
//  WeaklyForecastUseCase.swift
//  Domain
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

import Foundation

public struct WeeklyForecastUseCase: WeeklyForecastUseCaseProtocol {
    private let repository: ForecastRepositoryProtocol
    public init(repository: ForecastRepositoryProtocol) {
        self.repository = repository
    }
    public func execute(lat: Double, lon: Double) async throws -> WeeklyForecastEntity {
        do {
            let response = try await repository.loadWeeklyForecast(lat: "\(lat)", lon: "\(lon)")
            return response
        } catch {
            throw error
        }
    }
}
