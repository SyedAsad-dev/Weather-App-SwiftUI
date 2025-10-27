//
//  FavoriteViewModel.swift
//  Favorite
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import Foundation
import Utils
import Domain
import CoreLocation


public final class FavoriteViewModel: BaseViewModel {
    let loadFavorite: LoadFavoriteUseCaseProtocol
    let removeFavorite: RemoveFavoriteUseCaseProtocol
    let getFavotiteItems: ObserveFavoritesUseCaseProtocol
    var favoriteList: [WeatherEntity] = []
    public init(
        loadFavorite: LoadFavoriteUseCaseProtocol,
        removeFavorite: RemoveFavoriteUseCaseProtocol,
        getFavotiteItems: ObserveFavoritesUseCaseProtocol
    ) {
        self.loadFavorite = loadFavorite
        self.removeFavorite = removeFavorite
        self.getFavotiteItems = getFavotiteItems
        super.init()
    }
}

@MainActor
extension FavoriteViewModel {
    
    func requestData() {
        fetchAllFavorites()
    }
    
    func addFavoriteRequest(query: String) {
        isLoading = true
        Task {
            do {
                favoriteList = try await loadFavorite.execute(query: query)
                dataStatus = .success(.finished(.success))
            } catch let error as GenericError {
                dataStatus = .failure(.invalidData(error.errorDescription ?? ""))
            }
        }
    }
    
    func removeFavoriteRequest(id: Int) {
        isLoading = true
        Task {
            do {
                favoriteList = try await removeFavorite.execute(id: id)
                dataStatus = .success(.finished(.success))
            } catch let error as GenericError {
                dataStatus = .failure(.invalidData(error.errorDescription ?? ""))
            }
        }
    }
    
    func fetchAllFavorites() {
        isLoading = true
        Task {
            do {
                favoriteList = try await getFavotiteItems.geyAllList()
                dataStatus = .success(.finished(.success))
            } catch let error as GenericError {
                dataStatus = .failure(.invalidData(error.errorDescription ?? ""))
            }
        }
    }
    
    
    func mappingEntityToMap(items: [WeatherEntity]? = nil) -> [CityLocationEntity] {
        let source = items ?? favoriteList
        let mapCities = source.map {
            CityLocationEntity(
                name: $0.name,
                coordinate: CLLocationCoordinate2D(latitude: $0.coordinate.lat, longitude: $0.coordinate.lon),
                weather: $0.main
            )
        }
        return mapCities
    }
    
}

