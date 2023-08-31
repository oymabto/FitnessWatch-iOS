//
//  LocationViewModel.swift
//  GoogleMapAPI
//
//  Created by Alireza on 2023-08-11.
//

import Foundation
import CoreLocation

// Defines a class named LocationViewModel that conforms to the ObservableObject protocol.
// In SwiftUI, an ObservableObject is used to create an object that can be observed by views to automatically update the UI when its published properties change.
// The LocationViewModel class acts as an intermediary between the SwiftUI views and the actual location tracking logic encapsulated in the LocationManager class.
class LocationViewModel: ObservableObject {
    @Published var locationManager = LocationManager()

    // You can expose any data transformations or methods that the ContentView needs
    var speed: CLLocationSpeed {
        locationManager.speed
    }

    // Declares a computed property named speed of type CLLocationSpeed, which is a typealias for Double.
    // This property retrieves the speed property of the locationManager instance.
    var elevation: CLLocationDistance {
        locationManager.elevation
    }

    // Declares a computed property named elevation of type CLLocationDistance (also a typealias for Double).
    // It retrieves the elevation property of the locationManager instance.
    var totalDistance: CLLocationDistance {
        locationManager.totalDistance
    }

    // This computed property named startTime holds an optional Date value.
    // It retrieves the startTime property of the locationManager instance.
    // This property stores the timestamp when tracking starts, and it's optional because it will be nil until tracking begins.
    var startTime: Date? {
        locationManager.startTime
    }

    // Similar to startTime, this computed property named stopTime holds an optional Date value.
    // It retrieves the stopTime property of the locationManager instance.
    // This property stores the timestamp when tracking stops, and it's optional because it will be nil until tracking stops.
    var stopTime: Date? {
        locationManager.stopTime
    }

    // This method is responsible for initiating the tracking of location updates.
    // It calls the startTracking() method of the locationManager instance, which is defined in the LocationManager class.
    // This method starts delivering location updates from the device.
    func startTracking() {
        locationManager.startTracking()
    }
    
    // This method is responsible for stopping the tracking of location updates.
    // It calls the stopTracking() method of the locationManager instance, which stops delivering location updates.
    // Additionally, it sets the stopTime property to the timestamp of the last recorded location.
    func stopTracking() {
        locationManager.stopTracking()
    }
}

