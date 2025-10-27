//
//  EndPointType.swift
//  Data
//
//  Created by Rizvi Naqvi on 18/10/2025.
//

import Foundation
import EnvironmentManager

public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

extension EndPointType {
    var environmentBaseURL: String {
        return AppConfigManager.currentBaseURL
    }

    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }

    var requestURL: URL {
        return baseURL.appendingPathComponent(path)
    }
}
