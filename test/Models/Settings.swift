//
//  Settings.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import SwiftUI
import RealmSwift

enum DistanceUnit: String, PersistableEnum {
    case Km
    case mi
}

enum HeightUnit: String, PersistableEnum {
    case cm
    case m
    case ft
}

enum WeightUnit: String, PersistableEnum {
    case Kg
    case lbs
}

class Settings: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var distanceUnit: DistanceUnit = .Km
    @Persisted var heightUnit: HeightUnit = .cm
    @Persisted var weightUnit: WeightUnit = .Kg
}
