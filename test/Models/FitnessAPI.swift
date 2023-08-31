//
//  Exercise.swift
//  FitnessAPI
//
//  Created by Alireza on 2023-08-14.
//

import Foundation

struct FitnessAPI: Identifiable, Decodable {
    var id: String
    var name: String
    var gifUrl: String
    var bodyPart: String
    var target: String
}



