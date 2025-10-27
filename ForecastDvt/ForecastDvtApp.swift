//
//  ForecastDvtApp.swift
//  ForecastDvt
//
//  Created by Rizvi Naqvi on 18/10/2025.
//

import SwiftUI
import Router

@main
struct ForecastDvtApp: App {
    var body: some Scene {
        WindowGroup {
            AppNavHandler()
        }.modelContainer(sharedModelContainer)
    }
}
