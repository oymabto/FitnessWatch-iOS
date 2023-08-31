//
//  RunViewModel.swift
//  test
//
//  Created by Alireza on 2023-08-15.
//

import Foundation
import GoogleMaps
import Combine

class RunViewModel: ObservableObject {
    @Published var totalDistance: Double = 0.0
    @Published var elevation: Double = 0.0
    @Published var elapsedTime: TimeInterval = 0.0
    @Published var pathPoints: [CLLocationCoordinate2D] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var locationManager: LocationManager
    
    init(manager: LocationManager = LocationManager()) {
        self.locationManager = manager
        
        locationManager.$locations
            .map { locations in
                print("Received new location data in RunViewModel: \(locations)")
                return locations.map { $0.coordinate }
            }
            .assign(to: \.pathPoints, on: self)
            .store(in: &cancellables)
        
        
        locationManager.$totalDistance
            .sink(receiveValue: { distance in
                print("Updated distance in RunViewModel: \(distance)")
                self.totalDistance = distance
            })
            .store(in: &cancellables)
        
        locationManager.$elevation
            .sink(receiveValue: { elevation in
                print("Updated elevation in RunViewModel: \(elevation)")
                self.elevation = elevation
            })
            .store(in: &cancellables)
    }
    
    func startTracking() {
        print("Start Tracking method called in RunViewModel")
        locationManager.startTracking()
    }
    
    func stopTracking() {
        print("Stop Tracking method called in RunViewModel")
        locationManager.stopTracking()
    }
}

