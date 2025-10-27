import XCTest
import Domain
import Models
import Utils
@testable import Repositories

final class FavoriteRepositoryTests: XCTestCase {
    var sut: FavoriteRepository!
    var mockLocal: FavoriteMockFavoriteLocal!
    var mockHttp: FavoriteMockHTTPClient!
    override func setUp() {
        super.setUp()
        mockLocal = FavoriteMockFavoriteLocal()
        mockHttp = FavoriteMockHTTPClient()
        sut = FavoriteRepository(localDataSource: mockLocal, httpClient: mockHttp)
    }
    override func tearDown() {
        sut = nil
        mockLocal = nil
        mockHttp = nil
        super.tearDown()
    }
    func test_getCityForecast_SuccessfullyReturnsEntity() async throws {
        // Given
        let dto = CurrentWeatherDTO.mock() // Create a simple extension for this
        mockHttp.mockResponse = dto
        // When
        let entity = try await sut.getCityForecast(query: "London")
        // Then
        XCTAssertEqual(entity.name, dto.toEntity()?.name)
        XCTAssertEqual(mockLocal.saved.first?.name, dto.toEntity()?.name)
    }
    func test_getCityForecast_ThrowsError_WhenHttpFails() async throws {
        mockHttp.shouldThrow = true
        do {
            _ = try await sut.getCityForecast(query: "Paris")
            XCTFail("Expected error but succeeded")
        } catch {
            XCTAssertTrue(error is GenericError)
        }
    }
}
