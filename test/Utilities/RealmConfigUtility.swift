//
//  RealmConfigUtility.swift
//  test
//
//  Created by Alireza on 2023-08-13.
//

import Foundation
import RealmS

func configureRealmProfile() -> Realm.Configuration? {
    guard let user = app.currentUser else { return nil }
    
    let config = SyncUser.current?.configuration(partitionValue: "\(user.id)",
            objectTypes: [Profile.self, Exercise.self, HeartRate.self, Speed.self, Workout.self])
    return config
}
