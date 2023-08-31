//
//  Coordinate.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import SwiftUI
import RealmSwift
import MapKit

class Coordinate: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var time: Date
    @Persisted var latitude: Double = 0.0
    @Persisted var longitude: Double = 0.0
    @Persisted var elevation: Float = 0.0
    
    var gpsCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
}
