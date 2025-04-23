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
                        createLocationRow(location: "Dresden")
                    }
                    
                    Section {
                        ForEach(viewModel.daysArray, id: \.id) { item in
                            createDayRow(day: item.day, date: item.date.formattedString())
                        }
                    }
                }
                .navigationTitle("Weather forecast")
                .listSectionSpacing(16)
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
    
    private func createLocationRow(location: String) -> some View {
        Button {
            // TODO: - navigation
        } label: {
            HStack {
                Text("Location")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.black)
                
                Text(location)
                    .font(.body)
                    .foregroundStyle(.gray)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
    }
    
    private func createDayRow(day: String, date: String) -> some View {
        Button {
            // TODO: - navigation
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(day)
                        .font(.body)
                        .foregroundStyle(.black)
                    
                    Text(date)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    HomeView()
}
