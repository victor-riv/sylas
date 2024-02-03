//
//  ItineraryView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/31/24.
//

import SwiftUI

struct ItineraryView: View {
    @State private var toggledID: Int = 1
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        DestinationCardView()
                        HStack (alignment: .bottom){
                            VStack (alignment: .leading,spacing: 12){
                                HStack (spacing: 12) {
                                    VStack (alignment: .leading) {
                                        Text("Itinerary for Madrid")
                                            
                                        Text("from Feb 2-5, 2024").font(.footnote)
                                    }
                                }
                                HStack {
                                    ForEach(1...4, id: \.self) { day in
                                        Button(action: {
                                            self.toggledID = day
                                        }) {
                                            
                                            Text("D\(day)")
                                                .padding(5)
                                                .frame(width: 40, height: 35)
                                                .background(day == toggledID ? Color(red: 224 / 255, green: 227 / 255, blue: 72 / 255) : Color(red: 107/255, green: 107/255, blue: 107/255))
                                                .foregroundColor(Color.black)
                                                .cornerRadius(10)
                                        }
                                    }
                                    Button(action: {}, label: {
                                        Image(systemName: "plus")
                                            .padding(5).frame(width: 40, height: 35)
                                        
                                            .background(Color(red: 107/255, green: 107/255, blue: 107/255))
                                            .foregroundColor(Color.black)
                                            .cornerRadius(10)
                                    })
                                }
                                
                            }
                            Spacer()
                            Image("map")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 85, height: 85)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 52/255.0, green: 51/255.0, blue: 50/255.0))
                                )
                        }
                        
                        .padding(.bottom)
                        VStack (spacing: 2){
                            LocationTile(locationName: "Parque de El Retiro", locationAddress: "Retiro, 28009 Madrid, Spain")
                            
                            LocationTile(locationName: "Parque de El Retiro", locationAddress: "Retiro, 28009 Madrid, Spain")
                            
                            
                        }
                        
                    }
                }
                Spacer()
                Button(action: authenticator.signOut) {
                    Text("Add Location")
                        .frame(maxWidth: .infinity) // Ensures the button stretches to the full width
                        .padding() // Provides padding inside the button
                        .foregroundColor(Color.white)
                        .background(Color.black) // Button's background color
                        .cornerRadius(10) // Rounds the corners of the button
                        .overlay(
                            RoundedRectangle(cornerRadius: 12) // Matches the cornerRadius of the button
                                .stroke(Color.white, lineWidth: 1) // Apply stroke border with color and line width
                        )
                }
                .padding(.horizontal) // Apply padding here to respect the view's padding
                .padding(.bottom)

                
            }
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}

struct LocationTile: View {
    let locationName: String
    let locationAddress: String
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 8) {
                Text(locationName)
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack(spacing: 10) {
                    Image(systemName: "mappin.circle")
                        .foregroundColor(.white)
                    
                    Text(locationAddress)
                        .font(.caption)
                }
            }
            .padding(.leading)
            Spacer()
            Image("madrid")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
        }
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.2)))
        
        .frame(height: 100)
    }
}


#Preview {
    ItineraryView()
        .preferredColorScheme(.dark)
        .environmentObject(Authenticator.shared)
}
