//
//  TodayForecastUseCaseTests.swift
//  Domain
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import XCTest
import Utils
@testable import Domain

final class TodayForecastUseCaseTests: XCTestCase {
    var sut: TodayForecastUseCase!
    var mockRepository: MockForecastRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockForecastRepository()
        sut = TodayForecastUseCase(repository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    func test_execute_ReturnsWeatherEntity() async throws {
        // Given
        mockRepository.shouldThrow = false

        // When
        let result = try await sut.execute(lat: 10, lon: 20)

        // Then
        XCTAssertEqual(result.name, "Paris")
    }

    func test_execute_ThrowsError_WhenRepositoryFails() async throws {
        // Given
        mockRepository.shouldThrow = true

        do {
            _ = try await sut.execute(lat: 10, lon: 20)
            XCTFail("Expected error but succeeded")
        } catch {
            XCTAssertTrue(error is GenericError)
        }
    }
}
