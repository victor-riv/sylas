//
//  PredictedCityView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/5/24.
//

import SwiftUI

struct PredictedCityTile: View {
    let cityName: String
    let secondaryText: String?
    
    var body: some View {
        HStack(spacing: 12) {
            Image("madrid")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(cityName)
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack(spacing: 10) {
                    
                    
                    Text(secondaryText ?? "")
                        .font(.caption)
                }
            }
            .padding(.leading)
            
        }
    }
}

#Preview {
    PredictedCityTile(cityName: "Madrid", secondaryText: "Spain")
        .preferredColorScheme(.dark)
}
