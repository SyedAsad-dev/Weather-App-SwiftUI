import XCTest
@testable import Forcast


final class ForcastTests: XCTestCase {
    var sut: ForecastViewModel!
    var mockToday: MockTodayForecastUseCase!
    var mockWeekly: MockWeeklyForecastUseCase!
    var mockLocation: MockLocationService!
    
    override func setUp() {
        super.setUp()
        mockToday = MockTodayForecastUseCase()
        mockWeekly = MockWeeklyForecastUseCase()
        mockLocation = MockLocationService()
        
        sut = ForecastViewModel(
            loaderTodayForecast: mockToday,
            loaderWeeklyForecast: mockWeekly,
            locationService: mockLocation
        )
    }
    
    override func tearDown() {
        sut = nil
        mockToday = nil
        mockWeekly = nil
        mockLocation = nil
        super.tearDown()
    }
    @MainActor
    func test_requestData_Success() async throws {
        // Given
        mockToday.shouldThrow = false
        mockWeekly.shouldThrow = false
        mockLocation.shouldThrow = false
        
 
            // When
            sut.requestData()
        
        
        // Then (wait for async Task)
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3 sec wait for async Task
        await MainActor.run {
            XCTAssertEqual(sut.todayWeather.name, "London")
            XCTAssertEqual(sut.dataStatus, .success(.finished(.success)))
        }
    }
    @MainActor
    func test_requestData_Fails_WhenLocationUnavailable() async throws {
        // Given
        mockLocation.shouldThrow = true
        
        // When
       sut.requestData()
        
        try await Task.sleep(nanoseconds: 300_000_000)
        
        // Then
        switch sut.dataStatus {
        case .failure(let err):
            XCTAssertTrue(err.errorDescription!.contains("Location Unavailable"))
        default:
            XCTFail("Expected failure but got \(String(describing: sut.dataStatus))")
        }
    }
    @MainActor
    func test_requestForecasts_HandlesFailureGracefully() async throws {
        // Given
        mockToday.shouldThrow = true
        mockWeekly.shouldThrow = true
        
        // When
         sut.requestForecasts(lat: 10, lon: 20)
        
        try await Task.sleep(nanoseconds: 300_000_000)
        
        // Then
        switch sut.dataStatus {
        case .failure:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected failure but got \(String(describing: sut.dataStatus))")
        }
    }
}


