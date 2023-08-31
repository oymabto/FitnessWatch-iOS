//
//  SettingView.swift
//  test
//
//  Created by Alireza on 2023-08-18.
//

// SettingView.swift
import SwiftUI

struct SettingView: View {
    @State private var weightUnit: String = "lbs"
    @State private var heightUnit: String = "cm"
    @State private var distanceUnit: String = "km"
    
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    @StateObject private var profileViewModel = ProfileViewModel()
    @EnvironmentObject private var realmViewModel: RealmViewModel
    @State private var profileToUpdate: Profile?
    @State private var emailAddress: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Units")) {
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Weight Unit")
                                Spacer()
                                Picker("", selection: $weightUnit) {
                                    Text("kg").tag("kg")
                                    Text("lb").tag("lbs")
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .frame(width: geometry.size.width / 2)
                            }
                            
                            HStack {
                                Text("Height Unit")
                                Spacer()
                                Picker("", selection: $heightUnit) {
                                    Text("cm").tag("cm")
                                    Text("m").tag("m")
                                    Text("ft").tag("ft")
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .frame(width: geometry.size.width / 2)
                            }
                            
                            HStack {
                                Text("Distance Unit")
                                Spacer()
                                Picker("", selection: $distanceUnit) {
                                    Text("km").tag("km")
                                    Text("mi").tag("mi")
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .frame(width: geometry.size.width / 2)
                            }
                        }
                        .frame(height: 150)
                    }
                    .frame(height: 150)
                }
            }
            Form {
                let labelPass = Text("Old Password:  ")
                    .font(.headline)
                    .foregroundColor(.red)
                let labelNewPass = Text("New Password: ")
                    .font(.headline)
                    .foregroundColor(.red)
                let labelConf = Text("New Confirmed:")
                    .font(.headline)
                    .foregroundColor(.red)
//                let textFieldOldPass = SecureTextField(placeholderText:"Your current password", text: $oldPassword)
//                let textFieldNewPass = SecureTextField(placeholderText:"The new password", text: $newPassword)
//                let textFieldConf = SecureTextField(placeholderText:"The new password again", text: $confirmPassword)
//                HStack () {
//                    labelPass
//                    textFieldOldPass
//                }
//                HStack () {
//                    labelNewPass
//                    textFieldNewPass
//                }
//                HStack () {
//                    labelConf
//                    textFieldConf
//                }
                
                // Simpler display
                let textFieldOldPass = SecureTextField(placeholderText:"Enter your current password", text: $oldPassword)
                let textFieldNewPass = SecureTextField(placeholderText:"Enter a new password", text: $newPassword)
                let textFieldConf = SecureTextField(placeholderText:"Enter the new password again", text: $confirmPassword)
                textFieldOldPass
                textFieldNewPass
                textFieldConf
                
                //TODO: Button for the password update
                // Change Password Button
                HStack {
                    if !(oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty || (newPassword != confirmPassword)) {
                        Button(action: {
                            let currentUser = realmViewModel.currentUser
                            emailAddress = currentUser!.profile.email!
                            profileViewModel.setProfile(byEmail: emailAddress)
                            profileToUpdate = profileViewModel.selectedProfile
//                            profileViewModel.setProfile(byEmail: emailAddress)
//                            profileToUpdate = profileViewModel.selectedProfile
                            
                            print("FW-[SettingView]-Update Password Button: About to call registerProfile with email: \(emailAddress)")
                            profileViewModel.updatePassword(email: emailAddress, with: profileToUpdate!, newPassword: newPassword)
                            showAlert = true
//                            if profileViewModel.registrationSuccessful {
//                                print("FW-[SettingView]-Update Password Button: Registration was successful.")
//                            }else {
//                                print("FW-[SettingView]-Update Password Button: Registration failed.")
//                            }
                        }) {
                            Text("Update Password")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(gradient)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                        .padding(.horizontal, 20)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Password Update"),
                                message: Text("Your password has been updated!"),
                                dismissButton: .default(Text("OK")))
                        }
                    } else {
                        Button(action: {}) {
                            Text("Update Pasword")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .disabled(true)
                        }
                        .padding(.horizontal, 20)
                        .background(.gray)
                        .opacity(0.5)
                        .disabled(true)
                    }
                    
                    // Cancel Button
//                    Button(action: {
//                        print("FW-[SettingView]-Cancel Button: Heading back to the Master Admin View")
//                        shouldNavigateToMasterAdmin = true
//                    }) {
//                        Text("Close")
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(.gray)
//                            .cornerRadius(10)
//                            .shadow(radius: 10)
//                    }
//                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
