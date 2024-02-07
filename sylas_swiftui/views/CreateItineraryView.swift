//
//  CreateItineraryView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/4/24.
//

import SwiftUI
import Combine


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
    private let debouncer = Debouncer(delay: 0.5)
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Where would you like to go?")
                .font(.headline)
                .padding(.bottom, 20)
            TextField("Enter a destination...", text: $itineraryOnboardingData.geoname)
                .padding()
                .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                .cornerRadius(12)
                .foregroundColor(.white)
                .onChange(of: itineraryOnboardingData.geoname) { oldValue, newValue in
                    debouncer.debounce {
                        Task {
                            await fetchCities(query: newValue)
                        }
                    }
                }
        }
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(itineraryOnboardingData.cityPredictions, id: \.id) { prediction in
                    PredictedCityTile(cityName: prediction.name, secondaryText: "\(prediction.region), \(prediction.country), \(prediction.countryCode).")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 30)
        Spacer()
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
    
    @Sendable func fetchCities(query: String) async {
        guard !query.isEmpty else {
            itineraryOnboardingData.cityPredictions = []
            return
        }
        
        do {
            let fetchedCities = try await GeoDBCitiesAPI().fetchCities(matching: query)
            
            itineraryOnboardingData.cityPredictions = fetchedCities
        } catch {
            print("Failed to fetch cities: \(error.localizedDescription)")
            
        }
    }
}

class Debouncer {
    private var cancellable: AnyCancellable?
    private let delay: TimeInterval
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func debounce(action: @escaping () -> Void) {
        cancellable?.cancel()
        cancellable = Just(())
            .delay(for: .seconds(delay), scheduler: RunLoop.main)
            .sink(receiveValue: { _ in
                action()
            })
    }
}





#Preview {
    CreateItineraryView()
        .preferredColorScheme(.dark)
        .environmentObject(ItineraryOnboardingData())
}
