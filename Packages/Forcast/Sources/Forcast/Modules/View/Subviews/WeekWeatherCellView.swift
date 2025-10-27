//
//  DailyWeatherCellView.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

import SwiftUI
import Domain

struct DailyWeatherCellView: View {
    let data: WeeklyForecastWeatherEntity

    var body: some View {
        HStack {
            Text(data.weekday)
                .frame(width: 150, alignment: .leading)

            data.main.icon
                .resizable()
                .frame(width: 30, height: 30)

            Spacer()
            Text(data.temp)
        }.padding(.horizontal, 24)
    }
}
