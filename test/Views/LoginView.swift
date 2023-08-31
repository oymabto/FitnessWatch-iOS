//
//  LoginView.swift
//  test
//
//  Created by Alireza on 2023-08-12.
//

//
//  LoginView.swift
//  test
//
//  Created by Alireza on 2023-08-12.
//

import Foundation
import SwiftUI
import RealmSwift

struct LoginModifier: ViewModifier {

    var borderColor: Color = Color.gray
    
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(borderColor, lineWidth: 1))
    }
}

struct SecureTextFieldWithReveal: View {
    
    @FocusState var focus1: Bool
    @FocusState var focus2: Bool
    @State var showPassword: Bool = false
    @State var text: String = ""
    
    var body: some View {
        HStack {
            ZStack(alignment: .trailing) {
                TextField("Enter your password", text: $text)
                    .modifier(LoginModifier())
                    .textContentType(.password)
                    .focused($focus1)
                    .opacity(showPassword ? 1 : 0)
                SecureField("Enter your password", text: $text)
                    .modifier(LoginModifier())
                    .textContentType(.password)
                    .focused($focus2)
                    .opacity(showPassword ? 0 : 1)
                Button(action: {
                    showPassword.toggle()
                    if showPassword { focus1 = true } else { focus2 = true }
                }, label: {
                    Image(systemName: self.showPassword ? "eye.slash.fill" : "eye.fill").font(.system(size: 16, weight: .regular))
                        .padding()
                })
            }
        }
    }
}

struct SecureTextField: View {
    @State var placeholderText: String = ""
    @State private var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField(placeholderText, text: $text)
                    .modifier(LoginModifier())
                    .textContentType(.password)
            } else {
                TextField(placeholderText, text: $text)
                    .modifier(LoginModifier())
                    .textContentType(.password)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash.fill": "eye.fill")
                .font(.system(size: 16, weight: .bold))
                .padding()
                .foregroundColor(.blue)
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}

struct LoginView: View {
    
    @EnvironmentObject var realmViewModel: RealmViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var shouldNavigateToProfile: Bool = false
    @State private var shouldNavigateToRegister: Bool = false
    @State private var showAlert: Bool = false
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                
                // Logo
                HStack {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    Spacer()
                }
                .frame(height: geometry.size.height / 3)
                
                Spacer().frame(height: 20)
                
                // Sign In title
                Text("Sign In")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                
                // Welcome message
                Text("Hi There! Nice to see you again.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                
                // Form
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(.red)
                        TextField("Enter your email", text: $email)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            //Harsha: replaced above by below to have same look as password entry
                            .modifier(LoginModifier())
                            //Harsha: below 2 lines prevent many annoying adjustments to what we type
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                    }
                    
                    //TODO: Put a toggle for showing password
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.red)
                        //Old entry
