//
//  testApp.swift
//  test
//
//  Created by Alireza on 2023-08-11.
//

import SwiftUI
import RealmSwift
import GoogleMaps

let realmApp = RealmSwift.App(id: "application-0-ingtn")
//let realmApp = RealmSwift.App(id: "application-0-wghge")

@main
struct testApp: SwiftUI.App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject private var workoutViewModel = WorkoutViewModel()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(RealmViewModel(realmApp: realmApp))
//                .environmentObject(workoutViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            try GMSServices.provideAPIKey("AIzaSyDYeebTcKP2990o73l35kuwTnIMM-UB8jY")
        } catch let error {
            print("Error providing API key: \(error)")
        }
        return true
    }
}

