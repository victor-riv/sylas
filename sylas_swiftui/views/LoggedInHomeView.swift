//
//  LoggedInHomeView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import SwiftUI
import MapKit

struct LoggedInHomeView: View {
    @State var region: Region?
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NewCustomNavBar()
                ScrollView {
                    VStack {
                        Image("madrid")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                        SidewaysScrollingButtonNavBar()
                            .padding(.vertical, 20)
                        HStack {
                            NavigationLink(destination: ItineraryMapView(region: $region)) {
                                ItineraryMapView(region: $region)
                            }
                             // Assuming MapView is a custom wrapper for Map
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .frame(maxWidth: 200)
                            
                            VStack(alignment: .leading) {
                                Image("meson")
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Today at")
                                            .font(.caption.weight(.semibold))
                                        Text("14:00")
                                            .font(.title2.weight(.bold))
                                    }
                                    Spacer()
                                    Button(action: {}) {
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.black)
                                            .frame(width: 5, height: 5)
                                            .padding()
                                            .background(Color.yellow)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                                .padding(.top, 2)
                                Text("in Meson del Boqueron")
                                    .font(.caption)
                            }
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                        }
                        //                    .background(Color.red)
                        .frame(height: 300)
                        .frame(maxWidth: .infinity) // Make the HStack fill the width
                        
                        Spacer()
                    }
                    .padding(.top, -20)
                    .padding(.horizontal)
                }
                Button(action: { authenticator.signOut() }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 254 / 255, green: 221 / 255, blue: 45 / 255))
                            .frame(height: 50)
                        
                        Text("Explore Madrid")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    LoggedInHomeView()
}
