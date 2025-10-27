//
//  ForecastRepositoryProtocol.swift
//  Domain
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

public protocol ForecastRepositoryProtocol {
    func loadTodayForecast(lat: String, lon: String) async throws -> WeatherEntity
    func loadWeeklyForecast(lat: String, lon: String) async throws -> WeeklyForecastEntity
}
