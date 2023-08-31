//
//  ExerciseRepository.swift
//  test
//
//  Created by Alireza on 2023-08-13.
//

import Foundation
import RealmSwift

class ExerciseRepository {
    
    //MARK: - Reference to Realm database
    private let realm: Realm
    
    //MARK: - Initialize with a provided Realm instance.
    init(realm: Realm) {
        self.realm = realm
        print("[ProfileRepository] Initialized with Realm instance")
    }
    
    // MARK: - Create
    func createExercise(exercise: Exercise) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.add(exercise)
                    print("[ProfileRepository] Successfully added exercise to local realm.")
                }
            } catch {
                print("[ProfileRepository] Error creating exercise: \(error)")
            }
        }
    }
}
