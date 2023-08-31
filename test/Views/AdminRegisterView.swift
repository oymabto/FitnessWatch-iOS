//
//  AdminRegisterView.swift
//  test
//
//  Created by HK on 2023-08-18.
//

import SwiftUI

struct AdminRegisterView: View {
    
    @State private var emailAddress = ""
    @State private var name = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var day: String = "Day"
    @State private var month: String = "Month"
    @State private var year: String = "Year"
    @State private var dob: Date?
    @State private var gender = ""
//    @State private var height = ""
//    @State private var weight = ""
//    @State private var heightUnit = ""
//    @State private var weightUnit = ""
    
    var days: [String] = ["Day"] + Array(1...31).map { String($0) }
    var months: [String] = ["Month"] + Array(1...12).map { String($0) }
    var years: [String] = ["Year"] + Array(1900...2023).map { String($0) }
//    var genders = ["Male", "Female"]
//    var heightUnits = ["cm", "m"]
//    var weightUnits = ["kg", "lbs"]
    var genders = Gender.allCases.map { $0.rawValue }
//    var heightUnits = HeightUnit.allCases.map { $0.rawValue }
//    var weightUnits = WeightUnit.allCases.map { $0.rawValue }
    
    @State private var shouldNavigateToMasterAdmin: Bool = false
    @State private var buttonIsDisabled: Bool = true
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                // Title
                Text("Create a new ADMIN")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("*Required fields")
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 10)
                
                // Fields
                Group {
                    let labelEmail = Text("Email:")
                        .font(.headline)
                        .foregroundColor(.red)
                    let labelName = Text("Name:")
                        .font(.headline)
                        .foregroundColor(.red)
                    let labelPass = Text("Password: ")
                        .font(.headline)
                        .foregroundColor(.red)
                    let labelConf = Text("Confirmed:")
                        .font(.headline)
                        .foregroundColor(.red)
                    let textFieldEmail = VerifiedTextFieldRequired(placeholder: "Enter Email Address", text: $emailAddress)
                        .modifier(LoginModifier())
                    let textFieldName = VerifiedTextFieldRequired(placeholder: "Enter Name", text: $name)
                        .modifier(LoginModifier())
//                    VerifiedSecureField(placeholder: "Enter Password", text: $password)
//                    VerifiedSecureField(placeholder: "Confirm Password", text: $confirmPassword)
                    let textFieldPass = SecureTextField(placeholderText:"Enter a password", text: $password)
                    let textFieldConf = SecureTextField(placeholderText:"Confirm password", text: $confirmPassword)
                    
                    HStack () {
                        labelEmail
                        textFieldEmail
                    }
                    HStack () {
                        labelName
                        textFieldName
                    }
                    HStack () {
                        labelPass
                        textFieldPass
                    }
                    HStack () {
                        labelConf
                        textFieldConf
                    }
                }
                
                
                // Gender
                Picker("Gender", selection: $gender) {
                    ForEach(genders, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
//                // Height
//                HStack {
//                    VerifiedTextFieldOptional(placeholder: "Height", text: $height)
//                        .keyboardType(.numberPad)
//                    Picker("", selection: $heightUnit) {
//                        ForEach(heightUnits, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                    .labelsHidden()
//                    .pickerStyle(SegmentedPickerStyle())
//                }
//
//                // Weight
//                HStack {
//                    VerifiedTextFieldOptional(placeholder: "Weight", text: $weight)
//                        .keyboardType(.numberPad)
//                    Picker("", selection: $weightUnit) {
//                        ForEach(weightUnits, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                    .labelsHidden()
//                    .pickerStyle(SegmentedPickerStyle())
//                }
                
                HStack {
                    // Sign Up Button
//                    let signUpButton = Button(action: {
                    if !(emailAddress.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty || (password != confirmPassword)) {
                        Button(action: {
                            //                        let heightFloat = Float(height)
                            //                        let weightFloat = Float(weight)
                            print("FW-[AdminRegisterView]-Sign Up Button: About to call registerProfile with email: \(emailAddress)")
//                            viewModel.registerProfile(role: UserRole.Admin, email: emailAddress, password: password, name: name, dob: dob, gender: Gender(rawValue: gender) ?? Gender._rlmDefaultValue(), weight: weightFloat, height: heightFloat)
                            profileViewModel.registerAdmin(role: UserRole.Admin, email: emailAddress, password: password, name: name, dob: dob, gender: Gender(rawValue: gender) ?? Gender._rlmDefaultValue())
                            if profileViewModel.registrationSuccessful {
                                print("FW-[AdminRegisterView]-Sign Up Button: Registration was successful.")
                                shouldNavigateToMasterAdmin = true
                            }else {
                                print("FW-[AdminRegisterView]-Sign Up Button: Registration failed.")
                            }
                        }) {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(gradient)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                        .padding(.horizontal, 20)
                    } else {
                        Button(action: {}) {
                            Text("Sign Up")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .disabled(true)
                        }
                        .background(.gray)
                        .opacity(0.5)
                        .disabled(true)
                    }
                    
                    // Cancel Button
                    Button(action: {
                        print("FW-[AdminRegisterView]-Cancel Button: Heading back to the Master Admin View")
                        shouldNavigateToMasterAdmin = true
                    }) {
                        Text("Close")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.gray)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .padding(.horizontal, 20)
                }
                
                NavigationLink(destination: MasterAdminView(), isActive: $shouldNavigateToMasterAdmin) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

struct AdminRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        AdminRegisterView()
    }
}
