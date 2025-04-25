//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 23/04/2025.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_EN")
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
