////
////  ProfileViewModel.swift
////  test
////
////  Created by Alireza on 2023-08-12.
////
//
//import Foundation
//import RealmSwift
//
//class ProfileViewModel: ObservableObject {
//    private var profileRepository: ProfileRepository?
//    @Published var selectedProfile: Profile?
//    @Published var selectedTheProfile: Profile?
//    @Published var registrationSuccessful: Bool = false
//
//
//    init() {
//        setupRepository()
//    }
//
//    func setupRepository() {
//        print("[ProfileViewModel] Setting up repository.")
//
//        // MARK: local Realm
//        self.profileRepository = ProfileRepository(realm: Repository.shared.realm)
//
//        //MARK: Device Syncing part
////        if let realm = Repository.shared.realm {
////            self.profileRepository = ProfileRepository(realm: realm)
////        }
//        print("[ProfileViewModel] Successfully initialized profileRepository")
//    }
//
//    //MARK: - Create Profile
//    func createProfile(profile: Profile) {
//        print("[ProfileViewModel] Attempting to create profile.")
//        profileRepository?.createProfile(profile: profile)
//    }
//
//    func registerProfile(email: String, password: String, name: String?, dob: Date?, weight: Float?, height: Float?) {
//        print("[ProfileViewModel] Preparing to create a new profile with email: \(email)")
//
//        let newProfile = Profile()
//        newProfile.email = email
//        newProfile.password = password
//        newProfile.name = name
//        newProfile.dateOfBirth = dob
//        newProfile.weight = weight
//        newProfile.height = height
//        newProfile.userRole = .Regular
//
//        profileRepository?.createProfile(profile: newProfile)
//        print("[ProfileViewModel] Profile creation attempt completed.")
//    }
//
//    func refreshProfile(email: String) {
//        getProfile(email: email)
//    }
//
//
//
//    //MARK: - Update Profile by User
//    func updateProfile(email: String, newProfile: Profile) {
//        profileRepository?.updateProfileByUser(email: email, newProfile: newProfile)
//    }
//
//    //MARK: - Delete Profile
//    func deleteProfile(profile: Profile) {
//        profileRepository?.deleteProfile(profile: profile)
//    }
//
//    //MARK: - Get Profile by Email
//    func getProfileByEmail(email: String) {
//        selectedProfile = profileRepository?.getProfileByEmail(email: email)
//    }
//
//    func getProfile(email: String) {
//        print("[ProfileViewModel] Attempting to fetch the profile.")
//            if let profile = profileRepository?.getProfile(email: email) {
//                selectedProfile = profile
//            } else {
//                selectedProfile = nil
//            }
//    }
//
//    func convertToDate(day: String, month: String, year: String) -> Date? {
//            guard let dayInt = Int(day), let monthInt = Int(month), let yearInt = Int(year) else {
//                return nil
//            }
//
//            var components = DateComponents()
//            components.day = dayInt
//            components.month = monthInt
//            components.year = yearInt
//
//            return Calendar.current.date(from: components)
//        }
//
//
//    //    func createProfile(profile: Profile) {
//    //        print("[ProfileViewModel] Attempting to create profile.")
//    //        repository?.createProfile(profile: profile)
//    //    }
//
//
//
//    //    func registerProfile(email: String, password: String, name: String, dob: Date?, weight: Float?, height: Float?) {
//    //        // TODO: Replace this with actual registration logic.
//    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//    //            self.registrationSuccessful = true
//    //        }
//    //    }
//
//    // Change Status By Admin (Uncomment when needed)
//    //    func changeStatusByAdmin(email: String, newStatus: Bool) {
//    //        Task {
//    //            do {
//    //                try await ensureRepository().changeStatusByAdmin(email: email, newStatus: newStatus)
//    //            } catch {
//    //                print("ViewModel: Error changing profile status - \(error)")
//    //            }
//    //        }
//    //    }
//}



import Foundation
import RealmSwift

class ProfileViewModel: ObservableObject {
    private var profileRepository: ProfileRepository?
    @Published var selectedProfile: Profile?
    @Published var registrationSuccessful: Bool = false
    
    // Harsha
//    @Published var returnedListOfProfiles: Results<Profile>? // = How to initialize?
//    private let realm: Realm
    
    private var returnedProfile : Profile = Profile()
    
    init() {
        setupRepository()
    }
    
    private func setupRepository() {
        print("[ProfileViewModel] Setting up repository.")
        
        // Assuming Repository.shared.realm always provides a valid Realm object
        self.profileRepository = ProfileRepository(realm: Repository.shared.realm)
        print("[ProfileViewModel] Successfully initialized profileRepository")
    }
    
    // MARK: - Profile Creation
    func createProfile(profile: Profile) {
        print("[ProfileViewModel] Attempting to create profile.")
        profileRepository?.createProfile(profile: profile)
    }
    
    func registerProfile(role: UserRole, email: String, password: String, name: String?, dob: Date?, gender: Gender, weight: Float?, height: Float?) {
        print("[ProfileViewModel] Preparing to create a new profile with email: \(email)")
        
        let newProfile = Profile()
        newProfile.email = email
        newProfile.password = password
        newProfile.name = name
        newProfile.dateOfBirth = dob
        newProfile.gender = gender
        newProfile.weight = weight
        newProfile.height = height
        newProfile.userRole = role
        
        profileRepository?.createProfile(profile: newProfile)
        print("[ProfileViewModel] Profile creation attempt completed.")
    }
    
