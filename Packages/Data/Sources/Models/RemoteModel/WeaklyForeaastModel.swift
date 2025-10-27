//
//  WeaklyForeaastModel.swift
//  Data
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

import Foundation
import Domain
import Utils

public struct WeeklyForecastResponseDTO: Codable {
    public let code: String?
    public let message: Int?
    public let count: Int?
    public let list: [ForecastDTO]?
    public let city: ForecastCityDTO?

    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case list
        case city
    }
    public init(code: String?, message: Int?, count: Int?, list: [ForecastDTO]?, city: ForecastCityDTO?) {
        self.code = code
        self.message = message
        self.count = count
        self.list = list
        self.city = city
    }
}

public struct ForecastDTO: Codable {
    public let date: Int?
    public let main: ForecastMainDTO?
    public let weather: [WeatherElementDTO]?

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
    }
}

public struct ForecastCityDTO: Codable {
    public let id: Int?
    public let name: String?
    public let coord: CoordinateDTO?
    public let country: String?
    public let timezone: Int?
    public let sunrise: Int?
    public let sunset: Int?
}

public struct ForecastMainDTO: Codable {
    public let temp: Double?
    public let feelsLike: Double?
    public let tempMin: Double?
    public let tempMax: Double?
    public let pressure: Int?
    public let seaLevel: Int?
    public let grndLevel: Int?
    public let humidity: Int?
    public let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Mapping Extensions (DTO -> Entity)

extension WeeklyForecastResponseDTO {
    private var todayDate: Date {
        Date() // current date/time
    }
    var upcoming7DaysFilteredList: [ForecastDTO] {
        guard let list = list else { return [] }
        var result: [ForecastDTO] = []
        var seenDays = Set<String>()
        for forecast in list {
            guard let timestamp = forecast.date else { continue }
            let forecastDate = timestamp.toDate()
            // Exclude today's data
            if forecastDate.isSameDay(as: todayDate) {
                continue
            }
            let dayStr = forecastDate.dayString()
            // Only add one entry per day
            if !seenDays.contains(dayStr) {
                seenDays.insert(dayStr)
                result.append(forecast)
            }
            if seenDays.count == 7 {
                break
            }
        }
        return result
    }
    public func toEntity() -> WeeklyForecastEntity {
        WeeklyForecastEntity(
            code: self.code ?? "",
            count: self.count ?? 0,
            weatherList: upcoming7DaysFilteredList.compactMap { $0.toEntity() }
        )
    }
}

extension ForecastDTO {
    func toEntity() -> WeeklyForecastWeatherEntity {
        WeeklyForecastWeatherEntity(date: date ?? 0, weekday: date?.toDate().dayWord() ?? "",
                                    temp: "\(main?.temp ?? 0)°", tempMin: "\(main?.tempMin ?? 0)°",
                                    tempMax: "\(main?.tempMax ?? 0)°",
                                    main: WeatherMainType(rawValue: weather?.first?.main ?? ""))
    }
}
