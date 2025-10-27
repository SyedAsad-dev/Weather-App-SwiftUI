//
//  CurrentWeatherModel.swift
//  Data
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

import Foundation
import Domain

public struct CurrentWeatherDTO: Codable {
    var timezone, id: Int?
    var name: String?
    var coordinate: CoordinateDTO?
    var elements: [WeatherElementDTO]?
    var base: String?
    var mainValue: WeatherMainValueDTO?
    var visibility: Int?
    var date: Int?
    var code: Int?
    enum CodingKeys: String, CodingKey {
        case base, visibility, timezone, id, name, date
        case elements = "weather"
        case coordinate = "coord"
        case mainValue = "main"
    }
    public init(timezone: Int? = nil, id: Int? = nil, name: String? = nil,
                coordinate: CoordinateDTO? = nil, elements: [WeatherElementDTO]? = nil,
                base: String? = nil, mainValue: WeatherMainValueDTO? = nil,
                visibility: Int? = nil, date: Int? = nil, code: Int? = nil) {
        self.timezone = timezone
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.elements = elements
        self.base = base
        self.mainValue = mainValue
        self.visibility = visibility
        self.date = date
        self.code = code
    }

}

public struct CoordinateDTO: Codable {
    var lon, lat: Double?
}

public struct WeatherElementDTO: Codable {
    var id: Int?
    var main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

public struct WeatherMainValueDTO: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// Data Layer
extension CurrentWeatherDTO {
   public func toEntity() -> WeatherEntity? {
       let coord = coordinate?.toEntity()
       let weather = elements?.first ?? nil
       let main = mainValue ?? nil

       return WeatherEntity(id: id ?? 0, name: name ?? "", coordinate: coord ?? .empty,
                            main: WeatherMainType(rawValue: weather?.main ?? ""),
                            temp: "\(main?.temp ?? 0)°", tempMin: "\(main?.tempMin ?? 0)°",
                            tempMax: "\(main?.tempMax ?? 0)°")
    }
}

extension CoordinateDTO {
    public func toEntity() -> CoordinateEntity? {
        guard let lon = lon, let lat = lat else { return nil }
        return CoordinateEntity(lon: lon, lat: lat)
    }
}
