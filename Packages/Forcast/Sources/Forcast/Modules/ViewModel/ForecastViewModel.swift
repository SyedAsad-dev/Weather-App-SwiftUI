//
//  ForecastViewModel.swift
//  Forcast
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import Foundation
import Utils
import Domain


public final class ForecastViewModel: BaseViewModel {
    
    var todayWeather = WeatherEntity.empty
    var weeklyForecast = WeeklyForecastEntity.empty
    let loaderTodayForecast: TodayForecastUseCaseProtocol
    let loaderWeeklyForecast: WeeklyForecastUseCaseProtocol
    let locationService: LocationServiceProtocol
    
    public init(
        loaderTodayForecast: TodayForecastUseCaseProtocol,
        loaderWeeklyForecast: WeeklyForecastUseCaseProtocol,
        locationService: LocationServiceProtocol
    ) {
        self.loaderTodayForecast = loaderTodayForecast
        self.loaderWeeklyForecast = loaderWeeklyForecast
        self.locationService = locationService
        super.init()
      
    }
}
@MainActor
extension ForecastViewModel {
    func requestData() {
        isLoading = true
        Task {
            do {
                let (lat, lon) = try await handleLocationUpdates()
                requestForecasts(lat: lat, lon: lon)
            } catch let error as GenericError {
                dataStatus = .failure(.invalidData(error.errorDescription ?? ""))
            }
        }
    }

    private func handleLocationUpdates() async throws -> (Double, Double) {
       let stream = try await locationService.requestLocation()
       for try await location in stream {
           let lat = location.coordinate.latitude
           let lon = location.coordinate.longitude
           return (lat, lon)
       }
       throw GenericError.locationUnavailable
    }
   
    func requestForecasts(lat: Double, lon: Double)  {
        // Capture dependencies outside async lets
        let todayLoader = loaderTodayForecast
        let weeklyLoader = loaderWeeklyForecast
        Task {
            async let todayWeatherThread = todayLoader.execute(lat: lat, lon: lon)
            async let weeklyForecastThread = weeklyLoader.execute(lat: lat, lon: lon)
            
            do {
                let todayResult = try await todayWeatherThread
                let weeklyResult = try await weeklyForecastThread
                
                todayWeather = todayResult
                weeklyForecast = weeklyResult
                dataStatus = .success(.finished(.success))
            } catch {
                dataStatus = .failure(.invalidData(error.localizedDescription))
            }
        }
    }
}
