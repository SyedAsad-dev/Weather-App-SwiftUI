//
//  MockLocationService.swift
//  Domain
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils
import CoreLocation

final class MockLocationService: LocationServiceProtocol {
    var shouldThrow = false
    var fakeLocation: CLLocation = CLLocation(latitude: 51.5074, longitude: -0.1278) // London
    func requestLocation() async throws -> AsyncStream<CLLocation> {
        if shouldThrow {
            throw GenericError.locationUnavailable
        }
        return AsyncStream<CLLocation> { continuation in
            continuation.yield(fakeLocation)
            continuation.finish()
        }
    }
}
