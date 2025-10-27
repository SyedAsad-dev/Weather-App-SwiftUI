//
//  LocalDataSourceProtocol.swift
//  Data
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import Domain

public protocol LocalDataSourceProtocol {
    func saveTodayForecast(_ data: WeatherEntity) async throws
    func saveWeeklyForecast(_ data: WeeklyForecastEntity) async throws
    func getTodayForecast() async throws -> WeatherEntity
    func getWeeklyForecast() async throws -> WeeklyForecastEntity
}