    func registerAdmin(role: UserRole, email: String, password: String, name: String?, dob: Date?, gender: Gender) {
        print("[ProfileViewModel] Preparing to create a new profile with email: \(email)")
        
        let newProfile = Profile()
        newProfile.userRole = role
        newProfile.email = email
        newProfile.password = password
        newProfile.name = name
        newProfile.dateOfBirth = dob
        newProfile.gender = gender
        
        profileRepository?.createProfile(profile: newProfile)
        print("[ProfileViewModel] Profile creation attempt completed.")
    }
    
    // When signing up with units selected
    func registerProfileWithUnits(role: UserRole, email: String, password: String, name: String?, dob: Date?, weight: Float?, weightUnit: WeightUnit, height: Float?, heightUnit: HeightUnit) {
        print("[ProfileViewModel] Preparing to create a new profile with email: \(email)")
        
        let newProfile = Profile()
        newProfile.email = email
        newProfile.password = password
        newProfile.name = name
        newProfile.dateOfBirth = dob
        newProfile.weight = weight
        newProfile.height = height
        newProfile.userRole = role
        let newSettings = Settings()
        newSettings.weightUnit = weightUnit
        newSettings.heightUnit = heightUnit
        newProfile.settings = newSettings
        
        profileRepository?.createProfile(profile: newProfile)
        print("[ProfileViewModel] Profile creation attempt completed.")
    }
    
    // MARK: - Profile Fetching
    func setProfile(byEmail email: String) {
        print("[ProfileViewModel] Attempting to fetch the profile with email: \(email)")
        if let profile = profileRepository?.getProfile(email: email) {
            selectedProfile = profile
            print("FW-[ProfileViewModel]-setProfile: Profile == " + profile.description)
        } else {
            selectedProfile = nil
        }
    }
    
    // MARK: - Profiles Fetching
    // Harsha: Ok to make this method async?
    //TODO: Make this return all emails matching what was typed
    func fetchProfilesByPartialMatch(byEmail email: String) -> Results<Profile> {
        print("FW-[ProfileViewModel]-fetchProfilesByPartialMatch: Attempting to fetch all matching profiles.")
//        if let profiles = profileRepository?.getProfilesByPartialMatch(email: email) {
//            profiles.forEach {
//                print("FW-[ProfileViewModel]-fetchProfilesByPartialMatch: Profile == ")
//                print(($0.name ?? "name") + " " + $0.email)
//            }
//        } else {
//            selectedProfile = nil
//        }
        return (profileRepository?.getProfilesByPartialMatch(email: email))!
        
        //Async approach:
//        let currentSearch = Task { () -> Profile in
//            let profile = profileRepository?.getProfile(email: email)!
//            return profile!
//        }
//
//        let result = await currentSearch.result
//
//        switch result {
//        case .success(let profile):
//            returnedProfile = profile
//        case .failure(let error):
//            returnedProfile = Profile()
//        }
    }
    
    // MARK: - Profile Update
    func updateProfile(email: String, with newProfileInfo: Profile) {
        profileRepository?.updateProfileByUser(email: email, newProfile: newProfileInfo)
    }
    
    func updatePassword(email: String, with newProfileInfo: Profile, newPassword: String) {
        profileRepository?.updatePassword(email: email, newProfile: newProfileInfo, newPassword: newPassword)
    }
    
    // MARK: - Profile Deletion (will not be used for now)
    func deleteProfile(_ profile: Profile) {
        profileRepository?.deleteProfile(profile: profile)
    }
    
    // MARK: - Pseudo Delete
    // Function to mark the profile's isDeleted to true
    func markProfileForDeletion(profile: Profile) {
        /*
         Harsha: Trying to update the profile's isDeleted state
         even within a do/try-catch block still isn't adequate.
         It creates a separate thread which realm doesn't like.
         */
//        do {
//            try Repository.shared.realm.write {
//                profile.isDeleted = true
//                print("Regular user: Profile updated successfully!")
//            }
//        } catch {
//            print("Regular user: Error updating profile: \(error)")
//        }
        profileRepository?.updateDeletedStatus(email: profile.email, profile: profile, status: true)
    }
    
    // Function to mark the profile's isDeleted to true
    func reactivateDeletedProfile(profile: Profile) {
        profileRepository?.updateDeletedStatus(email: profile.email, profile: profile, status: false)
    }
    
    // MARK: - Utilities
    func convertToDate(day: String, month: String, year: String) -> Date? {
        guard let dayInt = Int(day), let monthInt = Int(month), let yearInt = Int(year) else {
            return nil
        }
        
        var components = DateComponents()
        components.day = dayInt
        components.month = monthInt
        components.year = yearInt
        
        return Calendar.current.date(from: components)
    }
    
    func toggleProfileStatus(for profile: Profile) {
        guard let profileToUpdate = profileRepository?.getProfile(email: profile.email) else {
            print("Profile not found for email: \(profile.email)")
            return
        }
        let newStatus = !profileToUpdate.isEnabled
        profileRepository?.changeStatusByAdmin(email: profile.email, newStatus: newStatus)
    }
}
