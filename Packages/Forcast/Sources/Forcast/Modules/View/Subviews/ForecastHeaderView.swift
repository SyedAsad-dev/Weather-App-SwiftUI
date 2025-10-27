//
//  ForecastHeaderView.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

import SwiftUI
import Domain

struct ForecastHeaderView: View {
    let data: WeatherEntity

    var body: some View {
        ZStack(alignment: .center) {
            // Background Image
            data.main.backgroundImage
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipped()
                .edgesIgnoringSafeArea(.top) // Only for full screen views

            VStack {
                Text(data.temp)
                    .font(.system(size: 60))
                    .fontWeight(.thin)
                Text(data.main.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.medium)
            }
            
        }.frame(height: 300).background(data.main.assetColor)
        
    }
}
