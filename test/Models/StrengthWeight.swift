//
//  StrengthWeight.swift
//  test
//
//  Created by Alireza on 2023-08-15.
//

import Foundation
import RealmSwift

class StrengthWeight: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var weight: Float = 0.0
    @Persisted var reps: Int = 0
    @Persisted var sets: Int = 0
}
