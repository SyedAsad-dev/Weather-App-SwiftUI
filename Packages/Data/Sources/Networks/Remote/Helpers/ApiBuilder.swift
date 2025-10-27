//
//  ApiBuilder.swift
//  Data
//
//  Created by Rizvi Naqvi on 18/10/2025.
//

import Foundation
import EnvironmentManager

public enum ApiBuilder {
    case todayForecast(String, String)
    case weeklyForecast(String, String)
    case cityForecast(String)
}

extension ApiBuilder: EndPointType {
    public var path: String {
          switch self {
          case .todayForecast:
              return "weather"
          case .weeklyForecast:
              return "forecast"
          case .cityForecast:
              return "weather"
          }
      }
    public var headers: HTTPHeaders? {
        switch self {
        default:
            return defaultHeaders
        }
    }
    public var task: HTTPTask {
        switch self {
        case .todayForecast(let lat, let lng), .weeklyForecast(let lat, let lng):
            let parameters: [String: Any] = [
                           "lat": lat,
                           "lon": lng,
                           "appid": AppDefaults.appid.rawValue
                       ]
            return .requestParametersAndHeaders(
                            bodyParameters: nil,
                            bodyEncoding: .urlEncoding,
                            urlParameters: parameters,
                            additionHeaders: headers
                        )
        case .cityForecast(let query):
            let parameters: [String: Any] = [
                           "q": query,
                           "appid": AppDefaults.appid.rawValue
                       ]
            return .requestParametersAndHeaders(
                            bodyParameters: nil,
                            bodyEncoding: .urlEncoding,
                            urlParameters: parameters,
                            additionHeaders: headers
                        )
        }
    }
    public var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}
