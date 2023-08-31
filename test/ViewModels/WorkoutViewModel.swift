//
//  WorkoutViewModel.swift
//  test
//
//  Created by Alireza on 2023-08-15.
//

import Foundation
import RealmSwift

class WorkoutViewModel: ObservableObject {
    // Fields from the form
    @Published var exerciseName: String = ""
    @Published var workoutName: String = ""
    @Published var workoutStage: WorkoutStage = .primary
    @Published var duration: String = ""
    @Published var repsDuration: String = ""
    @Published var exerciseType: ExerciseType = .none
    @Published var minHeartRate: String = ""
    @Published var maxHeartRate: String = ""
    @Published var avgHeartRate: String = ""
    @Published var minSpeed: String = ""
    @Published var maxSpeed: String = ""
    @Published var avgSpeed: String = ""
    @Published var distance: String = ""
    @Published var weight: String = ""
    @Published var reps: String = ""
    @Published var sets: String = ""
    @Published var elevation: String = ""
    @Published var isTemplate: Bool = false
    @Published var isCompleted: Bool = false
    
    // States that determine which type of exercise is active.
    @Published var isCardioActive: Bool = false
    @Published var isStrengthActive: Bool = false
    @Published var isStretchActive: Bool = false
    
    // Exercise lists
    @Published var warmupExercises: List<Exercise> = List<Exercise>()
    @Published var cooldownExercise: List<Exercise> = List<Exercise>()
    @Published var primaryExercises: List<Exercise> = List<Exercise>()
    
    // Realm instance
    private var realm: Realm
    
    init() {
        // Initialize the realm instance here. Handle any possible errors.
        self.realm = try! Realm()
    }
    
    func addNewExercise(exerciseName: String,
                        duration: String,
                        exerciseType: ExerciseType,
                        minHeartRate: String,
                        maxHeartRate: String,
                        avgHeartRate: String,
                        minSpeed: String,
                        maxSpeed: String,
                        avgSpeed: String,
                        distance: String,
                        weight: String,
                        reps: String,
                        sets: String,
                        elevation: String,
                        workoutStage: WorkoutStage) {
        
        let newExercise = Exercise()
        newExercise.name = exerciseName
        newExercise.duration = duration
        
        switch exerciseType {
        case .cardio:
            newExercise.category = .cardio
            
            let heartRateInstance = HeartRate()
            heartRateInstance.minHeartRate = Float(minHeartRate) ?? 0.0
            heartRateInstance.maxHeartRate = Float(maxHeartRate) ?? 0.0
            heartRateInstance.averageHeartRate = Float(avgHeartRate) ?? 0.0
            newExercise.heartRate = heartRateInstance
            
            let speedInstance = Speed()
            speedInstance.minSpeed = Float(minSpeed) ?? 0.0
            speedInstance.maxSpeed = Float(maxSpeed) ?? 0.0
            speedInstance.averageSpeed = Float(avgSpeed) ?? 0.0
            newExercise.speed = speedInstance
            
            newExercise.distance = Float(distance) ?? 0.0
            newExercise.elevation = Float(elevation) ?? 0.0
            newExercise.weight = Float(weight) ?? 0.0
            newExercise.reps = Int(reps) ?? 0
            newExercise.sets = Int(sets) ?? 0
            
        case .strength:
            newExercise.category = .strength
            newExercise.weight = Float(weight) ?? 0.0
            newExercise.reps = Int(reps) ?? 0
            newExercise.sets = Int(sets) ?? 0
            
        case .stretch:
            newExercise.category = .stretch
            newExercise.repsDuration = repsDuration
            newExercise.reps = Int(reps) ?? 0
            newExercise.sets = Int(sets) ?? 0
            
        default:
            break
        }
        
        switch WorkoutStage(rawValue: workoutStage.rawValue) ?? .warmup {
        case .warmup:
            warmupExercises.append(newExercise)
        case .cooldown:
            cooldownExercise.append(newExercise)
        case .primary:
            primaryExercises.append(newExercise)
        }
    }
    
    func saveAsTemplate(
        workoutName: String,
        warmupExercises: List<Exercise>,
        cooldownExercise: List<Exercise>,
        primaryExercises: List<Exercise>
    ) {
        let workout = Workout()
        workout.name = workoutName
        workout.isTemplate = true
        workout.warmupExercises = warmupExercises
        workout.cooldownExercise = cooldownExercise
        workout.primaryExercises = primaryExercises
        writeToRealm(workout)
    }
    
    func workoutCompleted(
        workoutName: String,
        warmupExercises: List<Exercise>,
        cooldownExercise: List<Exercise>,
        primaryExercises: List<Exercise>
    ) {
        let workout = Workout()
        workout.name = workoutName
        workout.isCompleted = true
        workout.warmupExercises = warmupExercises
        workout.cooldownExercise = cooldownExercise
        workout.primaryExercises = primaryExercises
        writeToRealm(workout)
    }
    
    private func writeToRealm(_ workout: Workout) {
        do {
            try realm.write {
                realm.add(workout)
            }
        } catch {
            // Handle error
            print("Error saving to Realm: \(error)")
        }
    }
}

extension WorkoutViewModel {
    func exerciseCountByType() -> [ExerciseCategory: Int] {
        var counts: [ExerciseCategory: Int] = [.cardio: 0, .strength: 0, .stretch: 0]

        let workouts = WorkoutRepository(realm: realm).fetchAllWorkouts()
        for workout in workouts {
            for exerciseList in [workout.warmupExercises, workout.cooldownExercise, workout.primaryExercises] {
                for exercise in exerciseList {
                    if let category = ExerciseCategory(rawValue: exercise.category.rawValue) {
                        counts[category, default: 0] += 1
                    }
                }
            }
        }

        return counts
    }

    func workoutDates() -> [Date] {
        let workouts = WorkoutRepository(realm: realm).fetchAllWorkouts()
        return workouts.map { $0.workoutDate }
    }
    
    func totalCardioDistancesForAllDates() -> [(date: Date, distance: Float)] {
        let dates = workoutDates()
        return dates.map { (date: $0, distance: totalCardioDistancePerDay(for: $0)) }
    }
    
    func totalCardioDistancePerDay(for date: Date) -> Float {
        let workoutsForTheDay = realm.objects(Workout.self).filter("workoutDate == %@", date)
        var totalDistance: Float = 0.0

        for workout in workoutsForTheDay {
            for exercise in workout.warmupExercises {
                if exercise.category == .cardio {
                    totalDistance += exercise.distance
                }
            }
            for exercise in workout.primaryExercises {
                if exercise.category == .cardio {
                    totalDistance += exercise.distance
                }
            }
            for exercise in workout.cooldownExercise {
                if exercise.category == .cardio {
                    totalDistance += exercise.distance
                }
            }
        }
        return totalDistance
    }
}
//extension WorkoutViewModel {
//
//    func cumulativeDistancesByDate() -> [Date: Float] {
//        let allWorkouts = WorkoutRepository(realm: realm).fetchAllWorkouts()
//        
//        var groupedDistances: [Date: Float] = [:]
//
//        for workout in allWorkouts {
//            let distanceForWorkout = WorkoutRepository(realm: realm).totalCardioDistancePerDay(for: workout.workoutDate)
//            
//            if let existingDistance = groupedDistances[workout.workoutDate] {
//                groupedDistances[workout.workoutDate] = existingDistance + distanceForWorkout
//            } else {
//                groupedDistances[workout.workoutDate] = distanceForWorkout
//            }
//        }
//        
//        return groupedDistances
//    }
//}



