//
//  MockHTTPClient.swift
//  Data
//
//  Created by Rizvi Naqvi on 22/10/2025.
//
import Networks
import Utils
import Models

// Mock HTTP Client
final class MockHTTPClient: HTTPClientProtocol {
    var shouldThrow = false
    var todayDTO: CurrentWeatherDTO = .mock()
    var weeklyDTO: WeeklyForecastResponseDTO = .mock()
    func sendRequest<T: EndPointType, P: Codable>(
        _ requestBuilder: T,
        model: P.Type
    ) async throws -> P {
        if shouldThrow {
            throw GenericError.invalidData("Mock Error")
        }
        if model == CurrentWeatherDTO.self {
            guard let result = todayDTO as? P else {
                throw GenericError.invalidData("Type mismatch: Expected CurrentWeatherDTO")
            }
            return result
        }
        if model == WeeklyForecastResponseDTO.self {
            guard let result = weeklyDTO as? P else {
                throw GenericError.invalidData("Type mismatch: Expected WeeklyForecastResponseDTO")
            }
            return result
        }
        throw GenericError.invalidData("Unexpected type: \(model)")
    }
}

extension WeeklyForecastResponseDTO {
    public static func mock() -> WeeklyForecastResponseDTO {
        return WeeklyForecastResponseDTO(code: "1", message: 0, count: 0, list: [], city: nil)
    }
}

extension CurrentWeatherDTO {
    public static func mock() -> CurrentWeatherDTO {
        return CurrentWeatherDTO(timezone: 1, id: 1, name: "1", base: "", visibility: 1, date: 1, code: 1)
    }
}
