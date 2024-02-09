//
//  Interests.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/8/24.
//

import SwiftUI

struct InterestsView: View {
    @EnvironmentObject var viewModel: ItineraryOnboardingData
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading){
                Text("How do you want to spend your time?")
                    .font(.headline)
                    .padding(.bottom, 10)
                Text("Choose as many as you'd like.")
                    .font(.caption)
                    .padding(.bottom, 10)
                
                FlowLayout(mode: .scrollable,
                           binding: .constant(5),
                           items: viewModel.interests) {
                    
                    InterestButton(interest: $0)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 2)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
}
#Preview {
    InterestsView()
        .preferredColorScheme(.dark)
        .environmentObject(ItineraryOnboardingData())
}
