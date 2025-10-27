//
//  CityMapViewModel.swift
//  CityMap
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import Foundation
import Utils
import Domain
import CoreLocation


public final class CityMapViewModel: BaseViewModel {
    var cityList: CitiesLocationEntity = []
    public init(
        cityList: CitiesLocationEntity
    ) {
        self.cityList = cityList
        super.init()
    }

}

