//
//  NetworkingAppDefault.swift
//  Data
//
//  Created by Rizvi Naqvi on 18/10/2025.
//

import Foundation
public enum AppDefaultsKeys: String {
    case baseUrl
}

internal class ValueWrapper<T: Codable>: Codable {
    var value: T
    init(value: T) {
        self.value = value
    }
}

public actor NetworkingAppDefault {
    public static let shared = NetworkingAppDefault()
    fileprivate init() {
    }
    fileprivate let userDefaults = UserDefaults.standard
    public func save<T: Codable>(_ object: T, forKey key: AppDefaultsKeys) {
        let wrappedValue = ValueWrapper(value: object)
        guard let encoded = try? JSONEncoder().encode(wrappedValue) else { return }
        userDefaults.set(encoded, forKey: key.rawValue)
    }
    public func get<T: Codable>(_ key: AppDefaultsKeys) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        do {
            let wrapper = try JSONDecoder().decode(ValueWrapper<T>.self, from: data)
            return wrapper.value
        } catch {
            debugPrint("⚠️ Failed to decode \(key.rawValue): \(error)")
            return nil
        }
    }

}
