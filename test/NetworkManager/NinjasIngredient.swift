//
//  NinjasIngredient.swift
//  test
//
//  Created by david on 2023-08-15.
//

import Foundation

struct NinjasCalorieResults: Decodable {
    let items: [NinjasIngredient]
}

struct NinjasIngredient: Decodable, Identifiable, Equatable {
    var id: String {
        return randomString(16)
    }
    let name: String
    let calories: Float
    static func == (lhs: NinjasIngredient, rhs: NinjasIngredient) -> Bool {
        return lhs.id == rhs.id // Implement the equality check based on your requirements
    }}

struct IngredientWithQuntityViewModel: Decodable, Identifiable, Equatable {
    var id: String {
        return randomString(16)
    }
    var quantity: Int
    var calories: Float
    let name: String
    static func == (lhs: IngredientWithQuntityViewModel, rhs: IngredientWithQuntityViewModel) -> Bool {
        return lhs.id == rhs.id // Implement the equality check based on your requirements
    }}

func randomString(_ length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in letters.randomElement()! })
}
