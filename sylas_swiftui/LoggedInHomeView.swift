//
//  LoggedInHomeView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import SwiftUI

struct LoggedInHomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 40) {
                CustomNavBar()
                VStack(alignment: .leading, spacing: 10) { // Explicit alignment
                    Text("Let's Make")
                        .font(.largeTitle)
                    Text("Some Plans")
                        .font(.largeTitle)
                }
                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    LoggedInHomeView().preferredColorScheme(.dark)
}
