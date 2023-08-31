//
//  Health.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import RealmSwift

class Health: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var restingHeartRate: Float = 0
    @Persisted var bloodPressureSystolic: Float = 0
    @Persisted var bloodPressureDiastolic: Float = 0
    @Persisted var weight: Float = 0
    @Persisted var logDate: Date = Date()
}
