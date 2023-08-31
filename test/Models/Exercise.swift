//
//  Exercise.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

//import Foundation
//import SwiftUI
import RealmSwift
import MapKit

enum ExerciseCategory: String, PersistableEnum {
    case cardio
    case strength
    case stretch
}

enum WorkoutStageEnum: String, PersistableEnum {
    case Warmup
    case Primary
    case Cooldown
}

class Exercise: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var name: String = ""//
    @Persisted var category: ExerciseCategory = .cardio
    @Persisted var workoutStage: WorkoutStageEnum = .Primary
    @Persisted var startTime: String = "0:00"
    @Persisted var endTime: String = "0:00"
    @Persisted var duration: String = "0:00"//
    @Persisted var heartRate: HeartRate?//
    @Persisted var speed: Speed?//
    @Persisted var distance: Float = 0.0
    @Persisted var weight: Float = 0.0
    @Persisted var coordinates: List<Coordinate>
    @Persisted var elevationList: List<Float>
    @Persisted var elevation: Float = 0.0
    @Persisted var reps: Int = 0
    @Persisted var repsDuration: String = "0:00"
    @Persisted var sets: Int = 0
    @Persisted var burnedCalories: Float = 0.0
    @Persisted var strengthWeight: List<StrengthWeight>
    
    //TODO: Research on Date type in swift UI
    func start(startTime: String) -> String {
        self.startTime = startTime
        return self.startTime
    }
    
    //TODO: Research on Date type in swift UI
    func stop(endTime: String) -> String {
        self.endTime = endTime
        return self.endTime
    }
    
    func getDuration(startTime: String, endTime: String) -> Int {
        //TODO: Research on calculating the duration
        //TODO: Research on return type an dpossible use of long (to return miliseconds) instead of int (to reurn seconds)
        return 0
    }
    
    func calculateCalorieExpenditure() -> Float {
        //TODO: Research on calculating the calorie expenditure
        return 0
    }
}
