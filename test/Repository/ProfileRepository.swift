////
////  ProfileRepository.swift
////  test
////
////  Created by Alireza on 2023-08-13.
////
//
//import Foundation
//import RealmSwift
//
//class ProfileRepository {
//
//    //MARK: - Reference to Realm database
//    private let realm: Realm
//
//    //MARK: - Initialize with a provided Realm instance.
//    init(realm: Realm) {
//        self.realm = realm
//        print("[ProfileRepository] Initialized with Realm instance")
//    }
//
//    // MARK: - Create
////    func createProfile(profile: Profile) {
////        DispatchQueue.main.async {
////            do {
////                try self.realm.write {
////                    self.realm.add(profile)
////                    print("[ProfileRepository] Successfully added profile to local realm.")
////                }
////            } catch {
////                print("[ProfileRepository] Error creating profile: \(error)")
////            }
////        }
////    }
//
//    func createProfile(profile: Profile) {
//        do {
//            try realm.write {
//                realm.add(profile)
//            }
//            print("[ProfileRepository] Successfully added profile to local realm.")
//        } catch {
//            print("[ProfileRepository] Error creating profile: \(error)")
//        }
//    }
//
//
//    // MARK: - Read
//        func getProfileByEmail(email: String) -> Profile? {
//            var foundProfile: Profile? = nil
//
//            DispatchQueue.main.sync {
//                let profiles = self.realm.objects(Profile.self)
//                foundProfile = profiles.first(where: { $0.email == email })
//                print("[ProfileRepository] Profile with email \(email) \(foundProfile != nil ? "found" : "not found") in local realm.")
//            }
//
//            return foundProfile
//        }
//
//    func getProfile(email: String) -> Profile? {
//        let profiles = self.realm.objects(Profile.self)
//        let foundTheProfile = profiles.where{
//            $0.email == email
//        }
//        print("[ProfileRepository] \(foundTheProfile)")
//
//        return foundTheProfile.first
////        return realm.objects(Profile.self).filter("email == %@", email).first
//    }
//
//    // MARK: - Update By User
//    func updateProfileByUser(email: String, newProfile: Profile) {
////        DispatchQueue.main.async {
//            if let existingProfile = self.getProfile(email: email) {
//                do {
//                    try self.realm.write {
//                        existingProfile.name = newProfile.name
//                        existingProfile.email = newProfile.email
//                        self.realm.add(existingProfile, update: .modified)
//                        print("Regular user: Profile updated successfully!")
//                    }
//                } catch {
//                    print("Regular user: Error updating profile: \(error)")
//                }
//            } else {
//                print("Profile with email \(email) not found.")
//            }
////        }
//    }
//
//    func changeStatusByAdmin(email: String, newStatus: Bool) {
////        DispatchQueue.main.async {
//            if let profileToChange = self.getProfile(email: email) {
//                do {
//                    try self.realm.write {
//                        profileToChange.isEnabled = newStatus
//                        print("Status updated successfully for \(email). New status is \(newStatus)")
//                    }
//                } catch {
//                    print("Error updating profile status: \(error)")
//                }
//            } else {
//                print("Profile with email \(email) not found.")
//            }
////        }
//    }
//
//
//    // Delete method
//    func deleteProfile(profile: Profile) {
////        DispatchQueue.main.async {
//            do {
//                try self.realm.write {
//                    self.realm.delete(profile)
//                }
//            } catch {
//                print("Error deleting profile: \(error)")
//            }
////        }
//    }
//}
//// MARK: - Update By Admin
////    func updateProfileByAdmin(profile: Profile) {
////        do {
////            try realm.write {
////                realm.add(profile, update: .modified)
////            }
////            print("Admin: Profile updated successfully!")
////
////            // Debugging part
////            if let updatedProfile = getProfileByEmail(email: profile.email) {
////                print("Admin: Debugging Profile Details:")
////                print("Admin: Email: \(updatedProfile.email)")
////                print("Admin: Role: \(updatedProfile.userRole)")
////                print("Admin: IsEnabled: \(updatedProfile.isEnabled)")
////            } else {
////                print("Admin: Profile with email \(profile.email) not found after update.")
////            }
////        } catch {
////            print("Admin: Error updating profile: \(error)")
////        }
////    }
////}



import Foundation
import RealmSwift

class ProfileRepository {
    
    //MARK: - Reference to Realm database
    private let realm: Realm
    
    //MARK: - Initialize with a provided Realm instance.
    init(realm: Realm) {
        self.realm = realm
        print("[ProfileRepository] Initialized with Realm instance")
    }
    
