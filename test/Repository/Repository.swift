////
////  Repository.swift
////  test
////
////  Created by Alireza on 2023-08-12.
////
//
//import Foundation
//import RealmSwift
//
//class Repository {
//
//    // MARK: Local Realm Part
//
//    static let shared = Repository()
//
//    //MARK: Creates a constant realm of type Realm
//    let realm: Realm
//
//    //MARK: Initializes an instance of Realm database and handling errors when accessing it
//    private init() {
//        print("[Repository] Trying to initialize Realm.")
//        do {
//            realm = try Realm()
//            print("[Repository] Successfully initialized Realm")
//            if let url = Realm.Configuration.defaultConfiguration.fileURL {
//                print("Realm file URL: \(url)")
//            }
//        } catch {
//            //            if let url = Realm.Configuration.defaultConfiguration.fileURL {
//            //                print("Realm file URL: \(url)")
//            //            }
//            fatalError("[Repository] Failed to initialize Realm: \(error)")
//        }
//    }
//
//    //    @MainActor
//    func configureRealmProfile() -> Realm.Configuration? {
//        print("[Repository] Configuring Realm Profile.")
//        guard let currentUser = realmApp.currentUser else {
//            print("No current user found")
//            return nil
//        }
//
//        let config = currentUser.flexibleSyncConfiguration(initialSubscriptions: { subs in
//            if subs.first(named: "profiles") == nil {
//                subs.append(QuerySubscription<Profile>(name: "profiles"))
//            }
//        })
//        return config
//    }
//
//
//    func setSubscriptions() throws {
//        print("[Repository] Setting up subscriptions.")
//        let realm = try Realm(configuration: configureRealmProfile()!)
//        let subscriptions = realm.subscriptions
//
//        func subscribeIfNeeded<Object: ObjectBase>(_ objectType: Object.Type, name: String) throws {
//            if subscriptions.first(named: name) == nil {
//                let querySubscription = QuerySubscription(name: name, where: "TRUEPREDICATE")
//                try realm.write {
//                    subscriptions.append(querySubscription)
//                }
//            }
//        }
//
//        try subscribeIfNeeded(Profile.self, name: "subscriptionProfile")
//        try subscribeIfNeeded(Exercise.self, name: "subscriptionExercise")
//        try subscribeIfNeeded(HeartRate.self, name: "subscriptionHeartRate")
//        try subscribeIfNeeded(Speed.self, name: "subscriptionSpeed")
//        try subscribeIfNeeded(Workout.self, name: "subscriptionWorkout")
//    }
//
//    func createProfile(profile: Profile) {
//        do {
//            try realm.write {
//                realm.add(profile)
//            }
//            print("[Repository] Successfully added profile to local realm.")
//        } catch {
//            print("[Repository] Error creating profile: \(error)")
//        }
//    }
//
//    func getProfileByEmail(email: String) -> Profile? {
//        let profiles = self.realm.objects(Profile.self)
//        let foundProfile = profiles.first(where: { $0.email == email })
//        print("[ProfileRepository] Profile with email \(email) \(foundProfile != nil ? "found" : "not found") in local realm.")
//        return foundProfile
//    }
//
//
//
//
//
//    //    func createProfile(profile: Profile) {
//    //        try! realm.write {
//    //            realm.add(profile)
//    //        }
//    //    }
//
////    func getProfileByEmail(email: String) -> Profile? {
////        var foundProfile: Profile? = nil
////
////        DispatchQueue.main.sync {
////            let profiles = self.realm.objects(Profile.self)
////            foundProfile = profiles.first(where: { $0.email == email })
////            print("[ProfileRepository] Profile with email \(email) \(foundProfile != nil ? "found" : "not found") in local realm.")
////        }
////
////        return foundProfile
////    }
//
//
//    // MARK: Device Syncing part
//
////        static let shared = Repository()
////
////        //MARK: Creates a constant realm of type Realm
////        var realm: Realm?
////
////        //MARK: Initializes an instance of Realm database and handling errors when accessing it
////        private init() {
////            print("[Repository] Trying to initialize Realm.")
////            Task{
////                do {
////                    self.realm = try await openFlexibleSyncRealm()
////                    print("[Repository] Successfully initialized Realm")
////                    if let url = Realm.Configuration.defaultConfiguration.fileURL {
////                        print("Realm file URL: \(url)")
////                    }
////                } catch {
////                    //            if let url = Realm.Configuration.defaultConfiguration.fileURL {
////                    //                print("Realm file URL: \(url)")
////                    //            }
////                    fatalError("[Repository] Failed to initialize Realm: \(error)")
////                }
////            }
////        }
////
////        //    @MainActor
////    //    func configureRealmProfile() -> Realm.Configuration? {
////    //        print("[Repository] Configuring Realm Profile.")
////    //        guard let currentUser = realmApp.currentUser else {
////    //            print("No current user found")
////    //            return nil
////    //        }
////    //
////    //        let config = currentUser.flexibleSyncConfiguration(initialSubscriptions: { subs in
////    //            if subs.first(named: "profiles") == nil {
////    //                subs.append(QuerySubscription<Profile>(name: "profiles"))
////    //            }
////    //        })
////    //        return config
////    //    }
////
////        func configureRealmProfile(for user: User) -> Realm.Configuration {
////                print("[Repository] Configuring Realm Profile.")
////
////            var config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
////                    //TODO: Set up initial subscriptions here:
////                    subs.append(QuerySubscription<Profile>(name: "subscriptionProfile", where: "TRUEPREDICATE"))
////                    subs.append(QuerySubscription<Exercise>(name: "subscriptionExercise", where: "TRUEPREDICATE"))
////                    subs.append(QuerySubscription<HeartRate>(name: "subscriptionHeartRate", where: "TRUEPREDICATE"))
////                    subs.append(QuerySubscription<Speed>(name: "subscriptionSpeed", where: "TRUEPREDICATE"))
////                    subs.append(QuerySubscription<Workout>(name: "subscriptionWorkout", where: "TRUEPREDICATE"))
////                })
////    11
////                // Specify object types
////                config.objectTypes = [Profile.self, MMR.self, Settings.self, Sleep.self, Health.self]
////
////                return config
////            }
////
////    //    func setSubscriptions() throws {
////    //        print("[Repository] Setting up subscriptions.")
////    //        let realm = try Realm(configuration: configureRealmProfile()!)
////    //        let subscriptions = realm.subscriptions
////    //
////    //        func subscribeIfNeeded<Object: ObjectBase>(_ objectType: Object.Type, name: String) throws {
////    //            if subscriptions.first(named: name) == nil {
////    //                let querySubscription = QuerySubscription(name: name, where: "TRUEPREDICATE")
////    //                try realm.write {
////    //                    subscriptions.append(querySubscription)
////    //                }
////    //            }
////    //        }
////    //
////    //        try subscribeIfNeeded(Profile.self, name: "subscriptionProfile")
////    //        try subscribeIfNeeded(Exercise.self, name: "subscriptionExercise")
////    //        try subscribeIfNeeded(HeartRate.self, name: "subscriptionHeartRate")
////    //        try subscribeIfNeeded(Speed.self, name: "subscriptionSpeed")
////    //        try subscribeIfNeeded(Workout.self, name: "subscriptionWorkout")
////    //    }
////
////    //    @MainActor
////    //    func openSyncedRealm(user: User) async {
////    //        do {
////    //            var config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
////    //                subs.append(
////    //                    QuerySubscription<Profile> {
////    //                        $0.profileId == user.id
////    //                    })
////    //            })
////    //            // Pass object types to the Flexible Sync configuration
////    //            // as a temporary workaround for not being able to add a
////    //            // complete schema for a Flexible Sync app.
////    //            config.objectTypes = [Profile.self]
////    //            let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
////    ////            useRealm(realm, user)
////    //        } catch {
////    //            print("Error opening realm: \(error.localizedDescription)")
////    //        }
////    //    }
////
////            // Opening a realm and accessing it must be done from the same thread.
////            // Marking this function as `@MainActor` avoids threading-related issues.
////            @MainActor
////            func openFlexibleSyncRealm() async throws -> Realm {
////                let app = App(id: "application-0-ingtn")
////                let email = "Test1@test.io"
////                let password = "12345678"
////                let user = try await app.login(credentials: Credentials.emailPassword(email: email, password: password))
////                let config = configureRealmProfile(for: user)
////
////                // Pass object types to the Flexible Sync configuration
////                // as a temporary workaround for not being able to add complete schema
////                // for a Flexible Sync app
////    //            config.objectTypes = [Profile.self, MMR.self, Settings.self, Sleep.self, Health.self]
////                let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
////                print("Successfully opened realm: \(realm)")
////                return realm
////            }
////
////    //    @MainActor
////    //    func useRealm(_ realm: Realm, _ user: User) {
////    //        // Add some tasks
////    //        let profile = Profile(name: "Do laundry", profileId: user.id)
////    //        try! realm.write {
////    //            realm.add(profile)
////    //        }
////    //    }
////
////        // Use this function to perform writes on the realm
////            @MainActor
////            func performRealmWrite(action: () -> Void) {
////                guard let realmInstance = realm else {
////                    print("Realm instance is not available!")
////                    return
////                }
////
////                try! realmInstance.write {
////                    action()
////                }
////            }
////
////
////
////
////
////
//    }
////
////
////
//
//
//



