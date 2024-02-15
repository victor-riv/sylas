//
//  SidewaysScrollingButtonNavBar.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/12/24.
//

import SwiftUI

struct SidewaysScrollingButtonNavBar: View {
    let views = ["Explore", "Must see", "Make a trip", "Places to eat"]
    @State var selectedView: String = "Explore"
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(views, id: \.self) { viewText in
                        Button(action: {
                            self.selectedView = viewText
                        }, label: {
                            Text(viewText)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(viewText == selectedView ? Color(red: 254 / 255, green: 221 / 255, blue: 45 / 255) : .clear)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                        })
                    }
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

#Preview {
    SidewaysScrollingButtonNavBar()
}