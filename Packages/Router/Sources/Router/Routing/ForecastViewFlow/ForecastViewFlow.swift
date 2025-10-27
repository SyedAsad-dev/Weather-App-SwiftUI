//
//  ForecastViewFlow.swift
//  Router
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import Forcast

struct ForecastScreenRouter: ForcastScreenRouterProtocol {
    
    let mainNav: NavigationStateProtocol
    init(mainNav: NavigationStateProtocol) {
        self.mainNav = mainNav
    }
    func openFavorite() {
        mainNav.goTo(.app(.FavoriteScreen(mainNav: mainNav)))
    }
}
