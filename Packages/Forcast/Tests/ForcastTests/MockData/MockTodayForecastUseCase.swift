//
//  MockTodayForecastUseCase.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils
import Foundation

final class MockTodayForecastUseCase: TodayForecastUseCaseProtocol {
    var shouldThrow = false
    var result: WeatherEntity = .init(
        id: 0,
        name: "London",
        coordinate: .empty,
        main: .unknown,
        temp: "--", tempMin: "--", tempMax: "--"
    )
    
    func execute(lat: Double, lon: Double) async throws -> WeatherEntity {
        if shouldThrow {
            throw GenericError.invalidData("Failed to load today's forecast")
        }
        return result
    }
}
