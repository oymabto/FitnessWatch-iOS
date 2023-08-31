////
////  CreateProfileView.swift
////  test
////
////  Created by Alireza on 2023-08-12.
////
//import SwiftUI
//import RealmSwift
//
//struct CreateProfileView: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var userEmail: String = ""
//    @State private var newUserEmail: String = ""
//    @State private var searchEmail: String = ""
//    @State private var deleteEmail: String = ""
//    @State private var updateEmail: String = ""
//    @State private var isUserExists: Bool = false
//    
//    @State private var profileToUpdate: Profile?
//    
//    @StateObject private var viewModel: RealmViewModel
//    
//    
//    
//    init(viewModel: RealmViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }
//    
//    var body: some View {
//        VStack {
//            // Create Profile Section
//            TextField("Username", text: $username)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            SecureField("Password", text: $password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            Button("Create Profile") {
//                viewModel.createProfile(username: username, password: password)
//                viewModel.insertProfileToSyncedRealm(email: username)
//            }
//            .padding()
//            
//            // Delete Profile Section
//            TextField("Delete User Email", text: $deleteEmail)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            Button("Delete User") {
//                viewModel.deleteProfile(email: deleteEmail)
//            }
//            .padding()
//            
//            // Update Profile Section
//            TextField("Update User Email", text: $updateEmail)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            Button("Find User") {
//                profileToUpdate = viewModel.getProfileByEmail(email: updateEmail)
//                isUserExists = profileToUpdate != nil
//            }
//            .padding()
//            
//            if isUserExists, let profile = profileToUpdate {
//                VStack {
//                    TextField("Update Email", text: Binding(
//                        get: { profile.email },
//                        set: { profile.email = $0 }
//                    ))
//                    SecureField("Update Password", text: Binding(
//                        get: { profile.password },
//                        set: { profile.password = $0 }
//                    ))
//                    //TODO: Add other fields of the profile
//                    Button("Update") {
//                        viewModel.updateProfile(profile: profile)
//                        isUserExists = false
//                    }
//                }
//                .padding()
//            }
//        }
//        .padding()
//    }
//}
//
//
//struct CreateProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateProfileView(viewModel: RealmViewModel(realmApp: realmApp))
//    }
//}
//
