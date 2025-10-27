//
//  FavoriteUseCasesTests.swift
//  Domain
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import XCTest
import Utils
@testable import Domain
import CoreLocation

final class FavoriteUseCasesTests: XCTestCase {
    var mockRepo: MockFavoriteRepository!
    var mockLocal: MockFavoriteLocalDataSource!
    override func setUp() {
        super.setUp()
        mockRepo = MockFavoriteRepository()
        mockLocal = MockFavoriteLocalDataSource()
    }
    override func tearDown() {
        mockRepo = nil
        mockLocal = nil
        super.tearDown()
    }
    // MARK: - ObserveFavoritesUseCase
    func test_ObserveFavoritesUseCase_ReturnsAllFavorites() async throws {
        // Given
        let useCase = ObserveFavoritesUseCase(localDataSource: mockLocal)
        mockLocal.favorites = [.mock(id: 1, name: "Paris"), .mock(id: 2, name: "Berlin")]
        // When
        let result = try await useCase.geyAllList()
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "Paris")
    }
    // MARK: - LoadFavoriteUseCase
    func test_LoadFavoriteUseCase_ReturnsLocalFavorites_AfterNetworkCall() async throws {
        // Given
        let useCase = LoadFavoriteUseCase(repository: mockRepo, localDataSource: mockLocal)
        mockRepo.result = .mock(id: 100, name: "London")
        mockLocal.favorites = [.mock(id: 100, name: "London")]
        // When
        let result = try await useCase.execute(query: "London")
        // Then
        XCTAssertEqual(result.first?.name, "London")
        XCTAssertEqual(mockRepo.lastQuery, "London")
    }
    func test_LoadFavoriteUseCase_Throws_WhenRepositoryFails() async throws {
        // Given
        let useCase = LoadFavoriteUseCase(repository: mockRepo, localDataSource: mockLocal)
        mockRepo.shouldThrow = true
        do {
            _ = try await useCase.execute(query: "Rome")
            XCTFail("Expected error but succeeded")
        } catch {
            XCTAssertTrue(error is GenericError)
        }
    }
    // MARK: - RemoveFavoriteUseCase
    func test_RemoveFavoriteUseCase_RemovesItemSuccessfully() async throws {
        // Given
        mockLocal.favorites = [.mock(id: 1, name: "Oslo"), .mock(id: 2, name: "Tokyo")]
        let useCase = RemoveFavoriteUseCase(localDataSource: mockLocal)
        // When
        let result = try await useCase.execute(id: 1)
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Tokyo")
    }
    func test_RemoveFavoriteUseCase_Throws_WhenLocalFails() async throws {
        // Given
        mockLocal.shouldThrow = true
        let useCase = RemoveFavoriteUseCase(localDataSource: mockLocal)
        do {
            _ = try await useCase.execute(id: 10)
            XCTFail("Expected error but succeeded")
        } catch {
            XCTAssertTrue(error is GenericError)
        }

    }

}
