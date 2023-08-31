//
//  WorkoutRepository.swift
//  test
//
//  Created by Alireza on 2023-08-13.
//

import Foundation
import RealmSwift

class WorkoutRepository {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
        print("[WorkoutRepository] Initialized with Realm instance")
    }
    
    func fetchAllWorkouts() -> Results<Workout> {
        return realm.objects(Workout.self)
    }
    
    func fetchWorkoutsWithCardio() -> Results<Workout> {
        return realm.objects(Workout.self).filter("ANY warmupExercises.category == %@ OR ANY primaryExercises.category == %@ OR ANY cooldownExercise.category == %@", ExerciseCategory.cardio.rawValue, ExerciseCategory.cardio.rawValue, ExerciseCategory.cardio.rawValue)
    }
    
    func fetchCardioDistancesGroupedByDate() -> [(key: Date, value: Float)] {
            let workouts = realm.objects(Workout.self).sorted(byKeyPath: "workoutDate", ascending: true)
            
            var distancesByDate: [Date: Float] = [:]
            
            let groupedWorkouts = Dictionary(grouping: workouts, by: { $0.workoutDate })
            
            for (date, workoutsOnDate) in groupedWorkouts {
                var totalDistanceForDate: Float = 0.0
                
                for workout in workoutsOnDate {
                    totalDistanceForDate += sumCardioDistancesFromExercisesList(exercisesList: workout.warmupExercises)
                    totalDistanceForDate += sumCardioDistancesFromExercisesList(exercisesList: workout.cooldownExercise)
                    totalDistanceForDate += sumCardioDistancesFromExercisesList(exercisesList: workout.primaryExercises)
                }
                
                distancesByDate[date] = totalDistanceForDate
            }
            
            return distancesByDate.sorted { $0.key < $1.key }
        }
        
        private func sumCardioDistancesFromExercisesList(exercisesList: List<Exercise>) -> Float {
            return exercisesList.filter { $0.category == .cardio }.reduce(0) { $0 + $1.distance }
        }
}

