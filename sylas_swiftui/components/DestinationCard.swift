//
//  DestinationCard.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import SwiftUI

struct DestinationCardView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Image("madrid")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                )
                .clipped()
            
            
            Text("Madrid, Spain")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal, 50)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(10)
                .offset(x: 0, y: -20)
        }
        .frame(height: 250)
    }
}

struct DestinationCardView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationCardView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
