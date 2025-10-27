//
//  CityMapView.swift
//  CityMap
//
//  Created by Rizvi Naqvi on 22/10/2025.
//

import SwiftUI
import Utils
import MapKit

public struct CityMapView: View {
    
    @State var viewModel: CityMapViewModel
    public init(
        viewModel: CityMapViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Map {
               ForEach(viewModel.cityList) { location in
                   Annotation(location.name, coordinate: location.coordinate) {
                       ZStack {
                           RoundedRectangle(cornerRadius: 12)
                               .fill(location.weather.assetColor)
                           location.weather.icon.resizable().frame(width: 24,height: 24).padding(5)
                               
                       }
                   }

               }
           }
          
      }
    
}
