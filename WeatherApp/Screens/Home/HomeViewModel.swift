//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 23/04/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var daysArray: [DaysModel] = []
    
    init() {
        createDays()
    }
    
    private func createDays() {
        let calendar = Calendar.current
        let today = Date()
        
        for offset in 0..<5 {
            if let date = calendar.date(byAdding: .day, value: offset, to: today) {
                let label: String
                
                switch offset {
                case 0:
                    label = "Today"
                case 1:
                    label = "Tomorrow"
                default:
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_EN")
                    formatter.dateFormat = "EEEE"
                    label = formatter.string(from: date)
                }

                daysArray.append(DaysModel(day: label, date: date))
            }
        }
    }
}
