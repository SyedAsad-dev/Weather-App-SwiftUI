//
//  NavigationHandler.swift
//  Router
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import SwiftUI

public struct AppNavHandler: View {
    @StateObject private var viewModel = AppNavHandlerViewModel()
    public init() {}
    
    public var body: some View {
        let firstView: AppRoute = .ForecastScreen(mainNav: viewModel)
        NavigationStack(path: $viewModel.appRoutes) {
            firstView
                .navigationsConfig()
        }
    }
}