    // MARK: - Create
    func createProfile(profile: Profile) {
        do {
            try realm.write {
                realm.add(profile)
                print("[ProfileRepository] Successfully added profile to local realm.")
            }
        } catch {
            print("[ProfileRepository] Error creating profile: \(error)")
        }
    }

    // MARK: - Read
    func getProfile(email: String) -> Profile? {
        let profile = realm.objects(Profile.self).filter("email == %@", email).first
        print("FW-[ProfileRepository]-getProfile: \(profile?.email ?? "no profile")")
        return profile
    }
    
    // MARK: - Read - Return Many
    func getProfilesByPartialMatch(email: String) -> Results<Profile> {
        let profiles = realm.objects(Profile.self).filter("userRole <> 'Admin' AND userRole <> 'MasterAdmin' AND email CONTAINS[c] %@", email)
        print("FW-[ProfileRepository]-getProfilesByPartialMatch: Profiles found == \(profiles.count)")
        return profiles
    }
    
    // MARK: - Update By User
    func updateProfileByUser(email: String, newProfile: Profile) {
        if let profileToUpdate = self.getProfile(email: email) {
            do {
                try self.realm.write {
                    print("FW-[ProfileRepository]-updateProfileByUser: New profile info: \(newProfile.description)")
                    print("FW-[ProfileRepository]-updateProfileByUser: Profile before: \(profileToUpdate.description)")
//                    let updatedProfile = existingProfile.copy() as! Profile
                    profileToUpdate.email = newProfile.email
                    profileToUpdate.name = newProfile.name
                    profileToUpdate.dateOfBirth = newProfile.dateOfBirth
                    profileToUpdate.gender = newProfile.gender
//                    profileToUpdate.height = newProfile.height
//                    profileToUpdate.weight = newProfile.weight
//                    realm.add(profileToUpdate, update: .modified)
                    print("FW-[ProfileRepository]-updateProfileByUser: Profile after : \(profileToUpdate.description)")
                    print("Regular user: Profile updated successfully!")
                }
            } catch {
                print("Regular user: Error updating profile: \(error)")
            }
        } else {
            print("Profile with email \(email) not found.")
        }
    }
    
    func updatePassword(email: String, newProfile: Profile, newPassword: String) {
        if let profileToUpdate = self.getProfile(email: email) {
//            let client = realmApp.emailPasswordAuth
//            let args: [AnyBSON] = []
//            let token = realmApp.currentUser?.accessToken
            do {
                //TODO: Get the reset done on the User (TBD)
//                try client.callResetPasswordFunction(email: email, password: newPassword, args: args)
                try self.realm.write {
                    profileToUpdate.password = newPassword
                }
            } catch {
                print("Regular user: Error updating profile: \(error)")
            }
//        } else {
//            print("Profile with email \(email) not found.")
//        }
        }
    }
        
    
    func changeStatusByAdmin(email: String, newStatus: Bool) {
        if let profileToChange = self.getProfile(email: email) {
            do {
                try self.realm.write {
                    profileToChange.isEnabled = newStatus
                    print("Status updated successfully for \(email). New status is \(newStatus)")
                }
            } catch {
                print("Error updating profile status: \(error)")
            }
        } else {
            print("Profile with email \(email) not found.")
        }
    }
    
    // MARK: - Pseudo-delete (update)
//    func markProfileForDeletion(email: String, newProfile: Profile) {
    func updateDeletedStatus(email: String, profile: Profile, status: Bool) {
        if let profileToChange = self.getProfile(email: email) {
            do {
                try self.realm.write {
                    profileToChange.isDeleted = status
                    print("FW-[ProfileRepository]-markProfileForDeletion: Profile 'deleted' successfully!")
                }
            } catch {
                print("FW-[ProfileRepository]-markProfileForDeletion: Error 'deleting' profile: \(error)")
            }
        } else {
            print("FW-[ProfileRepository]-markProfileForDeletion: Profile with email \(email) not found.")
        }
    }
    
    // MARK: - Delete
    // Delete method
    func deleteProfile(profile: Profile) {
        do {
            try self.realm.write {
                self.realm.delete(profile)
                print("[ProfileRepository] Profile deleted successfully.")
            }
        } catch {
            print("Error deleting profile: \(error)")
        }
    }
    
    func toggleProfileStatus(email: String) {
        if let profile = self.getProfile(email: email) {
            do {
                try self.realm.write {
                    profile.isEnabled.toggle()
                    print("Status toggled successfully for \(email). New status is \(profile.isEnabled)")
                }
            } catch {
                print("Error toggling profile status: \(error)")
            }
        } else {
            print("Profile with email \(email) not found.")
        }
    }
}
