//
//  RealmViewModel.swift
//  test
//
//  Created by Alireza on 2023-08-12.
//

import SwiftUI
import RealmSwift

class RealmViewModel: ObservableObject {
    public var realmApp: RealmSwift.App
    @Published var currentUser: User?
    @Published var asyncOpenState: AsyncOpenState?
    @Published var userRole: UserRole = .Regular
    private var repository: Repository = Repository.shared
    @Published var currentProfile: Profile?
    
    init(realmApp: RealmSwift.App) {
        self.realmApp = realmApp
        self.currentUser = realmApp.currentUser
    }
    
    // Email/Password Authentication
    func loginWithEmail(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let credentials = Credentials.emailPassword(email: email, password: password)
        realmApp.login(credentials: credentials) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.currentUser = self.realmApp.currentUser
                    print("FW-[RealmViewModel]-loginWithEmail: CurrentUser == \(self.currentUser?.id ?? "?")")
                    
                    // Set the currentProfile based on the email
                    if let profile = self.checkUserType(email: email) {
                        self.currentProfile = profile
                    }
                    
                    completion(.success(()))
                    print("Successful authentication")
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    //Harsha: I think this should be called setUserRole and doesn't need to return anything
    //        Either that or return the userRole but rename to getUserRole or something.
    // Checking the user Type and returning the profile
    func checkUserType(email: String) -> Profile? {
        guard let profile = repository.getProfileByEmail(email: email) else {
            print("[RealmViewModel] No profile found for email: \(email)")
            return nil
        }
        self.userRole = profile.userRole
        return profile
    }
    
//    func logout() {
//        do {
//           try await currentUser.logOut()
//           // Other views are observing the app and will detect
//           // that the currentUser has changed. Nothing more to do here.
//       } catch {
//           print("Error logging out: \(error.localizedDescription)")
//       }
//    }
    
    func logoutV2() {
        currentUser?.logOut { (error) in
            // user is logged out or there was an error
            print("FW-[RealmViewModel]-logoutV2: CurrentUser == \(self.realmApp.currentUser?.id ?? "?")")
//            print("FW-[RealmViewModel]-logoutV2: Error logging out: \(error!.localizedDescription)")
        }
    }
}
