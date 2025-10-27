
import XCTest
@testable import Favorite

final class FavoriteTests: XCTestCase {
    
    var sut: FavoriteViewModel!
    var mockLoad: MockLoadFavoriteUseCase!
    var mockRemove: MockRemoveFavoriteUseCase!
    var mockObserve: MockObserveFavoritesUseCase!
    
    override func setUp() {
        super.setUp()
        mockLoad = MockLoadFavoriteUseCase()
        mockRemove = MockRemoveFavoriteUseCase()
        mockObserve = MockObserveFavoritesUseCase()
        
        sut = FavoriteViewModel(
            loadFavorite: mockLoad,
            removeFavorite: mockRemove,
            getFavotiteItems: mockObserve
        )
    }
    
    override func tearDown() {
        sut = nil
        mockLoad = nil
        mockRemove = nil
        mockObserve = nil
        super.tearDown()
    }
    @MainActor
    func test_fetchAllFavorites_success() async throws {
        let expectation = XCTestExpectation(description: "Wait before executing removeFavoriteRequest")
            
        sut.fetchAllFavorites()
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertEqual(sut.favoriteList.count, 1)
        XCTAssertEqual(sut.dataStatus, .success(.finished(.success)))
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 3)
    }
    @MainActor
    func test_fetchAllFavorites_failure() async throws {
        let expectation = XCTestExpectation(description: "Wait before executing removeFavoriteRequest")
       
        mockObserve.shouldThrow = true
         sut.fetchAllFavorites()
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
            switch sut.dataStatus {
            case .failure(let error):
                XCTAssertTrue(error.errorDescription!.contains("Something went Wrong"))
            default:
                XCTFail("Expected failure status")
 
    
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 3)
    }
    @MainActor
    func test_addFavoriteRequest_success() async throws {
        let expectation = XCTestExpectation(description: "Wait before executing removeFavoriteRequest")
       
         sut.addFavoriteRequest(query: "London")
        try await Task.sleep(nanoseconds: 1_000_000_000)
     
            XCTAssertEqual(sut.favoriteList.count, 1)
            XCTAssertEqual(sut.dataStatus, .success(.finished(.success)))
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 3)
       
    }
    @MainActor
    func test_addFavoriteRequest_failure() async throws {
        let expectation = XCTestExpectation(description: "Wait before executing removeFavoriteRequest")
       
        mockLoad.shouldThrow = true
         sut.addFavoriteRequest(query: "London")
        try await Task.sleep(nanoseconds: 1_000_000_000)
      
            switch sut.dataStatus {
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("Something went Wrong"))
            default:
                XCTFail("Expected failure status")
    
        
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 3)
    }
    @MainActor
    func test_removeFavoriteRequest_success() async throws {
        let expectation = XCTestExpectation(description: "Wait before executing removeFavoriteRequest")
       
         sut.removeFavoriteRequest(id: 1)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
            XCTAssertEqual(sut.favoriteList.count, 1)
            XCTAssertEqual(sut.dataStatus, .success(.finished(.success)))
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 3)
        
    }
    @MainActor
    func test_removeFavoriteRequest_failure() async throws {
        let expectation = XCTestExpectation(description: "Wait before executing removeFavoriteRequest")
       
        mockRemove.shouldThrow = true
         sut.removeFavoriteRequest(id: 1)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
            switch sut.dataStatus {
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("Something went Wrong"))
            default:
                XCTFail("Expected failure status")
           
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 3)
    }
    @MainActor
    func test_mappingEntityToMap() async throws {
        let expectation = XCTestExpectation(description: "Wait before executing removeFavoriteRequest")
       
         sut.fetchAllFavorites()
        try await Task.sleep(nanoseconds: 1_000_000_000)
            let mapItems = sut.mappingEntityToMap()
            XCTAssertEqual(mapItems.count, 1)
            XCTAssertEqual(mapItems.first?.name, "London")
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 3)
    }
}


