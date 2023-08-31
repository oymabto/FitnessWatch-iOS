//
//  Diet.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import RealmSwift

class Diet: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String
    @Persisted var date: Date
    @Persisted var calorie: Int
    @Persisted var foodImagePath: String
    @Persisted var foodDescription: String
    let ingredients = List<Ingredient>()
}
