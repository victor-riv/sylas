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
        return decodedResponse.data.filter { $0.countryCode != "CN" && $0.countryCode != "RU" }
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
    
    init(
        id: Int = 0,
        wikiDataId: String = "",
        type: String = "",
        name: String = "",
        country: String = "",
        countryCode: String = "",
        region: String = "",
        regionCode: String = "",
        latitude: Double = 0.0,
        longitude: Double = 0.0,
        population: Int = 0
    ) {
        self.id = id
        self.wikiDataId = wikiDataId
        self.type = type
        self.name = name
        self.country = country
        self.countryCode = countryCode
        self.region = region
        self.regionCode = regionCode
        self.latitude = latitude
        self.longitude = longitude
        self.population = population
    }
}
