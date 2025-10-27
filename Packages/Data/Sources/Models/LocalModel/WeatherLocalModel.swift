//
//  WeatherLocalModel.swift
//  Data
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import SwiftData
import Domain

@Model
public final class WeatherLocalModel: @unchecked Sendable {
    @Attribute(.unique) public var id: Int
    public var name: String
    public var lon: Double
    public var lat: Double
    public var main: String
    public var temp: String
    public var tempMin: String
    public var tempMax: String

    public init(from entity: WeatherEntity) {
        self.id = entity.id
        self.name = entity.name
        self.lon = entity.coordinate.lon
        self.lat = entity.coordinate.lat
        self.main = entity.main.rawValue
        self.temp = entity.temp
        self.tempMin = entity.tempMin
        self.tempMax = entity.tempMax
    }

    public func toEntity() -> WeatherEntity {
        WeatherEntity(
            id: id,
            name: name,
            coordinate: CoordinateEntity(lon: lon, lat: lat),
            main: WeatherMainType(rawValue: main),
            temp: temp,
            tempMin: tempMin,
            tempMax: tempMax
        )
    }
}
