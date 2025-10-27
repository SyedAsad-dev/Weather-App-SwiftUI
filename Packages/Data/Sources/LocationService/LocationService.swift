//
//  LocationService.swift
//  Data
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import CoreLocation
import Utils
import Domain

public final class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
    private let locationManager: CLLocationManager
    private var locationStreamContinuation: AsyncStream<CLLocation>.Continuation?
    private var authorizationContinuation: CheckedContinuation<Void, any Error>?
    public override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    public func requestLocation() async throws -> AsyncStream<CLLocation> {
        let status = locationManager.authorizationStatus

        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            try await waitForAuthorization()
        case .denied:
            throw GenericError.authorizationDenied
        case .restricted:
            throw GenericError.authorizationDenied
        case .authorizedWhenInUse, .authorizedAlways:
            break
        @unknown default:
            throw GenericError.unknownError
        }

        return AsyncStream<CLLocation>(CLLocation.self) { continuation in
            self.locationStreamContinuation = continuation
            self.locationManager.startUpdatingLocation()
        }
    }
    // MARK: - CLLocationManagerDelegate

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            guard locationStreamContinuation != nil else { return }
            locationStreamContinuation?.yield(location)
//            locationStreamContinuation?.finish()
//            locationStreamContinuation = nil
        }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("❌ Location error: \(error.localizedDescription)")
        // Optionally yield a failure marker or finish the stream
        locationStreamContinuation?.finish()
        locationStreamContinuation = nil
    }
    @MainActor
    private func waitForAuthorization() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, any Error>) in
            // Prevent double-resume
            guard self.authorizationContinuation == nil else {
                continuation.resume(throwing: GenericError.unknownError)
                return
            }

            self.authorizationContinuation = continuation
        }
    }
    // Inside your delegate
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let continuation = authorizationContinuation else { return }
        authorizationContinuation = nil // Clear early to prevent double resume

        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            continuation.resume()
        case .denied:
            continuation.resume(throwing: GenericError.authorizationDenied)
        case .restricted:
            continuation.resume(throwing: GenericError.locationUnavailable)
        default:
            continuation.resume(throwing: GenericError.unknownError)
        }
    }

}
