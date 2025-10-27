//
//  WeaklyForecastUseCaseProtocol.swift
//  Domain
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

public protocol WeeklyForecastUseCaseProtocol {
    func execute(lat: Double, lon: Double) async throws -> WeeklyForecastEntity
}
