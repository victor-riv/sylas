//
//  LoggedInHomeView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import SwiftUI

struct LoggedInHomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                Text("hello")
                    .padding()
            }
            NewCustomNavBar()
        }
    }
}


#Preview {
    LoggedInHomeView()
}
