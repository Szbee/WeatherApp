//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 23/04/2025.
//

import Foundation
import Combine

class WeatherDetailViewModel: ObservableObject {
    // MARK: - Properties

    private var descriptions: [Int: String] = [:]
    
    // MARK: - Functions
    
    private func loadDescriptions() {
        guard let url = Bundle.main.url(forResource: "WeatherCodes", withExtension: "json") else {
            print("Can't open WeatherCodes.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let rawDict = try JSONDecoder().decode([String: String].self, from: data)
            
            descriptions = rawDict.reduce(into: [:]) { result, item in
                if let key = Int(item.key) {
                    result[key] = item.value
                }
            }
        } catch {
            print("Error: \(error)")
        }

    }
    
    func description(for code: Int) -> String {
        loadDescriptions()
        return descriptions[code] ?? "Unknown"
    }
    
    func getWindDirection(from degrees: Int) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((Double(degrees) + 22.5) / 45.0) % 8
        return directions[index]
    }
}
