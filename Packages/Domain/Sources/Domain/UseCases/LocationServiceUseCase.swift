//
//  LocationServiceUseCase.swift
//  Domain
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import CoreLocation

public struct LocationServiceUseCase: LocationServiceProtocol {
    private let locationRequest: LocationServiceProtocol
    public init(locationRequest: LocationServiceProtocol) {
        self.locationRequest = locationRequest
    }
    public func requestLocation() async throws -> AsyncStream<CLLocation> {
        do {
            let response = try await locationRequest.requestLocation()
            return response
        } catch {
            throw error
        }
    }
}
