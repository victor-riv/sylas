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
                    MyPlacesAPI().fetchCitySuggestions(query: newValue) { predictions in
                        itineraryOnboardingData.cityPredictions = predictions
                    }
                }
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(itineraryOnboardingData.cityPredictions, id: \.primaryText) { prediction in
                        PredictedCityTile(cityName: prediction.primaryText, secondaryText: prediction.secondaryText)
                    }
                }
            }
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
        .padding()
        .onAppear{
//            itineraryOnboardingData.cityPredictions = [PredictedCity(primaryText: "Kyoto", secondaryText: "Japan")]
            // This should run as user types
            //            MyPlacesAPI().fetchCitySuggestions(query: "Par"){ predictions in
            //                print("Got someeeee")
            //                itineraryOnboardingData.cityPredictions = predictions
        }
    }
}




#Preview {
    CreateItineraryView()
        .preferredColorScheme(.dark)
        .environmentObject(ItineraryOnboardingData())
}
