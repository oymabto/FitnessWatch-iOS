//
//  CalorieBurner.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import RealmSwift

class CalorieBurner: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var caloriesToBurn: Int
    @Persisted var runningDuration: Int
    @Persisted var heartRate: Int
    
    func calculateCalories(runningDuration: Int, heartRate: Int) -> Int {
        // TODO: Implement the logic
        return 0
    }
    
    func calculateDuration(calorie: Int, heartRate: Int) -> Int {
        // TODO: Implement the logic
        return 0
    }
    
    func calculateHeartRate(calorie: Int, runningDuration: Int) -> Int {
        // TODO: Implement the logic
        return 0
    }
    
    func getAgeByProfileId() {
        // TODO: Implement the logic
    }
    
    func getWeightByProfileId() {
        // TODO: Implement the logic
    }
}
