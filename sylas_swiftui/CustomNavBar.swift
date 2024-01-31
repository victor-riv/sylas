//
//  CustomNavBar.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import SwiftUI

struct CustomNavBar: View {
    var body: some View {
        HStack{
            HStack (spacing: 20) {
                Image("madrid")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack (alignment: .leading){
                    Text("Hello,")
                    Text("Victor Rivera")
                }
            }
            Spacer()
            HambugerIcon()
        }
    }
}

struct HambugerIcon: View {
    let lineWidth: CGFloat = 2
    let lineLength: CGFloat = 20
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Top line (half length)
            Rectangle()
                .frame(width: lineLength * 0.5, height: lineWidth)
            
            
            // Middle line (full length)
            Rectangle()
                .frame(width: lineLength, height: lineWidth)
            
            // Bottom line (second half)
            Rectangle()
                .frame(width: lineLength / 2, height: lineWidth)
                .offset(x: lineLength / 2)
            
        }
        .foregroundColor(.white)
    }
}

#Preview {
    CustomNavBar()
        .preferredColorScheme(.dark)
}
