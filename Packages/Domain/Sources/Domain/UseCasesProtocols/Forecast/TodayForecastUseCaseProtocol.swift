//
//  ForecastUseCaseProtocol.swift
//  Domain
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

public protocol TodayForecastUseCaseProtocol {
    func execute(lat: Double, lon: Double) async throws -> WeatherEntity
}
