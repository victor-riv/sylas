//
//  ItineraryView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/31/24.
//

import SwiftUI

struct ItineraryView: View {
    @State private var toggledID: Int = 1
    @State private var isSticky: Bool = false
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        DestinationCardView()
                        ItinerariesHeader
                            .sticky(maxHeight: 400)
                        VStack (spacing: 2){
                            
                            ForEach(0...50, id: \.self) { _ in
                                LocationTile(locationName: "Parque de El Retiro", locationAddress: "Retiro, 28009 Madrid, Spain")
                            }
                        }
                    }
                }
                .coordinateSpace(name: "itineraryContainer")
                
                Spacer()
                Button(action: authenticator.signOut) {
                    Text("Add Location")
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
                .padding(.horizontal)
                .padding(.bottom)
                
                
            }
            Spacer()
        }
        .padding(.horizontal, 5)
    }
    
    @ViewBuilder var ItinerariesHeader: some View {
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
        .padding(.bottom, 20)
    }
}

struct Sticky: ViewModifier {
    @State var frame: CGRect = .zero
    var maxHeight: CGFloat
    
    var isSticking: Bool {
        frame.minY < 0
    }
    func body(content: Content) -> some View {
        content
            .background(isSticking ? Color.systemBackground : Color.clear)
            .offset(y: isSticking ? -frame.minY : 0)
            .zIndex(isSticking ? 1 : 0)
            .background(
                GeometryReader { proxy in
                    if isSticking {
                        Color.systemBackground
                            .frame(height: maxHeight + abs(frame.minY))
                            .offset(y: -maxHeight)
                    } else {
                        Color.clear
                    }
                }
            )
            .overlay(GeometryReader { proxy in
                let f = proxy.frame(in: .named("itineraryContainer"))
                Color.clear.onAppear{ frame = f}
                    .onChange(of: f) { frame = f }
            })
    }
}

extension View {
    func sticky(maxHeight: CGFloat) -> some View {
        modifier(Sticky(maxHeight: maxHeight))
    }
}

extension Color {
    static var systemBackground: Color {
        // Use different colors for light and dark mode if needed
        Color(UIColor.systemBackground)
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
