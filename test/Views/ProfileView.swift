//
//  ProfileView.swift
//  test
//
//  Created by Alireza on 2023-08-13.
//

import SwiftUI
import RealmSwift

struct ProfileView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var dob: Date = Date()
    @State private var cellphone: String = ""
    @State private var genderOptions = Gender.allCases.map { $0.rawValue }
    @State private var gender: String = Gender.Female.rawValue
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var heightUnit: String = ""
    @State private var weightUnit: String = ""
    @State private var statusMessage: String = ""
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    @StateObject private var profileViewModel = ProfileViewModel()
    
//    @EnvironmentObject var realmViewModel: RealmViewModel
//    @ObservedObject var realmViewModel: RealmViewModel
    @EnvironmentObject private var realmViewModel: RealmViewModel
    @State private var showAlert: Bool = false
    @State private var profileToUpdate: Profile?
//    private var newProfileInfo: Profile
    @State private var shouldNavigateToLogin: Bool = false
    @State private var shouldNavigateToHome: Bool = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Title
//            Text("Profile")
                
            
            // Avatar
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            
            // Display Profile Name and Email
            Text(name)
                .font(.title2)
            
            Text(email)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            let labelEmail = Text("Email:")
                .font(.headline)
                .foregroundColor(.red)
            let labelName = Text("Name:")
                .font(.headline)
                .foregroundColor(.red)
            
            // Editable Profile Fields
            VStack(spacing: 15) {
                // name
                HStack {
                    Image(systemName: "person.circle.fill")
//                    labelName
                    TextField("Name", text: $name)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
//                // Cellphone
//                HStack {
//                    Image(systemName: "phone.fill")
//                    TextField("Cellphone", text: $cellphone)
//                }
//                .padding(.horizontal)
//                .padding(.vertical, 10)
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(10)
                
                // Date of Birth
                HStack {
                    Image(systemName: "calendar")
                    DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
                        .labelsHidden()
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Gender
                HStack {
                    Image(systemName: "person.fill")
                    Picker("Select Gender", selection: $gender) {
                        ForEach(genderOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                
                // Weight
                HStack {
                    Image(systemName: "scalemass.fill")
                    TextField("Weight", text: $weight)
                    Text(profileToUpdate?.settings?.weightUnit.rawValue ?? "?")
                        .frame(maxWidth: 20)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Height
                HStack {
                    Image(systemName: "ruler.fill")
                    TextField("Height", text: $height)
                    Text(profileToUpdate?.settings?.heightUnit.rawValue ?? "?")
                        .frame(maxWidth: 20)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            
            // Update Button
            Button("Update") {
                // Handle saving to database
//                profileViewModel.setProfile(byEmail: email)
//                profileToUpdate = profileViewModel.selectedProfile
                print("FW-[ProfileView]-Update button action: Profile == \(profileToUpdate?.email ?? "?")-\(profileToUpdate?.name ?? "?")")
//                if let profileToUpdate = profileViewModel.selectedProfile {
                    let newProfileInfo = Profile(
                        email: email,
                        name: name,
                        dateOfBirth: dob,
                        gender: Gender(rawValue: gender)!)
//                    profileToUpdate.email = email
//                    profileToUpdate.name = name
//                    profileToUpdate.dateOfBirth = dob
//                    profileToUpdate.gender = Gender(rawValue: gender)!
//                    profileToUpdate.weight = Float(weight) ?? nil
//                    profileToUpdate.height = Float(height) ?? nil
//                    profileToUpdate.settings?.weightUnit = WeightUnit(rawValue: weightUnit) ?? WeightUnit._rlmDefaultValue()
//                    profileToUpdate.settings?.heightUnit = HeightUnit(rawValue: heightUnit) ?? HeightUnit._rlmDefaultValue()
                    
                    profileViewModel.updateProfile(email: email, with: newProfileInfo)
                    
                    //Harsha: Took out the line below as setting the profile is redundant when the profile is known when the activity begins
//                    profileViewModel.setProfile(byEmail: email)
                    
                    statusMessage = "Profile updated!"
                    shouldNavigateToHome = true
//                } else {
//                    statusMessage = "Error updating profile!"
//                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(gradient)
            .cornerRadius(10)
            .shadow(radius: 10)
            
            // Status Message
            Text(statusMessage)
                .foregroundColor(.red)
                .padding(.top, 10)
            
            // Delete Profile Button
            Button(action: {
                print("FW-[ProfileView]-Delete Button pressed")
                showAlert = true
            }) {
                Text("Delete Account")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding()
                    .background(.red)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .frame(maxWidth: .infinity)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Account Deletion"),
                    message: Text("Are you sure you want to mark your profile for deletion?"),
                    primaryButton: .destructive(Text("Yes, enough already!")) {
                        print("FW-[ProfileView]-Alert primaryButton: Deleting...")
//                        profileViewModel.markProfileForDeletion(profile: profileToUpdate!)
                        profileViewModel.markProfileForDeletion(profile: profileViewModel.selectedProfile!)
                        shouldNavigateToLogin = true
                    },
                    secondaryButton: .cancel(Text("Nevermind, I'll give it another shot")) {
                        print("FW-[ProfileView]-Alert secondaryButton: Cancelled!")
                        showAlert = false
                    }
                )
            }
            .padding(.horizontal, 20)
            
        }
        .padding()
        .onAppear {
            // Set the profile when the view appears
            let currentUser = realmViewModel.currentUser
            email = currentUser!.profile.email!
            profileViewModel.setProfile(byEmail: email)
            profileToUpdate = profileViewModel.selectedProfile
//            if let profile = profileViewModel.selectedProfile {
//                name = profile.name ?? ""
//                email = profile.email ?? ""
//                dob = profile.dateOfBirth ?? Date()
//                weight = "\(profile.weight ?? 0.0)"
//                height = "\(profile.height ?? 0.0)"
//            }
            populateFields()
        }
        
        NavigationLink(destination: LoginView(), isActive: $shouldNavigateToLogin) {
            EmptyView()
        }
        
        NavigationLink(destination: HomePageView(), isActive: $shouldNavigateToHome) {
            EmptyView()
        }
        .navigationBarItems(trailing:
                        NavigationLink(destination: SettingView()) {
                            Image(systemName: "gearshape.fill")
                        }
                    )
    }
    
    func populateFields() {
        print("FW-[ProfileView]-View body: Profile == \(profileViewModel.selectedProfile?.email ?? "?")")
        
        //Pre-populate profile information to be updated
        name = profileToUpdate!.name ?? ""
        email = profileToUpdate!.email
        dob = profileToUpdate!.dateOfBirth ?? Date()
        gender = profileToUpdate!.gender.rawValue
        height = String(profileToUpdate!.height ?? 0)
        weight = String(profileToUpdate!.weight ?? 0)
//        heightUnit = (profileToUpdate!.settings?.heightUnit.rawValue)!
//        weightUnit = (profileToUpdate!.settings?.weightUnit.rawValue)!
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        ProfileView().environmentObject(RealmViewModel(realmApp: realmApp))
//        ProfileView(realmViewModel: RealmViewModel(realmApp: realmApp))
        ProfileView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Plus"))
            .previewDisplayName("iPhone 14 Plus")
//            .previewLayout(.sizeThatFits)
    }
}
