//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 24/04/2025.
//

import Foundation

extension Double {
    func format(toPlaces: Int = 2) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = toPlaces
        
        return formatter.string(from: NSNumber(value: self))
    }
}
