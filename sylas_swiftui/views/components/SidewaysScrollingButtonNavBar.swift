//
//  SidewaysScrollingButtonNavBar.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/12/24.
//

import SwiftUI

struct SidewaysScrollingButtonNavBar: View {
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button("Explore") {
                        // Action for Explore
                    }
                    .buttonStyle(ScrollingButtonStyle())

                    Button("Must see") {
                        // Action for Must see
                    }
                    .buttonStyle(ScrollingAlternateButtonStyle())

                    Button("Make a trip") {
                        // Action for Make a trip
                    }
                    .buttonStyle(ScrollingAlternateButtonStyle())

                    Button("Place to eat") {
                        // Action for Place to eat
                    }
                    .buttonStyle(ScrollingAlternateButtonStyle())
                }
            }
        }
}

struct ScrollingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color(red: 254 / 255, green: 221 / 255, blue: 45 / 255))
            .foregroundColor(.black)
            .cornerRadius(12)
            // You can add more styling here
    }
}

struct ScrollingAlternateButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .padding(.vertical, 10)
            .foregroundColor(.black)
            .cornerRadius(12)
            // You can add more styling here
    }
}

#Preview {
    SidewaysScrollingButtonNavBar()
}
