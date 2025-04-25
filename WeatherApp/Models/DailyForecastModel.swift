//
//  DailyForecastModel.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 25/04/2025.
//

import Foundation

struct DailyForecast: Identifiable {
    let id = UUID()
    let date: Date
    let maxTemp: Double
    let minTemp: Double
    let weatherCode: Int
    let humidityAvg: Int
    let rainAccumulationAvg: Double
    let windSpeedMax: Double
    let windDirectionAvg: Int
    let uvIndexMax: Int?
    let visibilityAvg: Double
    let pressureSeaLevelAvg: Double
}
