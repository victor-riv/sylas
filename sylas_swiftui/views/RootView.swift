//
//  RootView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/3/24.
//

import SwiftUI

struct RootView: View {
    @StateObject var authenticator = Authenticator.shared
    var body: some View {
        Group {
            if authenticator.isAuthenticated {
                ItineraryView(geoname: "Madrid")
            } else {
                UnauthenticatedHomeView()
            }
        }
        .environmentObject(authenticator)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView()
}
