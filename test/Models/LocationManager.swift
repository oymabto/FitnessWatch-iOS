//
//  LocationManager.swift
//  GoogleMapAPI
//
//  Created by Alireza on 2023-08-11.
//

import CoreLocation

// Create a class that will manage the location services and provide data to the view.

// Starts the definition of the LocationManager class, which will manage the location-related functionalities.
// The NSObject is the base class for most Objective-C classes.
// In this context, we're inheriting from NSObject to allow our Swift class to be compatible with Objective-C APIs, such as those provided by Core Location.
// ObservableObject protocol is part of SwiftUI's data binding mechanism. It allows the class to send updates to SwiftUI views when its properties change, enabling automatic UI updates.
// CLLocationManagerDelegate protocol defines methods that receive location-related events from a CLLocationManager instance, which is a class provided by Core Location for managing location services.
// The LocationManager class encapsulates all the necessary properties to manage and store location-related data during tracking.
// It provides a structured way to handle location updates, calculate speed and elevation changes, and store the overall tracking information.
// By conforming to the ObservableObject protocol, it enables seamless integration with SwiftUI to update the user interface based on changes to these properties.
// The class essentially acts as a central point for managing and processing location-related data and events.

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    // Creates an instance of the CLLocationManager class. This instance will be responsible for managing location services and handling location-related events.
    let locationManager = CLLocationManager()
    
    // Defines a property named locations of type [CLLocation] and marks it with @Published.
    // The @Published property wrapper allows this property to be observed, so changes to it will automatically trigger UI updates in SwiftUI views.
    // This property will store the list of location updates received.
    @Published var locations: [CLLocation] = []
    
    // Defines a property named totalDistance of type CLLocationDistance (which is a typealias for Double).
    // This property will store the total distance traveled during the tracking session.
    @Published var totalDistance: CLLocationDistance = 0.0
    
    // Defines a property named speed of type CLLocationSpeed (which is a typealias for Double).
    // This property will store the current speed based on the most recent location updates.
    @Published var speed: CLLocationSpeed = 0.0
    
    // Defines a property named elevation of type CLLocationDistance (which is a typealias for Double).
    // This property will store the current elevation (altitude) based on the most recent location updates.
    @Published var elevation: CLLocationDistance = 0.0
    
    // Defines a property named startTime of type Date? (optional Date).
    // This property will store the timestamp when tracking starts.
    // It's an optional because it will be set to nil until tracking begins.
    @Published var startTime: Date?
    
    // Defines a property named stopTime of type Date? (optional Date).
    // This property will store the timestamp when tracking stops.
    // It's an optional because it will be set to nil until tracking stops.
    @Published var stopTime: Date?
    
    var shouldStopSimulating: Bool = false
    
    // Marks the beginning of the init() method, which is an initializer for the LocationManager class.
    // The override keyword indicates that we're overriding the designated initializer of the superclass (NSObject in this case).
    override init() {
        
        // Calls the designated initializer of the superclass (NSObject), ensuring that any initialization performed by the superclass is completed before we continue with our custom initialization.
        super.init()
        
        // Calls the setupLocationManager() method that we're about to define.
        setupLocationManager()
    }
    
    // Initializes the locationManager instance with the necessary settings.
    func setupLocationManager() {
        
        // Assigns self (the current instance of LocationManager) as the delegate of the locationManager instance.
        // This means that the LocationManager class will handle location-related events sent by the locationManager.
        locationManager.delegate = self
        
        // Requests permission from the user to access their location when the app is in use.
        // It presents a system-level permission dialog to the user.
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("[LocationManager] Location services are enabled.")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            print("[LocationManager] Started updating location.")
        } else {
            print("[LocationManager] Location services are NOT enabled.")
        }
        // Starts the process of receiving location updates from the device.
        // The locationManager will periodically deliver location updates to the delegate (which is self in this case).
        //        locationManager.startUpdatingLocation()
        
        // Sets the desired accuracy for location updates.
        // kCLLocationAccuracyBest is a predefined constant that indicates the highest level of accuracy available from location services.
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // This is the delegate method that gets called whenever the locationManager receives new location updates.
    // It receives an array of CLLocation objects representing the latest location data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("[LocationManager] Received locations: \(locations)")
        // Uses a guard statement to safely unwrap the last location in the locations array.
        // If there are no locations in the array, the guard statement exits the method early with the return statement.
        guard let location = locations.last else { return }
        
        // Checks if there's a previous location stored in the locations array.
        // If there is, the code inside this block calculates various metrics based on the previous and current locations.
        if let previousLocation = self.locations.last {
            
            // Calculates the distance between the current location and the previous location using the distance(from:) method provided by the CLLocation class.
            let distance = location.distance(from: previousLocation)
            
            // Updates the totalDistance property by adding the newly calculated distance value.
            totalDistance += distance
            
            // Calculates the time interval between the current location's timestamp and the previous location's timestamp.
            // This time interval is used to calculate the speed.
            let timeInterval = location.timestamp.timeIntervalSince(previousLocation.timestamp)
            
            // Calculates the speed by dividing the calculated distance by the calculated timeInterval.
            speed = distance / timeInterval
            
            // Sets the elevation property to the altitude of the current location.
            elevation = location.altitude
        }
        
        // Checks if the startTime property is not set.
        // If it's not set (meaning this is the first location update), the code inside this block sets the startTime to the timestamp of the current location.
        if startTime == nil {
            startTime = location.timestamp
        }
        // Adds the current location to the locations array, storing it for future reference.
        self.locations.append(location)
    }
    
    // This function is responsible for starting the tracking of location updates.
    // It calls the startUpdatingLocation() method on the locationManager instance.
    // When this method is called, the CLLocationManager starts delivering location updates to its delegate, which is the LocationManager class.
    func startTracking() {
        print("Start Tracking method called in LocationManager")
        let status = CLLocationManager.authorizationStatus()
        print("Location Authorization Status: \(status.rawValue)")
        locationManager.startUpdatingLocation()
        print("[LocationManager] Started updating location.")
    }
    // This function is responsible for stopping the tracking of location updates.
    // It calls the stopUpdatingLocation() method on the locationManager instance.
    // This method tells the CLLocationManager to stop delivering location updates to its delegate.
    // After stopping the location updates, it also assigns the timestamp of the last location in the locations array to the stopTime property.
    func stopTracking() {
        print("Stop Tracking method called in LocationManager")
        locationManager.stopUpdatingLocation()
        stopTime = locations.last?.timestamp
    }
    
    // This is a computed property which doesn't store a value itself but calculates and returns the initial location (latitude and longitude) to center the map when it's first displayed.
    var initialLocation: CLLocationCoordinate2D {
        
        return locations.first?.coordinate ?? CLLocationCoordinate2D(latitude: 45.508888, longitude: -73.561668)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[LocationManager] Error updating location: \(error.localizedDescription)")
        //TODO: handle errors
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("[LocationManager] Authorization status changed to: \(status.rawValue)")
        //TODO: handle authorization changes
    }
    
    
    
    
    
    var mockLocations: [CLLocation] = [
        CLLocation(latitude: 45.508888, longitude: -73.561668),
        CLLocation(latitude: 45.509988, longitude: -73.561568),
        CLLocation(latitude: 45.510788, longitude: -73.561468),
        CLLocation(latitude: 45.511288, longitude: -73.560968),
        CLLocation(latitude: 45.512388, longitude: -73.560268),
        CLLocation(latitude: 45.512988, longitude: -73.559668),
        CLLocation(latitude: 45.513588, longitude: -73.559068),
        CLLocation(latitude: 45.514188, longitude: -73.558468),
        CLLocation(latitude: 45.514788, longitude: -73.557868),
        CLLocation(latitude: 45.515388, longitude: -73.557268),
        CLLocation(latitude: 45.515988, longitude: -73.556668),
        CLLocation(latitude: 45.516588, longitude: -73.556068),
        CLLocation(latitude: 45.517188, longitude: -73.555468),
        CLLocation(latitude: 45.517788, longitude: -73.554868),
        CLLocation(latitude: 45.518388, longitude: -73.554268),
        CLLocation(latitude: 45.518988, longitude: -73.553668),
        CLLocation(latitude: 45.519588, longitude: -73.553068),
        CLLocation(latitude: 45.520188, longitude: -73.552468),
        CLLocation(latitude: 45.520788, longitude: -73.551868),
        CLLocation(latitude: 45.521388, longitude: -73.551268),
        CLLocation(latitude: 45.521988, longitude: -73.550668),
        CLLocation(latitude: 45.522588, longitude: -73.550068),
        CLLocation(latitude: 45.523188, longitude: -73.549468),
        CLLocation(latitude: 45.523788, longitude: -73.548868),
        CLLocation(latitude: 45.524388, longitude: -73.548268),
        CLLocation(latitude: 45.524988, longitude: -73.547668),
        CLLocation(latitude: 45.525588, longitude: -73.547068),
        CLLocation(latitude: 45.526188, longitude: -73.546468),
        CLLocation(latitude: 45.526788, longitude: -73.545868),
        CLLocation(latitude: 45.527388, longitude: -73.545268),
    ]
    
    
    //TODO: Erase the following function after testing
    
    func simulateLocations() {
        var delay = 0.0
        for location in mockLocations {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.processNew(location: location)
            }
            delay += 1.0
        }
    }
    
    private func processNew(location: CLLocation) {
        if let previousLocation = self.locations.last {
            let distance = location.distance(from: previousLocation)
            totalDistance += distance
            let timeInterval = location.timestamp.timeIntervalSince(previousLocation.timestamp)
            speed = distance / timeInterval
            elevation = location.altitude
        }
        if startTime == nil {
            startTime = location.timestamp
        }
        self.locations.append(location)
        print("Updated location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
}
