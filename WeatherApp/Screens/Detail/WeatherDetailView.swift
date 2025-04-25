//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 23/04/2025.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject var viewModel = WeatherDetailViewModel()

    let day: String
    let forecast: DailyForecast

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(day)
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

               statusView
                
                HStack(spacing: 16) {
                    createDegreeView(title: "Highest value", degree: forecast.maxTemp)
                    createDegreeView(title: "Lowest value", degree: forecast.minTemp)
                }
                
                rainAndHumidityView
                
                windView
                
                otherDetailsView
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private var statusView: some View {
        HStack(spacing: 8) {
            Text(viewModel.description(for: forecast.weatherCode))
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "info.circle")
                .foregroundStyle(.blue)
        }
        .padding()
        .cardPanel
    }
    
    private func createDegreeView(title: String, degree: Double) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.caption)
            
            Text("\(degree.description) °C")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .cardPanel
    }
    
    private var rainAndHumidityView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Average probability of rain")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(forecast.rainAccumulationAvg.formatted(.percent))
            }
            
            Divider()
                .padding(.horizontal, -16)
            
            HStack {
                Text("Average humidity")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text((forecast.humidityAvg.formatted(.percent)))
            }
            
            ProgressView(value: Double(forecast.humidityAvg), total: 100)
                .padding(.horizontal, 16)
        }
        .padding()
        .cardPanel
    }
    
    private var windView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Maximum wind speed")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(forecast.windSpeedMax.format(toPlaces: 0) ?? "0") km/h")
            }
            
            Divider()
                .padding(.horizontal, -16)

            Text("Wind direction")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "location.north.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 64)
                .rotationEffect(Angle(degrees: Double(forecast.windDirectionAvg)))

            Text(viewModel.getWindDirection(from: forecast.windDirectionAvg))
                .font(.caption)
        }
        .padding()
        .cardPanel
    }
    
    private var otherDetailsView: some View {
        VStack(spacing: 16) {
            if let uvIndexMax = forecast.uvIndexMax {
                HStack {
                    Text("Maximum UV index")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(uvIndexMax)")
                }
            }
            
            Divider()
                .padding(.horizontal, -16)

            HStack(spacing: 8) {
                Text("Average visibility")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(forecast.visibilityAvg.format() ?? "0") m")
            }
            
            Divider()
                .padding(.horizontal, -16)
            
            HStack(spacing: 8) {
                Text("Average air pressur")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(forecast.pressureSeaLevelAvg.format() ?? "0") mbar")
            }
        }
        .padding()
        .cardPanel
    }
}
