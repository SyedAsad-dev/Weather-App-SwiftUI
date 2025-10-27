//
//  WeeklyForecastLocalModel.swift
//  Data
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import SwiftData
import Domain

@Model
public final class WeeklyForecastLocalModel: @unchecked Sendable {
    public var code: String
    public var count: Int
    @Relationship(deleteRule: .cascade) public var weatherList: [WeeklyForecastDayLocalModel]

    public init(from entity: WeeklyForecastEntity) {
        self.code = entity.code
        self.count = entity.count
        self.weatherList = entity.weatherList.map { WeeklyForecastDayLocalModel(from: $0) }
    }

    public func toEntity() -> WeeklyForecastEntity {
        WeeklyForecastEntity(
            code: code,
            count: count,
            weatherList: weatherList.map { $0.toEntity() }
        )
    }
}

@Model
public final class WeeklyForecastDayLocalModel: @unchecked Sendable {
    public var date: Int
    public var weekday: String
    public var temp: String
    public var tempMin: String
    public var tempMax: String
    public var main: String

    public init(from entity: WeeklyForecastWeatherEntity) {
        self.date = entity.date
        self.weekday = entity.weekday
        self.temp = entity.temp
        self.tempMin = entity.tempMin
        self.tempMax = entity.tempMax
        self.main = entity.main.rawValue
    }

    public func toEntity() -> WeeklyForecastWeatherEntity {
        WeeklyForecastWeatherEntity(
            date: date,
            weekday: weekday,
            temp: temp,
            tempMin: tempMin,
            tempMax: tempMax,
            main: WeatherMainType(rawValue: main)
        )
    }
}
