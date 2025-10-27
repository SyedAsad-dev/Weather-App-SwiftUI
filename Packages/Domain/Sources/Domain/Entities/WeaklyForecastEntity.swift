//
//  WeaklyForecastEntity.swift
//  Domain
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

// Domain Layer - Entity Models

public struct WeeklyForecastEntity: Sendable, Equatable {
    public let code: String
    public let count: Int
    public let weatherList: [WeeklyForecastWeatherEntity]

    public init(code: String, count: Int, weatherList: [WeeklyForecastWeatherEntity]) {
        self.code = code
        self.count = count
        self.weatherList = weatherList
    }
    public static var empty: Self {
           .init(code: "", count: 0, weatherList: [])
       }
}

public struct WeeklyForecastWeatherEntity: Sendable, Equatable {
    public let date: Int
    public let weekday: String
    public let temp: String
    public let tempMin: String
    public let tempMax: String
    public var main: WeatherMainType

    public init(date: Int, weekday: String, temp: String, tempMin: String, tempMax: String, main: WeatherMainType) {
        self.date = date
        self.weekday = weekday
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.main = main
    }
    public static var empty: Self {
        .init(date: 0, weekday: "", temp: "--", tempMin: "--", tempMax: "--", main: .unknown)
     }
}
