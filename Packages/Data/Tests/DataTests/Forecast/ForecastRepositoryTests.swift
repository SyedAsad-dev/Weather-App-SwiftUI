//
//  ForecastRepositoryTests.swift
//  Data
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import XCTest
import Domain
@testable import Repositories

final class ForecastRepositoryTests: XCTestCase {
    var sut: ForecastRepository!
    var mockHTTP: MockHTTPClient!
    var mockLocal: MockLocalDataSource!
    override func setUp() {
        super.setUp()
        mockHTTP = MockHTTPClient()
        mockLocal = MockLocalDataSource()
        sut = ForecastRepository(localDataSource: mockLocal, httpClient: mockHTTP)
    }
    override func tearDown() {
        sut = nil
        mockHTTP = nil
        mockLocal = nil
        super.tearDown()
    }
    func test_loadTodayForecast_successNetwork() async throws {
        mockHTTP.shouldThrow = false
        mockLocal.savedToday = nil
        let result = try await sut.loadTodayForecast(lat: "10", lon: "20")
        XCTAssertEqual(result.name, "1")
        XCTAssertEqual(mockLocal.savedToday?.name, "1")
    }
    func test_loadTodayForecast_networkFailure_fallbackToLocal() async throws {
        mockHTTP.shouldThrow = true
        mockLocal.savedToday = WeatherEntity(
            id: 1,
            name: "LocalCity",
            coordinate: .empty,
            main: .unknown,
            temp: "25", tempMin: "--", tempMax: "--"
        )
        do {
            let result = try await sut.loadTodayForecast(lat: "10", lon: "20")
            XCTAssertEqual(result.name, "LocalCity")
        } catch {
            XCTFail("Expected fallback to local data, got error: \(error)")
        }
    }
    func test_loadWeeklyForecast_successNetwork() async throws {
        mockHTTP.shouldThrow = false
        mockLocal.savedWeekly = nil
        let result = try await sut.loadWeeklyForecast(lat: "10", lon: "20")
        XCTAssertEqual(result.count, 0)
        XCTAssertNotNil(mockLocal.savedWeekly)
    }
    func test_loadWeeklyForecast_networkFailure_fallbackToLocal() async throws {
        mockHTTP.shouldThrow = true
        let localEntity = WeeklyForecastEntity(code: "", count: 1, weatherList: [])
        mockLocal.savedWeekly = localEntity
        do {
            let result = try await sut.loadWeeklyForecast(lat: "10", lon: "20")
            XCTAssertEqual(result.count, 1)
        } catch {
            XCTFail("Expected fallback to local data, got error: \(error)")
        }
    }
}
