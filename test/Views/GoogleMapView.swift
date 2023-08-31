//
//  GoogleMapView.swift
//  GoogleMapAPI
//
//  Created by Alireza on 2023-08-11.
//

import SwiftUI
import GoogleMaps

// This structure represents a view that integrates the Google Maps SDK within a SwiftUI view hierarchy.
// It conforms to the UIViewRepresentable protocol, which is used to wrap UIKit views so that they can be used within SwiftUI's declarative syntax.
struct GoogleMapView: UIViewRepresentable {
    var initialLocation: CLLocationCoordinate2D?
    var markers: [CLLocationCoordinate2D]?
    // This line creates an instance of the LocationManager class, marked with the @ObservedObject property wrapper.
    // This means that changes to the properties of locationManager will trigger UI updates in the SwiftUI view.
    @ObservedObject var viewModel: RunViewModel
    //    @Binding var pathPoints: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition(
            latitude: initialLocation?.latitude ?? viewModel.pathPoints.first?.latitude ?? 45.508888,
            longitude: initialLocation?.longitude ?? viewModel.pathPoints.first?.longitude ?? -73.561668,
            zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Clear all overlays from the map
        uiView.clear()
        
        // Create a path and add all coordinates
        let path = GMSMutablePath()
        for point in viewModel.pathPoints {
            path.add(point)
        }
        
        if let customMarkers = markers {
            for markerCoord in customMarkers {
                let marker = GMSMarker(position: markerCoord)
                marker.title = "FitnessWatch Headquarters"
                marker.icon = GMSMarker.markerImage(with: .blue)
                marker.map = uiView
            }
        }
        
        // Create a polyline and add it to the map
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 10
        polyline.strokeColor = .blue
        polyline.map = uiView
    }
}
