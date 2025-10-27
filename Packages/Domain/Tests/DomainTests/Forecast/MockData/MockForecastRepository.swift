//
//  MockForecastRepository.swift
//  Domain
//
//  Created by Rizvi Naqvi on 22/10/2025.
//
import Domain
import Utils

final class MockForecastRepository: ForecastRepositoryProtocol {
    var shouldThrow = false

    func loadTodayForecast(lat: String, lon: String) async throws -> WeatherEntity {
        if shouldThrow { throw GenericError.invalidData("Mock error") }
        return WeatherEntity(
            id: 0,
            name: "Paris",
            coordinate: .empty,
            main: .unknown,
            temp: "--", tempMin: "--", tempMax: "--"
        )
    }

    func loadWeeklyForecast(lat: String, lon: String) async throws -> WeeklyForecastEntity {
        if shouldThrow { throw GenericError.invalidData("Mock error") }
        return WeeklyForecastEntity(code: "", count: 0, weatherList: [])
    }
}
