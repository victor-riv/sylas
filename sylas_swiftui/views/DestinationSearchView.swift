//
//  DestinationSearchView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/8/24.
//

import SwiftUI

struct DestinationSearchView: View {
    @Environment(ItineraryOnboardingData.self) private var viewModel
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
                
                ClearableTextField(text: viewModel.geoNameBinding, placeholder: "Enter a destination...")
                    .onChange(of: viewModel.geoname) { oldValue, newValue in
                        Task {
                            await viewModel.fetchCitiesDebounced(query: newValue)
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
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
                
                NavigationLink(destination: InterestsView().navigationBarHidden(true), isActive: $isNavigationLinkActive) {
                    EmptyView()
                }
                .padding(.top, 20)
                .padding()
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    DestinationSearchView()
        .preferredColorScheme(.dark)
        .environment(ItineraryOnboardingData())
}
