//
//  MockLocationService.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Domain
import Utils
import Foundation
import CoreLocation

final class MockLocationService: LocationServiceProtocol {
    var shouldThrow = false
    var coordinates: CLLocation = CLLocation(latitude: 51.5074, longitude: 0.1278)
    
    func requestLocation() async throws -> AsyncStream<CLLocation> {
        if shouldThrow {
            throw GenericError.locationUnavailable
        }
        return AsyncStream { continuation in
            continuation.yield(coordinates)
            continuation.finish()
        }
    }
}
