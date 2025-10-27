//
//  AppRoute.swift
//  Router
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import Foundation
import SwiftUI
import Domain

public enum AppRoute: Hashable {
    case ForecastScreen(mainNav: NavigationStateProtocol)
    case FavoriteScreen(mainNav: NavigationStateProtocol)
    case CityMapScreen(list: CitiesLocationEntity)
    
    public static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        switch (lhs, rhs) {
        case (.ForecastScreen, .ForecastScreen):
            return true
        case (.FavoriteScreen, .FavoriteScreen):
            return true
        case (.CityMapScreen, .CityMapScreen):
            return true
        default:
            return false
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .ForecastScreen:
            hasher.combine(0)
        case .FavoriteScreen:
            hasher.combine(1)
        case .CityMapScreen:
            hasher.combine(2)
        }
    }
}

extension AppRoute: View, MainDependancyContainer {
    
    public var body: some View {
        switch self {
        case let .ForecastScreen(mainNav):
            forecastViewContainer(mainNav: mainNav)
        case let .FavoriteScreen(mainNav: mainNav):
            favoriteViewContainer(mainNav: mainNav)
        case let .CityMapScreen(list: list):
            cityMapViewContainer(list: list)
        }
    }
}
