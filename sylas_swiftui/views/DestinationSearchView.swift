//
//  DestinationSearchView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/8/24.
//

import SwiftUI
import Combine

struct DestinationSearchView: View {
    @EnvironmentObject var viewModel: ItineraryOnboardingData
    @State private var isNavigationLinkActive = false
    private let debouncer = Debouncer(delay: 0.5)
    
    var body: some View {
        VStack(alignment: .leading){
            CustomNavBar()
                .padding(.horizontal)
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Where would you like to go?")
                    .font(.headline)
                    .padding(.bottom, 20)
                TextField("Enter a destination...", text: $viewModel.geoname)
                    .padding()
                    .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .onChange(of: viewModel.geoname) { oldValue, newValue in
                        debouncer.debounce {
                            Task {
                                await fetchCities(query: newValue)
                            }
                        }
                    }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.cityPredictions, id: \.id) { prediction in
                            HStack {
                                PredictedCityTile(cityName: prediction.name, secondaryText: "\(prediction.region), \(prediction.country), \(prediction.countryCode).").onTapGesture {
                                    viewModel.select(city: prediction)
                                    isNavigationLinkActive = true
                                }
                                Spacer()
                            }
                            .padding(.leading, 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                Spacer()
                // Use a hidden NavigationLink for programmatic navigation
                NavigationLink(destination: InterestsView().navigationBarHidden(true), isActive: $isNavigationLinkActive) {
                    EmptyView()
                }
                .padding(.top, 20)
                .padding()
            }
            .padding()
        }
        .navigationBarHidden(true) // Hide the navigation bar inherited from the parent view
    }
    
    @Sendable func fetchCities(query: String) async {
        guard !query.isEmpty else {
            viewModel.cityPredictions = []
            return
        }
        
        do {
            let fetchedCities = try await GeoDBCitiesAPI().fetchCities(matching: query)
            viewModel.cityPredictions = fetchedCities
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
    DestinationSearchView()
        .preferredColorScheme(.dark)
        .environmentObject(ItineraryOnboardingData())
}