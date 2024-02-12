//
//  ItineraryOnboarding.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/5/24.
//

import Foundation
import Observation
import SwiftUI

@Observable
class ItineraryOnboardingData {
     var geoname: String = ""
     var cityPredictions: [City] = []
     var selectedCity: City = City()
     var selectedInterests: [String] = []
    private let fetchDebouncer = Debouncer(delay: 0.5)
    let interests = ["Great Food", "Museums", "Shopping", "Hiking", "Beaches", "Coffee Shops", "Nightlife and Bars", "Concerts", "Theater", "Wine & Beer", "Photograpahy", "Tours", "Hidden Gems", "Tea", "Fishing"]
    
    var geoNameBinding: Binding<String> {
        Binding(
            get: { self.geoname },
            set: { self.geoname = $0 }
        )
    }
    
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
    
    func fetchCitiesDebounced(query: String) async {
        guard !query.isEmpty else {
            DispatchQueue.main.async { [weak self] in
                self?.cityPredictions = []
            }
            return
        }
        fetchDebouncer.debounce { [weak self] in
            await self?.fetchCities(query: query)
        }
    }
    
    private func fetchCities(query: String) async {
        guard !query.isEmpty else {
            DispatchQueue.main.async { [weak self] in
                self?.cityPredictions = []
            }
            return
        }
        
        do {
            let fetchedCities = try await GeoDBCitiesAPI().fetchCities(matching: query)
            DispatchQueue.main.async { [weak self] in
                self?.cityPredictions = fetchedCities
            }
        } catch {
            DispatchQueue.main.async {
                print("Failed to fetch cities: \(error.localizedDescription)")
            }
        }
    }
}


struct PredictedCity {
    var primaryText: String
    var secondaryText: String
}
