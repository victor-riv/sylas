//
//  Location.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/1/24.
//

import Foundation

struct Region: Codable, Equatable {
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    let population: Int
    let timezone: String
    let status: String
}
