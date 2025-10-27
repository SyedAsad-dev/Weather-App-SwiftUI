//
//  ForcastScreenRouterProtocol.swift
//  Favorite
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import Foundation
import Domain

@MainActor
public protocol FavoriteScreenRouterProtocol {
    func openMap(data: CitiesLocationEntity)
}
