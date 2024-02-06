//
//  MapThumbnail.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/4/24.
//

import SwiftUI
import MapKit

struct MapThumbnail: View {
    @Binding var region: Region?
    
    @State private var mapImage: UIImage?
    
    var body: some View {
        Group {
            if let image = mapImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                // Really only needed to make the preview work.
//                    .onAppear {
//                        generateSnapshot()
//                    }
            }
        }
        .onChange(of: region) {
            generateSnapshot()
        }
    }
    
    func generateSnapshot() {
        guard let region = region else {
            print("Region is nil")
            return
        }
        
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: region.lat, longitude: region.lon),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        options.size = CGSize(width: 85, height: 85)
        options.scale = UIScreen.main.scale
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if let error = error {
                print("Snapshot error: \(error.localizedDescription)")
                // Handle error - e.g., set a default image or update UI to show the error
                DispatchQueue.main.async {
                    self.mapImage = UIImage(named: "defaultImage")
                }
                return
            }
            
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    self.mapImage = snapshot.image
                }
            }
        }
    }

}

#Preview {
    MapThumbnail(region: .constant(Region(name: "Madrid", country: "ES", lat: 40.416775, lon: -3.703790, population: 3165000, timezone: "Europe/Madrid", status: "OK")))
    .preferredColorScheme(.dark)
}
