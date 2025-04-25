//
//  HomeView.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 23/04/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            NavigationView {
                List {
                    Section {
                        NavigationLink(destination: LocationView()) {
                            createLocationRow(location: viewModel.selectedCity)
                        }
                    }
                    
                    Section {
                        ForEach(viewModel.forecasts, id: \.id) { forecast in
                            NavigationLink(destination: WeatherDetailView(day: createDayLabel(for: forecast.date), forecast: forecast)) {
                                createDayRow(date: forecast.date)
                            }
                        }
                    }
                }
                .navigationTitle("Weather forecast")
                .listSectionSpacing(16)
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .refreshable {
            viewModel.loadForecast()
        }
    }
    
    private func createLocationRow(location: String) -> some View {
        HStack(spacing: 0) {
            Text("Location")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(location)
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
    
    private func createDayRow(date: Date) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(createDayLabel(for: date))
                    .font(.body)
                
                Text(date.formattedString())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func createDayLabel(for date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_EN")
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date).capitalized
        }
    }
}

#Preview {
    HomeView()
}
