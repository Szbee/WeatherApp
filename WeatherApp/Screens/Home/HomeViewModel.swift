//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 23/04/2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var selectedCity = "Dresden"
    @Published var forecasts: [DailyForecast] = []
    @Published var errorMessage: String?
    
    private let service = ForecastService()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init() {
        loadForecast()
    }
    
    // MARK: - Functions
    
    func loadForecast() {
        service.fetchForecast(for: selectedCity)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print(error)
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] daily in
                guard let self else { return }
                
                let formatter = ISO8601DateFormatter()
                self.forecasts = daily.prefix(5).compactMap { day in
                    if let date = formatter.date(from: day.time) {
                        return DailyForecast(
                            date: date,
                            maxTemp: day.values.temperatureMax,
                            minTemp: day.values.temperatureMin,
                            weatherCode: day.values.weatherCodeMax,
                            humidityAvg: day.values.humidityAvg,
                            rainAccumulationAvg: day.values.rainAccumulationAvg,
                            windSpeedMax: day.values.windSpeedMax,
                            windDirectionAvg: day.values.windDirectionAvg,
                            uvIndexMax: day.values.uvIndexMax,
                            visibilityAvg: day.values.visibilityAvg,
                            pressureSeaLevelAvg: day.values.pressureSeaLevelAvg
                        )
                    }
                    return nil
                }
            }
            .store(in: &cancellables)
    }
}
