//
//  CurrentForecastEntity.swift
//  Domain
//
//  Created by Rizvi Naqvi on 20/10/2025.
//
import Foundation
import SwiftUI

public enum WeatherMainType: String, Sendable, Equatable {
    case cloud = "CLOUDY"
    case rain = "RAINY"
    case clear = "SUNNY"
    case drizzle = "Drizzly"
    case unknown

    public init(rawValue: String) {
        switch rawValue.lowercased() {
        case "cloud", "clouds", "cloudy":
            self = .cloud
        case "rain", "rainy":
            self = .rain
        case "clear", "sunny":
            self = .clear
        case "Drizzle", "Drizzly":
            self = .drizzle
        default:
            self = .unknown
        }
    }
}

extension WeatherMainType {
   public var icon: Image {
        switch self {
        case .cloud:
            return Image("partlysunny")
        case .rain, .drizzle:
            return Image("rain")
        default:
            return Image("clear")
        }
    }

    public var assetColor: Color {
            switch self {
            case .cloud:
                return Color("CLOUDY")
            case .rain, .drizzle:
                return Color("RAINY")
            default:
                return Color("SUNNY")
            }
        }

    public var backgroundImage: Image {
        switch self {
        case .cloud:
            return Image("forest_cloudy")
        case .rain, .drizzle:
            return Image("forest_rainy")
        default:
            return Image("forest_sunny")
        }
    }
}

// Domain Layer
public struct WeatherEntity: Sendable, Equatable, Identifiable {
    public var id: Int
    public var name: String
    public var coordinate: CoordinateEntity
    public var main: WeatherMainType
    public var temp: String
    public var tempMin: String
    public var tempMax: String

    public init(
        id: Int,
        name: String,
        coordinate: CoordinateEntity,
        main: WeatherMainType,
        temp: String,
        tempMin: String,
        tempMax: String,
    ) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.main = main
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
    }
    public static var empty: Self {
           .init(
               id: 0,
               name: "",
               coordinate: .empty,
               main: .unknown,
               temp: "--", tempMin: "--", tempMax: "--"
           )
       }
}

public struct CoordinateEntity: Sendable, Equatable {
    public var lon: Double
    public var lat: Double

    public init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
    public static var empty: Self {
           .init(lon: 0.0, lat: 0.0)
       }
}
