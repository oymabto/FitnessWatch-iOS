//
//  ContactUsView.swift
//  test
//
//  Created by Devin Oxman on 2023-08-20.
//

import SwiftUI
import CoreLocation

struct ContactUsView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var runViewModel = RunViewModel()
    @State var timeToHQ = 0.0
    
    let fitnessWatchHQ: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 45.404605, longitude: -73.942753)
        ]

    var timeToHQQ = distancFromHQ()

    var body: some View {
        VStack {
            Text("Contact Us")
                .font(.title)
                .fontWeight(.bold)
            GoogleMapView(initialLocation: CLLocationCoordinate2D(latitude: 45.404605, longitude: -73.942753), markers: fitnessWatchHQ, viewModel: runViewModel)
                .edgesIgnoringSafeArea(.all)
                .frame(height: UIScreen.main.bounds.height * 5/12)
            Text("A run to our HQ will take \(String(Int(timeToHQQ)))h:\(String(Int((timeToHQQ - Float(Int(timeToHQQ))) * 60)))m")
            }
            HStack {
                Link(destination: URL(string: "mailto:admin@fitnesswatch.io")!) {
                    VStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                        Text("Email us!")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }

                Link(destination: URL(string: "tel:3069990751")!) {
                    VStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.white)
                        Text("Call us!")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                }
            }
        }
    }
    func distancFromHQ() -> Float {
        let currentLocation = CLLocation(latitude: 45.508888, longitude: -73.561668)
        
        let fitnessWatchHQLocation = CLLocation(latitude: 45.404605, longitude: -73.942753)
        
        let distance = currentLocation.distance(from: fitnessWatchHQLocation)
        
        return Float(distance / 15000)
    }


//func distancFromHQ() {
//    let currentLocation = CLLocation(latitude: 45.508888, longitude: -73.561668)
//
//    let fitnessWatchHQLocation = CLLocation(latitude: 45.404605, longitude: -73.942753)
//
//    let distance = currentLocation.distance(from: fitnessWatchHQLocation)
//
//    let timeToHQ = distance / 15000
//}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