//                        SecureField("Enter your password", text: $password)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .disableAutocorrection(true)
//                            .textInputAutocapitalization(.never)
//                        SecureTextFieldWithReveal(text: password)
                        //Above isn't as great. Below seems better!
                        SecureTextField(placeholderText: "Enter your password", text: $password)
                    }
                }
                .padding(.horizontal, 20)
                
                // Sign In Button
                Button(action: {
                    print("[LoginView] Login button pressed")
                    realmViewModel.loginWithEmail(email: email, password: password) { result in
                        DispatchQueue.main.async {
                            print("[LoginView] Inside loginWithEmail completion")
                            switch result {
                            case .success:
                                realmViewModel.checkUserType(email: email)
                                
                                if let currentProfile = realmViewModel.currentProfile, !currentProfile.isEnabled ||
                                    currentProfile.isDeleted {
                                    let currentUser = realmViewModel.currentUser
                                    if (!currentProfile.isEnabled) {
                                        alertTitle = "Account Disabled"
                                        alertMessage = "Your account has been disabled."
                                        print("FW-[LoginView]-loginWithEmail Sign In button: Disabled notification triggered")
                                        showAlert = true
                                    } else if (currentProfile.isDeleted) {
                                        alertTitle = "Account Deleted"
                                        alertMessage = "Your account has been deleted."
                                        //TODO: Give user a choice to undo delete
                                        print("FW-[LoginView]-loginWithEmail Sign In button: Deleted notification triggered")
                                        showAlert = true
                                    }
                                    print("FW-[LoginView]-loginWithEmail Sign In button action: CurrentUser == \(currentUser?.id ?? "?")")
                                } else {
                                    shouldNavigateToProfile = true
                                }
                            case .failure(let error):
                                print("Login error: \(error)")
                            }
                        }
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(gradient)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .padding(.horizontal, 20)
                
                //Harsha: Temp buttons for easy login/logout
                HStack(spacing: 10) {
                    Button(action: {
                        realmViewModel.loginWithEmail(email: "test@test.io", password: "123456") { result in
                            DispatchQueue.main.async {
                                print("[LoginView] Inside loginWithEmail completion")
                                switch result {
                                case .success:
                                    realmViewModel.checkUserType(email: email)
                                    
                                    if let currentProfile = realmViewModel.currentProfile, !currentProfile.isEnabled ||
                                        currentProfile.isDeleted {
                                        let currentUser = realmViewModel.currentUser
                                        if (!currentProfile.isEnabled) {
                                            alertTitle = "Account Disabled"
                                            alertMessage = "Your account has been disabled."
                                            print("FW-[LoginView]-loginWithEmail Regular button: Disabled notification triggered")
                                            showAlert = true
                                        } else if (currentProfile.isDeleted) {
                                            alertTitle = "Account Deleted"
                                            alertMessage = "Your account has been deleted."
                                            //TODO: Give user a choice to undo delete
                                            print("FW-[LoginView]-loginWithEmail Regular button: Deleted notification triggered")
                                            showAlert = true
                                        }
                                        print("FW-[LoginView]-loginWithEmail Regular button action: CurrentUser == \(currentUser?.id ?? "?")")
                                    } else {
                                        shouldNavigateToProfile = true
                                    }
                                case .failure(let error):
                                    print("Login error: \(error)")
                                }
                            }
                        }
                    }) {
                        Text("Regular")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(10)
                            .shadow(radius: 5)
//                            .frame(maxWidth: .infinity)
                    }
                    Button(action: {
                        realmViewModel.loginWithEmail(email: "Test1@test.io", password: "12345678") { result in
                            DispatchQueue.main.async {
                                print("[LoginView] Inside loginWithEmail completion")
                                switch result {
                                case .success:
                                    realmViewModel.checkUserType(email: email)
                                    
                                    if let currentProfile = realmViewModel.currentProfile, !currentProfile.isEnabled ||
                                        currentProfile.isDeleted {
                                        let currentUser = realmViewModel.currentUser
                                        if (!currentProfile.isEnabled) {
                                            alertTitle = "Account Disabled"
                                            alertMessage = "Your account has been disabled."
                                            print("FW-[LoginView]-loginWithEmail Admin button: Disabled notification triggered")
                                            showAlert = true
                                        } else if (currentProfile.isDeleted) {
                                            alertTitle = "Account Deleted"
                                            alertMessage = "Your account has been deleted."
                                            //TODO: Give user a choice to undo delete
                                            print("FW-[LoginView]-loginWithEmail Admin button: Deleted notification triggered")
                                            showAlert = true
                                        }
                                        print("FW-[LoginView]-loginWithEmail Admin button action: CurrentUser == \(currentUser?.id ?? "?")")
                                    } else {
                                        shouldNavigateToProfile = true
                                    }
                                case .failure(let error):
                                    print("Login error: \(error)")
                                }
                            }
                        }
                    }) {
                        Text("Admin")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(10)
                            .shadow(radius: 5)
//                            .frame(maxWidth: .infinity)
                    }
                    Button(action: {
                        realmViewModel.loginWithEmail(email: "admin@fitnesswatch.io", password: "adminadmin") { result in
                            DispatchQueue.main.async {
                                print("[LoginView] Inside loginWithEmail completion")
                                switch result {
                                case .success:
                                    realmViewModel.checkUserType(email: email)
                                    
                                    if let currentProfile = realmViewModel.currentProfile, !currentProfile.isEnabled ||
                                        currentProfile.isDeleted {
                                        let currentUser = realmViewModel.currentUser
                                        if (!currentProfile.isEnabled) {
                                            alertTitle = "Account Disabled"
                                            alertMessage = "Your account has been disabled."
                                            print("FW-[LoginView]-loginWithEmail Master Admin button: Disabled notification triggered")
                                            showAlert = true
                                        } else if (currentProfile.isDeleted) {
                                            alertTitle = "Account Deleted"
                                            alertMessage = "Your account has been deleted."
                                            //TODO: Give user a choice to undo delete
                                            print("FW-[LoginView]-loginWithEmail Master Admin button: Deleted notification triggered")
                                            showAlert = true
                                        }
                                        print("FW-[LoginView]-loginWithEmail Master Admin button action: CurrentUser == \(currentUser?.id ?? "?")")
                                    } else {
                                        shouldNavigateToProfile = true
                                    }
                                case .failure(let error):
                                    print("Login error: \(error)")
                                }
                            }
                        }
                    }) {
                        Text("Master Admin")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(10)
                            .shadow(radius: 5)
//                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
                
                HStack(spacing: 20) {
                    Button("Forgot Password?") {
                        //TODO: Implement Forgot Password Logic
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button("Sign Up") {
                        shouldNavigateToRegister = true
                    }
                    .foregroundColor(.red)
                }
                .padding(.horizontal, 20)
                
                NavigationLink(destination: typeErasedView(for: realmViewModel.userRole), isActive: $shouldNavigateToProfile) {
                    EmptyView()
                }
                
                NavigationLink(destination: RegisterView(), isActive: $shouldNavigateToRegister) {
                    EmptyView()
                }
                
            }
            .padding(20)
            .navigationBarBackButtonHidden(true)
            .background(Color("Background").edgesIgnoringSafeArea(.all))
            /*
             Harsha:
             Above line produces the following print:
             No color named 'Background' found in asset catalog for main bundle
             TODO: Alireza
             */
        }
    }
    
    func typeErasedView(for role: UserRole) -> AnyView {
        switch role {
        case .Admin:
            return AnyView(AdminPageView(currentProfile: realmViewModel.currentProfile))
        case .Regular:
            return AnyView(HomePageView())
        case .MasterAdmin:
            //TODO: Divert to the new UI once completed
            return AnyView(MasterAdminView())
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(RealmViewModel(realmApp: realmApp))
    }
}
