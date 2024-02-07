//
//  ItineraryOnboarding.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/5/24.
//

import Foundation

class ItineraryOnboardingData: ObservableObject {
    @Published var geoname: String = ""
    @Published var cityPredictions: [City] = []
    @Published var selectedDestination: City = City()
}

struct PredictedCity {
    var primaryText: String
    var secondaryText: String
}
