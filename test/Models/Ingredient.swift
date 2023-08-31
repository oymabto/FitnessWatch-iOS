//
//  Ingredient.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import RealmSwift

class Ingredient: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String
    @Persisted var name: String
    @Persisted var unit: String
    @Persisted var calories: Int
    @Persisted var ingredientQty: String
}
