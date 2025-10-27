//
//  MainDependancyContainer.swift
//  Router
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import SwiftUI
import Foundation
import Forcast
import CityMap
import Domain
import Models
import SwiftData
import Favorite
import Networks
import Repositories

public typealias MainDependancyContainer = ForecastViewContainer & FavoriteViewContainer & CityMapViewContainer

public let sharedModelContainer: ModelContainer = {
       let schema = Schema([
           WeatherLocalModel.self,
           WeeklyForecastLocalModel.self,
           WeeklyForecastDayLocalModel.self
       ])
       let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

       do {
           return try ModelContainer(for: schema, configurations: [modelConfiguration])
       } catch {
           fatalError("Could not create ModelContainer: \(error)")
       }
   }()



@MainActor
public protocol ForecastViewContainer {
    @ViewBuilder
    func forecastViewContainer(mainNav: NavigationStateProtocol) -> ForecastView
}

extension ForecastViewContainer {
    public func forecastViewContainer(mainNav: NavigationStateProtocol) -> ForecastView {
        // Create actor-based SwiftData sources for local models
        
        
        let weeklyDataSource = SwiftDataGenericActorDataSource<WeeklyForecastLocalModel>(modelContainer: sharedModelContainer)
        let todayDataSource = SwiftDataGenericActorDataSource<WeatherLocalModel>(modelContainer: sharedModelContainer)
        
        let localRepoImplementation = LocalDataSourceRepositoryImplement(weeklyDataSource: weeklyDataSource, todayDataSource: todayDataSource)
        
        let httpClient = HTTPClient()
        
        let repo = ForecastRepository(localDataSource: localRepoImplementation, httpClient: httpClient)
        
        return ForecastView(
            viewModel: VMCreator.ForecastVM(
                loaderTodayForecast: TodayForecastUseCase(repository: repo),  loaderWeeklyForecast: WeeklyForecastUseCase(repository: repo)
            ), router: ForecastScreenRouter(mainNav: mainNav)
        )
    }
}


@MainActor
public protocol FavoriteViewContainer {
    @ViewBuilder
    func favoriteViewContainer(mainNav: NavigationStateProtocol) -> FavoriteView
}

extension FavoriteViewContainer {
    public func favoriteViewContainer(mainNav: NavigationStateProtocol) -> FavoriteView {
        // Create actor-based SwiftData sources for local models

        let localModel = SwiftDataGenericActorDataSource<WeatherLocalModel>(modelContainer: sharedModelContainer)
        
        let localRepoImplementation = FavoriteLocalRepositoryImplement(favoriteDataSource: localModel)
        
        let httpClient = HTTPClient()
        
        let repo = FavoriteRepository(localDataSource: localRepoImplementation, httpClient: httpClient)

        return FavoriteView(
            viewModel: VMCreator.FavoritetVM(loaderFavorite: LoadFavoriteUseCase(repository: repo, localDataSource: localRepoImplementation), removeFavorite: RemoveFavoriteUseCase(localDataSource: localRepoImplementation), observeFavorite: ObserveFavoritesUseCase(localDataSource: localRepoImplementation)), router: FavoriteScreenRouter(mainNav: mainNav)
            )
    }
}


@MainActor
public protocol CityMapViewContainer {
    @ViewBuilder
    func cityMapViewContainer(list: CitiesLocationEntity) -> CityMapView
}

extension CityMapViewContainer {
    public func cityMapViewContainer(list: CitiesLocationEntity) -> CityMapView {
        // Create actor-based SwiftData sources for local models

        return CityMapView(
            viewModel: VMCreator.CityMapVM(list: list)
            )
    }
}
