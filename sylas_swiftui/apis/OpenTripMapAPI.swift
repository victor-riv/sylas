//
//  OpenTripMapAPI.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/4/24.
//

import Foundation

class OpenTripMapAPIService {
    private let apiKey = Bundle.main.infoDictionary?["OPEN_TRIP_MAP_API_KEY"] as? String
    private let baseURL = "https://api.opentripmap.com/0.1/en/places"
    
    func getRegionCoordinates(geoname: String, completion: @escaping (Region) -> Void) {
        guard let apiKey = apiKey else { return }
        let urlString = "\(baseURL)/geoname?name=\(geoname)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid url string")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedReponse = try? JSONDecoder().decode(Region.self, from: data){
                    DispatchQueue.main.async {
                        completion(decodedReponse)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
