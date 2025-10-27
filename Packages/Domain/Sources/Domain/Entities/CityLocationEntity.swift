//
//  CityLocationEntity.swift
//  Domain
//
//  Created by Rizvi Naqvi on 22/10/2025.
//
import Foundation
import CoreLocation

public typealias CitiesLocationEntity = [CityLocationEntity]

public struct CityLocationEntity: Sendable, Equatable, Identifiable {
    public let id: UUID
    public let name: String
    public let coordinate: CLLocationCoordinate2D
    public let weather: WeatherMainType
    public init(name: String, coordinate: CLLocationCoordinate2D, weather: WeatherMainType) {
        self.id = UUID()
        self.name = name
        self.coordinate = coordinate
        self.weather = weather
    }
    public static func == (lhs: CityLocationEntity, rhs: CityLocationEntity) -> Bool {
           return lhs.id == rhs.id
       }
}
