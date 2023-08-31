//
//  Speed.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import SwiftUI
import RealmSwift

class Speed: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var minSpeed: Float = 0.0
    @Persisted var maxSpeed: Float = 0.0
    @Persisted var averageSpeed: Float = 0.0
}
