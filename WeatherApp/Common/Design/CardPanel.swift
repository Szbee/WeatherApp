//
//  CardPanel.swift
//  WeatherApp
//
//  Created by Hartmann Szabolcs on 23/04/2025.
//

import Foundation

import SwiftUI

extension View {
    var cardPanel: some View {
        self
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
