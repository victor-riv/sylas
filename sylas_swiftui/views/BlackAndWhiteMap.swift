import SwiftUI
import MapKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct MapViewThumbnail: View {
    @State private var mapImage: UIImage? = nil

    let coordinate: CLLocationCoordinate2D
    var body: some View {
        Group {
            if let mapImage = mapImage {
                Button(action: {
                    print("Image tapped")
                }) {
                    Image(uiImage: mapImage)
                        .resizable()
                        .scaledToFit()
                }
            } else {
                Button(action: {
                    print("Placeholder tapped")
                }) {
                    Image("map")
                        .resizable()
                        .scaledToFit()
                }.onAppear {
                    generateSnapshot()
                }
            }
        }
    }

    func generateSnapshot() {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapSnapshotOptions.region = region
        mapSnapshotOptions.size = CGSize(width: 300, height: 300)
        mapSnapshotOptions.scale = UIScreen.main.scale

        let snapshotter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapshotter.start { snapshot, error in
            guard let snapshot = snapshot else {
                print("Snapshot error: \(error?.localizedDescription ?? "N/A")")
                return
            }
            let image = snapshot.image
            DispatchQueue.global(qos: .background).async {
                self.processImage(image) { processedImage in
                    DispatchQueue.main.async {
                        self.mapImage = processedImage
                    }
                }
            }
        }
    }

    func processImage(_ image: UIImage, completion: @escaping (UIImage?) -> Void) {
        guard let ciImage = CIImage(image: image) else {
            completion(nil)
            return
        }

        let context = CIContext()
        guard let noirFilter = CIFilter(name: "CIPhotoEffectNoir", parameters: [kCIInputImageKey: ciImage]),
              let noirImage = noirFilter.outputImage,
              let invertFilter = CIFilter(name: "CIColorInvert", parameters: [kCIInputImageKey: noirImage]),
              let finalImage = invertFilter.outputImage,
              let cgImage = context.createCGImage(finalImage, from: finalImage.extent) else {
            completion(nil)
            return
        }

        let processedImage = UIImage(cgImage: cgImage)
        completion(processedImage)
    }
}
