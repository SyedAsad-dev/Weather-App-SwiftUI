//
//  MockLocalDataSource.swift
//  Data
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils
import Networks

final class MockLocalDataSource: LocalDataSourceProtocol {
    var savedToday: WeatherEntity?
    var savedWeekly: WeeklyForecastEntity?
    var shouldThrow = false
    func saveTodayForecast(_ data: WeatherEntity) async throws {
        if shouldThrow { throw GenericError.invalidData("Mock error") }
        savedToday = data
    }
    func getTodayForecast() async throws -> WeatherEntity {
        if shouldThrow { throw GenericError.invalidData("Mock error") }
        return savedToday ?? .empty
    }
    func saveWeeklyForecast(_ data: WeeklyForecastEntity) async throws {
        if shouldThrow { throw GenericError.invalidData("Mock error") }
        savedWeekly = data
    }
    func getWeeklyForecast() async throws -> WeeklyForecastEntity {
        if shouldThrow { throw GenericError.invalidData("Mock error") }
        return savedWeekly ?? .empty
    }
}
