//
//  Profile.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
//import SwiftUI
import RealmSwift

enum UserRole: String, PersistableEnum {
    case Regular
    case Admin
    case MasterAdmin
}

enum Gender: String, PersistableEnum {
    case Female
    case Male
}

class Profile: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var email: String
    @Persisted var password: String
    @Persisted var userRole = UserRole.Regular
    @Persisted var isEnabled: Bool = true
    @Persisted var isDeleted: Bool = false
    @Persisted var name: String?
    @Persisted var dateOfBirth: Date?
    @Persisted var gender = Gender.Female
    @Persisted var weight: Float?
    @Persisted var height: Float?
    @Persisted var targetExerciseHrsPerWk: Float?
    //TODO: find the reason to make some of the fields optional
    @Persisted var mmr: MMR?
    @Persisted var settings: Settings?
    @Persisted var sleepStats : RealmSwift.List<Sleep>
    @Persisted var healthStats: RealmSwift.List<Health>
    
    
//    override init() {
//            super.init()
//        }
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
    
    convenience init(email: String, name: String, dateOfBirth: Date, gender: Gender) {
        self.init()
        self.email = email
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.gender = gender
    }
    
    convenience init(email: String, name: String, dateOfBirth: Date, gender: Gender, weight: Float, height: Float) {
        self.init()
        self.email = email
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.weight = weight
        self.height = height
    }
    
    
    
    
//            func register(email: String, password: String, name: String, dateOfBirth: Date, weight: Float, height: Float, targetHoursExercisePerWeek: Float, role: UserRole) -> Profile {
//                //TODO: Implement the logic to register a profile. 😎😎😎
//            }
//
//            func login(email: String, password: String) -> Bool {
//                //TODO: Implement the logic to check email and password. 😎😎😎
//            }
//
//            func logout() -> Bool {
//                //TODO: Implement the logic to logout. 😎😎😎
//            }
//
//            func resetPassword(email: String, oldPassword: String, newPassword: String) -> Profile {
//                //TODO: Implement the logic to reset password. 😎😎😎
//            }
//
//            func updateInfo(name: String, dateOfBirth: Date, weight: Float, height: Float, targetHoursExercisePerWeek: Float) -> Profile {
//                //TODO: Implement the logic to update the profile information. 😎😎😎
//            }
    
    func deleteAccount() {
        //TODO: Implement the logic to delete account.
    }
    
    func getDietByProfileId() {
        //TODO: Implement the logic to get diet by profile id.
    }
    
    func getSleepByProfileId() {
        //TODO: Implement the logic to get sleep data by profile id.
    }
    
    func getHealthByProfileId() {
        //TODO: Implement the logic to get health data by profile id.
    }
    
    func getWorkoutByProfileId() {
        //TODO: Implement the logic to get workout data by profile id.
    }
    
    func calculateBMI() -> Float {
        guard let heightValue = height, heightValue != 0 else { return 0.0 }
        
        let bmi = (weight ?? 80) / pow(heightValue, 2)
        return bmi
    }

}

