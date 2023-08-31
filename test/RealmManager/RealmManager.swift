////
////  RealmManager.swift
////  test
////
////  Created by Alireza on 2023-08-14.
////
//
//import Foundation
//import RealmSwift
//
//class RealmManager: ObservableObject {
//
//    let app: App
//
//    @Published var realm: Realm?
//    static let shared = RealmManager()
//    @Published var user: User?
//    @Published var configuration: Realm.Configuration?
//
//    private init() {
//        self.app = App(id: "application-0-ovehm")
//    }
//
//    @MainActor
//    func initialize() async throws {
//
//        // authentication
//
//        let email = "Alireza@test.io"
//        let password = "123456"
//        user = try await app.login(credentials: Credentials.emailPassword(email: email, password: password))
////        { (result) in
////            switch result {
////            case .failure(let error):
////                print("Login failed: \(error.localizedDescription)")
////            case .success(let user):
////                print("Successfully logged in as user \(user)")
////                // Now logged in, do something with user
////                // Remember to dispatch to main if you are doing anything on the UI thread
////            }
//        }
//
////        user = try await app.login(credentials: Credentials.anonymous)
//    @MainActor
//    func openSyncedRealm(user: User) async {
//        do {
//            var config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
//                subs.append(
//                    QuerySubscription<Profile> {
//                        $0.email == user.id
//                    })
//            })
//            // Pass object types to the Flexible Sync configuration
//            // as a temporary workaround for not being able to add a
//            // complete schema for a Flexible Sync app.
//            config.objectTypes = [Profile.self]
//            let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
//            useRealm(realm, user)
//        } catch {
//            print("Error opening realm: \(error.localizedDescription)")
//        }
//    }
//
//    @MainActor
//    func useRealm(_ realm: Realm, _ user: User) {
//        // Add some tasks
//        let profile = Profile(email: user.id, password: "")
//        try! realm.write {
//            realm.add(profile)
//        }
//    }
//
//    let realms = try await openFlexibleSyncRealm()
//
//    // Opening a realm and accessing it must be done from the same thread.
//    // Marking this function as `@MainActor` avoids threading-related issues.
//    @MainActor
//    func openFlexibleSyncRealm() async throws -> Realm {
//        let app = App(id: "application-0-ovehm")
//        let user = try await app.login(credentials: Credentials.anonymous)
//        var config = user.flexibleSyncConfiguration()
//        // Pass object types to the Flexible Sync configuration
//        // as a temporary workaround for not being able to add complete schema
//        // for a Flexible Sync app
//        config.objectTypes = [Profile.self]
//        let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
//        print("Successfully opened realm: \(realm)")
//        return realm
//    }
//
//    let realm = try await getRealmWithSingleSubscription()
//
//    // Opening a realm and accessing it must be done from the same thread.
//    // Marking this function as `@MainActor` avoids threading-related issues.
//    @MainActor
//    func getRealmWithSingleSubscription() async throws -> Realm {
//        let realm = try await Realm(configuration: flexSyncConfig)
//        let subscriptions = realm.subscriptions
//        try await subscriptions.update {
//           subscriptions.append(
//              QuerySubscription<Team> {
//                 $0.teamName == "Developer Education"
//              })
//        }
//        return realm
//    }
//
//
//    let realm = try await getRealmWithMultipleSubscriptions()
//
//    // Opening a realm and accessing it must be done from the same thread.
//    // Marking this function as `@MainActor` avoids threading-related issues.
//    @MainActor
//    func getRealmWithMultipleSubscriptions() async throws -> Realm {
//        let realm = try await Realm(configuration: flexSyncConfig)
//        let subscriptions = realm.subscriptions
//        try await subscriptions.update {
//            subscriptions.append(
//                QuerySubscription<Profile>(name: "profiles") {
//                     $0.completed == true
//            })
//            subscriptions.append(
//                QuerySubscription<Team> {
//                  $0.teamName == "Developer Education"
//            })
//        }
//        return realm
//    }
//
//
//    var flexSyncConfig = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
//        subs.append(
//            QuerySubscription<Team> {
//                   $0.teamName == "Developer Education"
//                })
//    })
//
//
//
//}
