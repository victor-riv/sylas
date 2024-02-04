//
//  MapThumbnail.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/4/24.
//

import SwiftUI
import MapKit

struct MapThumbnail: View {
    let region: MKCoordinateRegion
    
    @State private var mapImage: UIImage?
    
    var body: some View {
        Group {
            if let image = mapImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Generating map snapshot...")
                    .onAppear(perform: generateSnapshot)
            }
        }
    }
    
    func generateSnapshot() {
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = CGSize(width: 85, height: 85)
        options.scale = UIScreen.main.scale
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print(error?.localizedDescription ?? "Error generating snapshot")
                return
            }
            
            DispatchQueue.main.async {
                self.mapImage = snapshot.image
            }
        }
    }
}

#Preview {
    MapThumbnail(region: MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    ))
    .preferredColorScheme(.dark)
}
