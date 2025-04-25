//
//  ForecastService.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 23/04/2025.
//

import Foundation
import Combine

struct ForecastResponse: Decodable {
    struct Timelines: Decodable {
        struct Daily: Decodable {
            let time: String
            let values: Values
        }

        let daily: [Daily]
    }

    struct Values: Decodable {
        let temperatureMax: Double
        let temperatureMin: Double
        let weatherCodeMax: Int
        let humidityAvg: Int
        let rainAccumulationAvg: Double
        let windSpeedMax: Double
        let windDirectionAvg: Int
        let uvIndexMax: Int?
        let visibilityAvg: Double
        let pressureSeaLevelAvg: Double
    }

    let timelines: Timelines
}

class ForecastService {
    private let apiKey = "YOUR_API_KEY" // TODO: - Add Secrets.plist
    private let baseURL = "https://api.tomorrow.io/v4/weather/forecast"

    func fetchForecast(for city: String) -> AnyPublisher<[ForecastResponse.Timelines.Daily], Error> {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "location", value: city),
            URLQueryItem(name: "timesteps", value: "1d"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]

        let request = URLRequest(url: components.url!)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ForecastResponse.self, decoder: JSONDecoder())
            .map {
                $0.timelines.daily
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
