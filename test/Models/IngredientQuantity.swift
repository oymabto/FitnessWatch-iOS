//
//  IngredientQuantity.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import RealmSwift

class IngredientQuantity: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String
    @Persisted var ingredientId: String
    @Persisted var quantity: Int // Might be gram 🤔
}
