//
//  ExerciseViewModel.swift
//  test
//
//  Created by Alireza on 2023-08-14.
//

import Foundation
import RealmSwift

class ExerciseViewModel: ObservableObject {
    private var exerciseRepository: ExerciseRepository?
    @Published var selectedExercise: Exercise?
    @Published var validationError: String?
    @Published var workoutsWithCardio: [Workout] = []
    
    init() {
        setupRepository()
    }
    
    func setupRepository() {
        print("[ExerciseViewModel] Setting up repository.")
        
        self.exerciseRepository = ExerciseRepository(realm: Repository.shared.realm)
        let workoutRepository = WorkoutRepository(realm: Repository.shared.realm)
        self.workoutsWithCardio = Array(workoutRepository.fetchWorkoutsWithCardio())
        
        
        //        if let realm = Repository.shared.realm {
        //            self.exerciseRepository = ExerciseRepository(realm: realm)
        //        }
        print("[ExerciseViewModel] Successfully initialized exerciseRepository")
    }
    
    //MARK: - Create Exercise
    func createExercise(exercise: Exercise) {
        print("[ExerciseViewModel] Attempting to create exercise.")
        if validate(exercise: exercise) {
            exerciseRepository?.createExercise(exercise: exercise)
        }
    }
    
    private func validate(exercise: Exercise) -> Bool {
        // TODO: Complete validation
        if exercise.name.isEmpty {
            validationError = "Exercise name cannot be empty."
            return false
        }
        // ... add other validations if needed
        return true
    }
}



