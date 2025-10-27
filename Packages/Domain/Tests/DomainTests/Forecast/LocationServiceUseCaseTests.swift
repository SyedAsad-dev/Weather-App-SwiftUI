//
//  LocationServiceUseCaseTests.swift
//  Domain
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import XCTest
import Utils
@testable import Domain
import CoreLocation

final class LocationServiceUseCaseTests: XCTestCase {
    var sut: LocationServiceUseCase!
    var mockService: MockLocationService!
    override func setUp() {
        super.setUp()
        mockService = MockLocationService()
        sut = LocationServiceUseCase(locationRequest: mockService)
    }
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    @MainActor
    func test_requestLocation_ReturnsLocationSuccessfully() async throws {
        // Given
        mockService.shouldThrow = false
        // When
        let stream = try await sut.requestLocation()
        var receivedLocation: CLLocation?
        for await location in stream {
            receivedLocation = location
        }
        // Then
        XCTAssertNotNil(receivedLocation)
        XCTAssertEqual(receivedLocation?.coordinate.latitude, 51.5074)
        XCTAssertEqual(receivedLocation?.coordinate.longitude, -0.1278)
    }
    @MainActor
    func test_requestLocation_ThrowsError_WhenServiceFails() async throws {
        // Given
        mockService.shouldThrow = true
        // When / Then
        do {
            _ = try await sut.requestLocation()
            XCTFail("Expected error but succeeded")
        } catch {
            XCTAssertTrue(error is GenericError)
        }
    }
}
