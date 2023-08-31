//
//  APIExerciseLearned.swift
//  FitnessAPI
//
//  Created by Alireza on 2023-08-15.
//

import Foundation
import RealmSwift

class APIExerciseLearned: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var gifUrl: String
    @Persisted var bodyPart: String
    @Persisted var target: String
    @Persisted var isFavorite: Bool = false
}
