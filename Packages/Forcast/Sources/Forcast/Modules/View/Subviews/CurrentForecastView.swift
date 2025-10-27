//
//  CurrentForecastView.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

import SwiftUI
import Domain

struct CurrentForecastView: View {
    let data: WeatherEntity

    var body: some View {
            VStack {
                HStack {
                    VStack {
                        Text(data.tempMin)
                        Text("Min")
                    }
                    Spacer()
                    VStack {
                        Text(data.temp)
                        Text("Current")
                    }
                    Spacer()
                    VStack {
                        Text(data.tempMax)
                        Text("Max")
                        
                    }
                }.padding(.horizontal, 24)
            }.padding(.vertical).background(data.main.assetColor) // ✅ Apply background color here
    }
}
