//
//  RegisterView.swift
//  test
//
//  Created by Alireza on 2023-08-12.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    
    @State private var emailAddress = ""
    @State private var name = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var day: String = "Day"
    @State private var month: String = "Month"
    @State private var year: String = "Year"
    @State private var dob: Date?
    @State private var gender = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var heightUnit = ""
    @State private var weightUnit = ""
    
    var days: [String] = ["Day"] + Array(1...31).map { String($0) }
    var months: [String] = ["Month"] + Array(1...12).map { String($0) }
    var years: [String] = ["Year"] + Array(1900...2023).map { String($0) }
//    var genders = ["Male", "Female"]
//    var heightUnits = ["cm", "m"]
//    var weightUnits = ["kg", "lbs"]
    var genders = Gender.allCases.map { $0.rawValue }
    var heightUnits = HeightUnit.allCases.map { $0.rawValue }
    var weightUnits = WeightUnit.allCases.map { $0.rawValue }
    
    @State private var shouldNavigateToLogin: Bool = false
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                // Title
                Text("Sign Up")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .padding(.top)
                    //TODO: Check below line when Preview works (Harsha)
//                    .padding(.leading, 20)
                
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
                    let textFieldPass = SecureTextField(placeholderText:"Enter your password", text: $password)
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
                
                // Date of Birth
                HStack(spacing: 10) {
                    Text("Date of Birth:")
                        .font(.subheadline) // Adjusted the font here
                    Picker(selection: $day, label: Text(day)) {
                        ForEach(days, id: \.self) {
                            Text($0).font(.subheadline)
                        }
                    }
                    
                    .labelsHidden()
//                    .frame(width: 100, height: 100)
                    .frame(height: 80)
                    .clipped()
                    .font(.subheadline) // Adjusted the font for the picker here
                    
                    Picker(selection: $month, label: Text(month)) {
                        ForEach(months, id: \.self) {
                            Text($0).font(.subheadline)
                        }
                    }
                    
                    .labelsHidden()
//                    .frame(width: 100, height: 100)
                    .frame(height: 80)
                    .clipped()
                    .font(.subheadline) // Adjusted the font for the picker here
                    
                    Picker(selection: $year, label: Text(year)) {
                        ForEach(years, id: \.self) {
                            Text($0).font(.subheadline)
                        }
                    }
                    
                    .labelsHidden()
//                    .frame(width: 100, height: 100)
                    .frame(height: 80)
                    .clipped()
                    .font(.subheadline) // Adjusted the font for the picker here
                }
                
                let dob: Date? = {
                    if day == "Day" || month == "Month" || year == "Year" {
                        return nil
                    }
                    return profileViewModel.convertToDate(day: day, month: month, year: year)
                }()
                
                // Gender
                Picker("Gender", selection: $gender) {
                    ForEach(genders, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // Height
                HStack {
                    VerifiedTextFieldOptional(placeholder: "Height", text: $height)
                        .keyboardType(.numberPad)
                    Picker("", selection: $heightUnit) {
                        ForEach(heightUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Weight
                HStack {
                    VerifiedTextFieldOptional(placeholder: "Weight", text: $weight)
                        .keyboardType(.numberPad)
                    Picker("", selection: $weightUnit) {
                        ForEach(weightUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Sign Up Button
                if !(emailAddress.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty || (password != confirmPassword)) {
                    Button(action: {
                        let heightFloat = Float(height)
                        let weightFloat = Float(weight)
                        print("FW-[RegisterView]-Sign Up Button: About to call registerProfile with email: \(emailAddress)")
                        profileViewModel.registerProfile(role: UserRole.Regular, email: emailAddress, password: password, name: name, dob: dob, gender: Gender(rawValue: gender) ?? Gender._rlmDefaultValue(), weight: weightFloat, height: heightFloat)
                        //TODO: Finish implementing once checks are made for selecting &/or typing weight/height
//                      profileViewModel.registerProfileWithUnits(role: UserRole.Regular, email: emailAddress, password: password, name: name, dob: dob, weight: weightFloat, weightUnit: WeightUnit(rawValue: weightUnit)!, height: heightFloat, heightUnit: HeightUnit(rawValue: heightUnit)!)
                        if profileViewModel.registrationSuccessful {
                            print("FW-[RegisterView]-Sign Up Button: Registration was successful.")
                            shouldNavigateToLogin = true
                        }else {
                            print("FW-[RegisterView]-Sign Up Button: Registration failed.")
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
                
                //TODO: Bring back when routing is fixed
//                HStack(spacing: 20) {
//                    Spacer()
//
//                    Button("Sign In") {
//                        shouldNavigateToLogin = true
//                    }
//                    .foregroundColor(.blue)
//                }
//                .padding(.horizontal, 20)
            }
            .padding()
            //TODO: Bring this back when the routing is fixed
//            .navigationBarBackButtonHidden(true)
            
            NavigationLink(destination: LoginView(), isActive: $shouldNavigateToLogin) {
                EmptyView()
            }
        }
    }
}

struct VerifiedTextFieldRequired: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
            if text.isEmpty {
                Text("*")
                    .foregroundColor(.red)
            }
        }
    }
}

struct VerifiedTextFieldOptional: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct VerifiedSecureField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            SecureField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if text.isEmpty {
                Text("*")
                    .foregroundColor(.red)
            }
        }
    }
}

struct VerifiedPicker: View {
    var items: [String]
    @Binding var selection: String?
    
    var body: some View {
        HStack {
            Picker("", selection: $selection) {
                ForEach(items, id: \.self) {
                    Text($0)
                }
            }
            .labelsHidden()
            .frame(width: 80, height: 80)
            .clipped()
            
            if selection == nil || (selection == items.first) {
                Text("*")
                    .foregroundColor(.red)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
