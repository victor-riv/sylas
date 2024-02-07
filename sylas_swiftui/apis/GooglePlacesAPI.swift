//
//  GooglePlacesAPI.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/5/24.
//

import Foundation
import GooglePlaces

class MyPlacesAPI {
    func fetchCitySuggestions(query: String, completion: @escaping ([PredictedCity]) -> Void){
        let token = GMSAutocompleteSessionToken.init()
        
        let filter = GMSAutocompleteFilter()
        filter.types = ["locality"]
        
        GMSPlacesClient.shared().findAutocompletePredictions(fromQuery: query, filter: nil, sessionToken: token) { (results, error) in
            guard let results = results, error == nil else {
                print("Autocomplete error: \(error!.localizedDescription)")
                return
            }
            
            let predictions = results.map { prediction in
                let primaryText = prediction.attributedPrimaryText.string
                let secondaryText = prediction.attributedSecondaryText?.string ?? ""
                return PredictedCity(primaryText: primaryText, secondaryText: secondaryText)
                
            }
            
            DispatchQueue.main.async {
                completion(predictions)
            }
        }
    }  
}
