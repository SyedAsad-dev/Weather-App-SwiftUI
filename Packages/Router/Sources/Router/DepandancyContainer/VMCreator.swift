//
//  VMCreator.swift
//  Router
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import Foundation
import Forcast
import Domain
import Favorite
import CityMap
import LocationService

@MainActor
final class VMCreator {
    
    static func ForecastVM(loaderTodayForecast: TodayForecastUseCaseProtocol, loaderWeeklyForecast: WeeklyForecastUseCaseProtocol) -> ForecastViewModel {
        return ForecastViewModel(loaderTodayForecast: loaderTodayForecast, loaderWeeklyForecast: loaderWeeklyForecast, locationService: LocationService())
    }
    
    static func FavoritetVM(loaderFavorite: LoadFavoriteUseCaseProtocol, removeFavorite: RemoveFavoriteUseCaseProtocol, observeFavorite: ObserveFavoritesUseCaseProtocol) -> FavoriteViewModel {
        return FavoriteViewModel(loadFavorite: loaderFavorite, removeFavorite: removeFavorite, getFavotiteItems: observeFavorite)
    }

    static func CityMapVM(list: CitiesLocationEntity) -> CityMapViewModel {
        return CityMapViewModel(cityList: list)
    }
    
}
