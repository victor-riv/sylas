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
                        
                        NavigationLink(destination: GeonameView()) {
                            
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
                            
                            //                        .padding(.horizontal)
                            .padding(.bottom)
                        }
                        
                    }
                    .padding()
                    .offset(y: geometry.size.height * 0.72)
                }
            }
        }
    }
}

struct GeonameView: View {
    @EnvironmentObject var itineraryOnboardingData: ItineraryOnboardingData
    
    var body: some View {
        VStack {
            Text("Where would you like to go?")
                .font(.headline)
                .padding(.bottom, 20)
            TextField("Enter a place", text: $itineraryOnboardingData.geoname)
                .padding() // Adds padding inside the text field for the text
                .background(Color(red: 0.2, green: 0.2, blue: 0.2)) // Sets the background color of the text field
                .cornerRadius(12) // Rounds the corners of the text field
                .foregroundColor(.white) // Sets the text color to white
            // Adds some horizontal padding around the text field
            
            NavigationLink(destination: Text("Third Page")) {
                HStack {
                    Spacer()
                    HStack {
                        Text("Next")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .frame(width: 70)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 1)
                    )
                }
            }
            .padding(.top, 20)
        }
        .padding()
    }
}


#Preview {
    CreateItineraryView()
        .preferredColorScheme(.dark)
        .environmentObject(ItineraryOnboardingData())
}
