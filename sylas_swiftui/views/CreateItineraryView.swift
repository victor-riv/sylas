//
//  CreateItineraryView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/4/24.
//

import SwiftUI



struct CreateItineraryView: View {
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Image("kyoto")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height * 0.8)
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom)
                            )
                            .clipped()
                            .edgesIgnoringSafeArea(.top)
                    }
                    VStack(alignment: .leading) {
                        VStack (alignment: .leading, spacing: 10){
                            Text("Create a new itinerary")
                                .font(.title)
                            Text("Use AI to craft your personalized trip")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        .padding(.bottom, 20)
                        
                        
                        Button(action: {}) {
                            HStack {
                                Text("Get Started")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        }
                        //                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .padding()
                    .offset(y: geometry.size.height * 0.72)
                }
            }
        }
    }
}

#Preview {
    CreateItineraryView()
        .preferredColorScheme(.dark)
}


#Preview {
    CreateItineraryView()
        .preferredColorScheme(.dark)
}
