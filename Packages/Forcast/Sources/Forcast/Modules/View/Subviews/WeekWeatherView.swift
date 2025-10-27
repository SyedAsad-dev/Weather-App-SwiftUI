//
//  WeekWeatherView.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

import SwiftUI
import Domain

struct WeekWeatherView: View {
    let data: WeeklyForecastEntity
    
    var body: some View {
        VStack {
            ForEach(data.weatherList, id: \.date) { data in
                DailyWeatherCellView(data: data)
            }
        }.padding(.vertical)
    }
}
