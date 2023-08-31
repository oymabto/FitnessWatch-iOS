//
//  HeartRate.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import SwiftUI
import RealmSwift

class HeartRate: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String
    @Persisted var minHeartRate: Float
    @Persisted var maxHeartRate: Float
    @Persisted var averageHeartRate: Float
}
