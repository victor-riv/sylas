//
//  ItineraryMapView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/3/24.
//

import SwiftUI
import MapKit

struct ItineraryMapView: View {
    var region: MKCoordinateRegion
    
    @State private var route: MKRoute?
    
    var body: some View {
        NavigationView {
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
            .onAppear {
                getRoute()
            }
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



#Preview {
    ItineraryMapView(region: MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.416775, longitude: -3.703790),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
}


