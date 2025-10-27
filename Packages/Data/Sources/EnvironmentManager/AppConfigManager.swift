//
//  AppConfigManager.swift
//  Data
//
//  Created by Rizvi Naqvi on 18/10/2025.
//

import Foundation
import AppDefault

public enum AppDefaults: String {
    case appid = "150b71e17353334df2c28e77da302f80"
}

enum AppBaseURL: String, Codable {
    case production = "https://api.openweathermap.org/data/2.5/"
}

public actor AppConfigManager {
     static let shared = AppConfigManager()

    private(set) var cachedBaseURL: String = AppBaseURL.production.rawValue
    private static var _currentBaseURL: String = AppBaseURL.production.rawValue

    /// Public sync snapshot (read-only)
    nonisolated public static var currentBaseURL: String { _currentBaseURL }

    func selectBaseUrl(_ url: AppBaseURL) async {
        await NetworkingAppDefault.shared.save(url, forKey: .baseUrl)
        cachedBaseURL = url.rawValue
        Self._currentBaseURL = url.rawValue     // update snapshot
    }

    private func getSelectedBaseURL() async -> String {
        guard let baseUrl: AppBaseURL = await NetworkingAppDefault.shared.get(.baseUrl) else {
            return AppBaseURL.production.rawValue
        }
        return baseUrl.rawValue
    }

    func initialize() async {
        let base = await getSelectedBaseURL()
        cachedBaseURL = base
        Self._currentBaseURL = base             // keep snapshot aligned
    }
}
