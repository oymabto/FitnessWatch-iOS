//
//  ChartDataViewModel.swift
//  test
//
//  Created by Alireza on 2023-08-20.
//

import Foundation
import SwiftUI
import RealmSwift

class ChartDataViewModel {
    
    private var realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func printExerciseCountsByDate() {
        let workouts = realm.objects(Workout.self)
        print("Total Workouts: \(workouts.count)")
        var countsByDate: [Date: [ExerciseCategory: Int]] = [:]
        
        for workout in workouts {
            let date = workout.workoutDate
            print("Workout Date: \(date)")
            if countsByDate[date] == nil {
                countsByDate[date] = [
                    .cardio: 0,
                    .strength: 0,
                    .stretch: 0
                ]
            }
            
            for exerciseList in [workout.warmupExercises, workout.cooldownExercise, workout.primaryExercises] {
                for exercise in exerciseList {
                    if var countsForDate = countsByDate[date] {
                        countsForDate[exercise.category] = (countsForDate[exercise.category] ?? 0) + 1
                        countsByDate[date] = countsForDate
                    }
                }
            }
        }
        
        for (date, counts) in countsByDate {
            print("Date: \(date)")
            print("Cardio count: \(counts[.cardio] ?? 0)")
            print("Strength count: \(counts[.strength] ?? 0)")
            print("Stretch count: \(counts[.stretch] ?? 0)")
            print("-------------------------------")
        }
    }
    
    func getExerciseCountsByDate() -> [Date: [ExerciseCategory: Int]] {
        let workouts = realm.objects(Workout.self)
        var countsByDate: [Date: [ExerciseCategory: Int]] = [:]
        
        for workout in workouts {
            let date = workout.workoutDate
            if countsByDate[date] == nil {
                countsByDate[date] = [
                    .cardio: 0,
                    .strength: 0,
                    .stretch: 0
                ]
            }
            
            for exerciseList in [workout.warmupExercises, workout.cooldownExercise, workout.primaryExercises] {
                for exercise in exerciseList {
                    if var countsForDate = countsByDate[date] {
                        countsForDate[exercise.category] = (countsForDate[exercise.category] ?? 0) + 1
                        countsByDate[date] = countsForDate
                    }
                }
            }
        }
        
        return countsByDate
    }
}
