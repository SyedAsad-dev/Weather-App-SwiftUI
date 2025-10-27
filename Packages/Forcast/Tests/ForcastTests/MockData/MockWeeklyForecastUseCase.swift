//
//  MockWeeklyForecastUseCase.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils
import Foundation

final class MockWeeklyForecastUseCase: WeeklyForecastUseCaseProtocol {
    var shouldThrow = false
    var result: WeeklyForecastEntity = .init(code: "", count: 0, weatherList: [])
    
    func execute(lat: Double, lon: Double) async throws -> WeeklyForecastEntity {
        if shouldThrow {
            throw GenericError.invalidData("Failed to load weekly forecast")
        }
        return result
    }
}