import Foundation
import RealmSwift

class Repository {
    
    // MARK: Local Realm Initialization
    
    static let shared = Repository()
    
    // This constant will help initialize and interact with the Realm database
    let realm: Realm
    
    private init() {
        print("FW-[Repository]-init: Trying to initialize Realm.")
        do {
            realm = try Realm()
            print("FW-[Repository]-init: Successfully initialized Realm")
            if let url = Realm.Configuration.defaultConfiguration.fileURL {
                print("FW-[Repository]-init: Realm file URL: \(url)")
            }
        } catch {
            fatalError("FW-[Repository]-init: Failed to initialize Realm: \(error)")
        }
    }
    
    func configureRealmProfile() -> Realm.Configuration? {
        print("FW-[Repository]-configureRealmProfile: Configuring Realm Profile.")
        guard let currentUser = realmApp.currentUser else {
            print("FW-[Repository]-configureRealmProfile: No current user found")
            return nil
        }

        let config = currentUser.flexibleSyncConfiguration(initialSubscriptions: { subs in
            if subs.first(named: "profiles") == nil {
                subs.append(QuerySubscription<Profile>(name: "profiles"))
            }
        })
        return config
    }
    
    func setSubscriptions() throws {
        print("FW-[Repository]-setSubscriptions: Setting up subscriptions.")
        guard let config = configureRealmProfile() else { return }
        
        let realmWithConfig = try Realm(configuration: config)
        let subscriptions = realmWithConfig.subscriptions

        func subscribeIfNeeded<Object: ObjectBase>(_ objectType: Object.Type, name: String) throws {
            if subscriptions.first(named: name) == nil {
                let querySubscription = QuerySubscription(name: name, where: "TRUEPREDICATE")
                try realmWithConfig.write {
                    subscriptions.append(querySubscription)
                }
            }
        }

        try subscribeIfNeeded(Profile.self, name: "subscriptionProfile")
        try subscribeIfNeeded(Exercise.self, name: "subscriptionExercise")
        try subscribeIfNeeded(HeartRate.self, name: "subscriptionHeartRate")
        try subscribeIfNeeded(Speed.self, name: "subscriptionSpeed")
        try subscribeIfNeeded(Workout.self, name: "subscriptionWorkout")
    }
    
    func createProfile(profile: Profile) {
        do {
            try realm.write {
                realm.add(profile)
            }
            print("FW-[Repository]-createProfile: Successfully added profile to local realm.")
        } catch {
            print("FW-[Repository]-createProfile: Error creating profile: \(error)")
        }
    }
    
    func getProfileByEmail(email: String) -> Profile? {
            let profiles = self.realm.objects(Profile.self)
            let foundProfile = profiles.first(where: { $0.email == email })
            print("[Repository] Profile with email \(email) \(foundProfile != nil ? "found" : "not found") in local realm.")
            return foundProfile
        }
}
