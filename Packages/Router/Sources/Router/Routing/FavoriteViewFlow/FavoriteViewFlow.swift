//
//  FavoriteViewFlow.swift
//  Router
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Favorite
import Domain

struct FavoriteScreenRouter: FavoriteScreenRouterProtocol {
    let mainNav: NavigationStateProtocol
    init(mainNav: NavigationStateProtocol) {
        self.mainNav = mainNav
    }
    func openMap(data: CitiesLocationEntity) {
        mainNav.goTo(.app(.CityMapScreen(list: data)))
    }
}
