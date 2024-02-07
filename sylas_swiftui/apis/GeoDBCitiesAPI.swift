//
//  GeoDBCitiesAPI.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/6/24.
//

import Foundation

class GeoDBCitiesAPI {
    private let baseUrl = "http://geodb-free-service.wirefreethought.com/v1/geo"
    
    func fetchCities(matching query: String) async throws -> [City] {
        
        guard let url = URL(string: "\(baseUrl)/places?limit=10&types=CITY&namePrefix=\(query)&sort=-population") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        // Add headers if needed, for example, an API key
        // request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decodedResponse = try JSONDecoder().decode(CityResponse.self, from: data)
        return decodedResponse.data
    }
}

struct CityResponse: Codable {
    let data: [City]
}

struct City: Codable, Identifiable {
    let id: Int
    let wikiDataId: String
    let type: String
    let name: String
    let country: String
    let countryCode: String
    let region: String
    let regionCode: String
    let latitude: Double
    let longitude: Double
    let population: Int
}
