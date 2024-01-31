//
//  DestinationCard.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import SwiftUI

struct DestinationCardView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("madrid") // Replace with your actual image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                )
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Tainan, Taiwan")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                
                HStack {
                    Image(systemName: "car.fill")
                        .foregroundColor(.white)
                    Text("200 km")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "thermometer.sun.fill")
                        .foregroundColor(.white)
                    Text("23°C")
                        .foregroundColor(.white)
                }
                .padding([.leading, .bottom, .trailing], 8)
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                
                Text("Ancient Capital Tainan, the ancient capital of Taiwan, is situated on the southwestern coastal plains of the island...")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
            }
            .padding(.leading)
            
            Button(action: {
                // Plan Now action
            }) {
                HStack {
                    Text("Plan Now")
                    Image(systemName: "arrow.right.circle.fill")
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
            .padding([.trailing, .bottom])
        }
        .frame(height: 250)
    }
}

#Preview {
    DestinationCardView()
}
