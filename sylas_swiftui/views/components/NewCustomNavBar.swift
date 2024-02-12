//
//  NewCustomNavBar.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/12/24.
//

import SwiftUI

struct NewCustomNavBar: View {
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Madrid, ES")
                        .font(.largeTitle)
                    Spacer()
                    Image("madrid")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                ClearableTextField(text: .constant(""), placeholder: "Countries, regions or cities")
            }
        }
        .padding()
        .background(
                   RoundedRectangle(cornerRadius: 20) // Adjust corner radius as needed
                       .fill(Color.red)
                       .ignoresSafeArea(edges: .top)
               )
               .padding(.top, -20)
        
    }
}

//struct NewCustomNavBar: View {
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Madrid, ES")
//                    .font(.largeTitle)
//                Spacer()
//                Image("madrid")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 50, height: 50)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//            }
//            ClearableTextField(text: .constant("Meson El Boqueron"), placeholder: "Countries, regions or cities")
//        }
//        .padding() // Add padding to ensure content does not touch the edges
//        .background(.white)
//// Example background color, replace with your desired color
//        .clipShape(RoundedBottomRectangle(cornerRadius: 20)) // Custom shape with rounded bottom corners
//        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 2) // Adds a subtle shadow
//    }
//}

// Define a custom shape with rounded bottom corners
struct RoundedBottomRectangle: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height
        
        // Start at the top left
        path.move(to: CGPoint(x: 0, y: 0))
        // Draw a line to the top right
        path.addLine(to: CGPoint(x: width, y: 0))
        // Draw a line to the bottom right
        path.addLine(to: CGPoint(x: width, y: height))
        // Draw a line to the bottom left, with rounding
        path.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        // Bottom right corner
        path.addLine(to: CGPoint(x: cornerRadius, y: height))
        // Bottom left corner
        path.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        // Connect back to the top left
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        return path
    }
}

struct NewCustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NewCustomNavBar()
                Spacer()
        }
    }
}

