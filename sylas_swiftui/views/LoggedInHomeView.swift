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
    @State private var selectedViewType: ContentViewType = .explore
    
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
                        SidewaysScrollingButtonNavBar(selectedView: $selectedViewType)
                            .padding(.vertical, 20)
                        
                        dynamicContentView()
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
    
    @ViewBuilder
        private func dynamicContentView() -> some View {
            switch selectedViewType {
            case .explore:
                ExploreView(region: $region)
            case .mustSee:
                MustSeeView()
            case .makeATrip:
                MakeATripView()
            }
        }
}

// Define an enum for the different views
enum ContentViewType: String, CaseIterable {
    case explore = "Explore"
    case mustSee = "Must see"
    case makeATrip = "Make a trip"
//    case placesToEat = "Places to eat"
}

struct ExploreView: View {
    @Binding var region: Region?
    var body: some View {
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
    }
}

struct MustSeeView: View {
    var body: some View {
        Text("Must See")
            .font(.title)
    }
}

struct MakeATripView: View {
    var body: some View {
        Text("Trip making goes here")
    }
}



#Preview {
    LoggedInHomeView()
}
