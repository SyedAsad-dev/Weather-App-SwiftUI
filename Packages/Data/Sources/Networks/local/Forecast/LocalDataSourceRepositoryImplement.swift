//
//  DataSourceRepositoryImplement.swift
//  Data
//
//  Created by Rizvi Naqvi on 21/10/2025.
//
import Domain
import Models

public struct LocalDataSourceRepositoryImplement: LocalDataSourceProtocol {

    let weeklyDataSource: SwiftDataGenericActorDataSource<WeeklyForecastLocalModel>
    let todayDataSource: SwiftDataGenericActorDataSource<WeatherLocalModel>
    public init(
            weeklyDataSource: SwiftDataGenericActorDataSource<WeeklyForecastLocalModel>,
            todayDataSource: SwiftDataGenericActorDataSource<WeatherLocalModel>
        ) {
            self.weeklyDataSource = weeklyDataSource
            self.todayDataSource = todayDataSource
        }
    // MARK: - Today Forecast
       public func saveTodayForecast(_ data: WeatherEntity) async throws {
           try await todayDataSource.delete(by: data.id)
           let model = WeatherLocalModel(from: data)
           try await todayDataSource.save(model)
       }

       public func getTodayForecast() async throws -> WeatherEntity {
           let results = try await todayDataSource.fetchAll()
           guard let first = results.first else { return .empty }
           return first.toEntity()
       }

       // MARK: - Weekly Forecast
       public func saveWeeklyForecast(_ data: WeeklyForecastEntity) async throws {
           try await weeklyDataSource.deleteAll()          // clear old data
           let model = WeeklyForecastLocalModel(from: data)
           try await weeklyDataSource.save(model)          // save new data
       }

       public func getWeeklyForecast() async throws -> WeeklyForecastEntity {
           let results = try await weeklyDataSource.fetchAll()
           guard let first = results.first else { return .empty }
           return first.toEntity()
       }
}
