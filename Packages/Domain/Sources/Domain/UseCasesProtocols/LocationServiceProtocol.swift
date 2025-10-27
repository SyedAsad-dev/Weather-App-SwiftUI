//
//  LocationServiceProtocol.swift
//  Domain
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import CoreLocation

public protocol LocationServiceProtocol {
    @MainActor
    func requestLocation() async throws -> AsyncStream<CLLocation>
}
