//
//  Workout.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

//import Foundation
import RealmSwift
import MapKit

class Workout: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String
    @Persisted var name: String
    @Persisted var warmupExercises: List<Exercise>
    @Persisted var cooldownExercise: List<Exercise>
    @Persisted var primaryExercises: List<Exercise>
    @Persisted var isTemplate: Bool
    @Persisted var isCompleted: Bool
    @Persisted var workoutDate: Date

    func setWorkoutDuration() -> Int {
        //TODO: Research on how to implement it
        return 0
    }

    func addWarmupExercise(exercise: Exercise) -> List<Exercise> {
        warmupExercises.append(exercise)
        return warmupExercises
    }

    func addCooldownExercise(exercise: Exercise) -> List<Exercise> {
        cooldownExercise.append(exercise)
        return cooldownExercise
    }

    func addPrimaryExercise(exercise: Exercise) -> List<Exercise> {
        primaryExercises.append(exercise)
        return primaryExercises
    }

    func removeWarmupExercise(exercise: Exercise) -> List<Exercise> {
        if let index = warmupExercises.index(of: exercise) {
            warmupExercises.remove(at: index)
        }
        return warmupExercises
    }

    func removeCooldownExercise(exercise: Exercise) -> List<Exercise> {
        if let index = cooldownExercise.index(of: exercise) {
            cooldownExercise.remove(at: index)
        }
        return cooldownExercise
    }

    func removePrimaryExercise(exercise: Exercise) -> List<Exercise> {
        if let index = primaryExercises.index(of: exercise) {
            primaryExercises.remove(at: index)
        }
        return primaryExercises
    }
}
