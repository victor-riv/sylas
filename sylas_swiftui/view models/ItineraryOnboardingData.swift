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
    @Published var selectedCity: City = City()
    @Published var selectedInterests: [String] = []
     let interests = ["Great Food", "Museums", "Shopping", "Hiking", "Beaches", "Coffee Shops", "Nightlife and Bars", "Concerts", "Theater", "Wine & Beer", "Photograpahy", "Tours", "Hidden Gems", "Tea", "Fishing"]
    
    func select(city: City) {
        guard selectedCity.id != city.id else {
            return
        }

        selectedCity = city
        selectedInterests.removeAll()
    }
    
    func select(interest: String) {
        selectedInterests.append(interest)
    }
    
    func deselect(interest: String) {
        selectedInterests.removeAll(where: { $0 == interest })
    }
    
    func handleInterestSelection(isSelected: Bool, interest: String) -> Void {
        if isSelected {
            select(interest: interest)
        } else {
            deselect(interest: interest)
        }
    }
}


struct PredictedCity {
    var primaryText: String
    var secondaryText: String
}
