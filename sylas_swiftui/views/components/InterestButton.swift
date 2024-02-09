//
//  MyButton.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/8/24.
//

import SwiftUI

struct InterestButton: View {
    @State var isSelected = false
    @EnvironmentObject var viewModel: ItineraryOnboardingData
    var interest: String
    
    var body: some View {
        Button(interest) {
            isSelected = !isSelected
            viewModel.handleInterestSelection(isSelected: isSelected, interest: interest)
        }
        .padding(10)
        .foregroundColor(Color.white)
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color(red: 224 / 255, green: 227 / 255, blue: 72 / 255) : .gray.opacity(0.7), lineWidth: 2) //
        )
        
        .onAppear {
            if viewModel.selectedInterests.contains(interest) {
                isSelected = true
            }
        }
    }
    
}

#Preview {
    InterestButton(interest: "Wakesurfing")
        .preferredColorScheme(.dark)
        .environmentObject(ItineraryOnboardingData())
}
