//
//  ForecastView.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import SwiftUI

public struct ForecastView: View {
    @State var viewModel: ForecastViewModel
    @State private var router: ForcastScreenRouterProtocol
    public init(
        viewModel: ForecastViewModel,
        router: ForcastScreenRouterProtocol
    ) {
        self.viewModel = viewModel
        _router = State(initialValue: router)
    }
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
        VStack(spacing: 0) {
            ForecastHeaderView(data: viewModel.todayWeather)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    CurrentForecastView(data: viewModel.todayWeather)
                    Divider().frame(height: 1).background(.white)
                    WeekWeatherView(data: viewModel.weeklyForecast)
                }
             
            }
        }   .background(viewModel.todayWeather.main.assetColor)
        .ignoresSafeArea(edges: .top)
        .loadingConfig(show: $viewModel.isLoading)
        .onViewDidLoad {
            viewModel.requestData()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
               title: Text(viewModel.presentableError),
               primaryButton: .default(Text("Retry")) {
                   viewModel.requestData()
               },
               secondaryButton: .cancel {}
           )
        }.colorScheme(.dark)
        Button {
                router.openFavorite()
            } label: {
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding()
            .accessibilityLabel("Favorites")
        }
    }
}
