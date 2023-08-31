//
//  APIExerciseLearnedRepository.swift
//  FitnessAPI
//
//  Created by Alireza on 2023-08-15.
//

import Foundation
import RealmSwift

class APIExerciseLearnedRepository {

    private var realm: Realm

    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }

    // Create function
    func createExercise(_ exercise: FitnessAPI) {
        let learnedExercise = APIExerciseLearned()
        learnedExercise._id = exercise.id
        learnedExercise.name = exercise.name
        learnedExercise.gifUrl = exercise.gifUrl
        learnedExercise.bodyPart = exercise.bodyPart
        learnedExercise.target = exercise.target
        learnedExercise.isFavorite = true

        try! realm.write {
            realm.add(learnedExercise)
        }
    }

    // Delete function
    func deleteExercise(_ exercise: FitnessAPI) {
        if let learnedExercise = realm.object(ofType: APIExerciseLearned.self, forPrimaryKey: exercise.id) {
            try! realm.write {
                realm.delete(learnedExercise)
            }
        }
    }

    // Check if an exercise is already learned
    func isLearned(_ exercise: FitnessAPI) -> Bool {
        return realm.object(ofType: APIExerciseLearned.self, forPrimaryKey: exercise.id) != nil
    }
    
    func getAllLearnedExercises() -> [APIExerciseLearned] {
        return Array(realm.objects(APIExerciseLearned.self))
    }
}

