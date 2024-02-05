//
//  ItineraryMapView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/3/24.
//

import SwiftUI
import MapKit

struct ItineraryMapView: View {
    @Binding var region: Region?
    
    @State private var route: MKRoute?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                CustomNavBar()
                Map {
                    Annotation("El Retiro", coordinate: CLLocationCoordinate2D(latitude: 40.411335, longitude: -3.674908)) {
                        Image(systemName: "leaf.circle")
                            .frame(width: 40, height: 40)
                            
                            .foregroundColor(.black)
                            .background(Color(red: 224 / 255, green: 227 / 255, blue: 72 / 255))
                            .clipShape(Circle())
                    }
                    
                        
                    Annotation("Meson del Boqueron", coordinate: CLLocationCoordinate2D(latitude: 40.4104833, longitude: -3.7098438)){
                        Image(systemName: "fork.knife")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                            .background(Color(red: 224 / 255, green: 227 / 255, blue: 72 / 255))
                            .clipShape(Circle())
                    }
                    
                    if let route {
                        MapPolyline(route)
                            .stroke(.yellow, lineWidth: 5)
                    }
                }
                .frame(height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onAppear {
                    getRoute()
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Madrid Itinerary Route")
                        .font(.title3)
                        .foregroundColor(.black)
                    Text("from Feb 2-5, 2024")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.6))
                }
                .padding(10)
                
                .background(
                            RightRoundedRectangle(radius: 20)
                                .fill(Color(red: 224 / 255, green: 227 / 255, blue: 72 / 255))
                        )
                Spacer()
                
            }
            .padding(.horizontal, 5)
            
            
        }
    }
    
    func getRoute() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.411335, longitude: -3.674908)))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.4104833, longitude: -3.7098438)))
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
}

struct RightRoundedRectangle: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let r = min(radius, rect.height/2)
        let rect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - r, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - r, y: rect.minY + r), radius: r, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - r))
        path.addArc(center: CGPoint(x: rect.maxX - r, y: rect.maxY - r), radius: r, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}



//#Preview {
//    ItineraryMapView(region: MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 40.416775, longitude: -3.703790),
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    ))
//    .preferredColorScheme(.dark)
//}


