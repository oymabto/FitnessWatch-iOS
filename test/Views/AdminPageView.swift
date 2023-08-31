//
//  AdminPageView.swift
//  test
//
//  Created by Alireza on 2023-08-16.
//

import SwiftUI

struct AdminPageView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    let currentProfile: Profile?
    @State private var searchText: String = ""
    @State private var foundProfile: Profile?
    @State private var showToggleFeedback: Bool = false
    
    @EnvironmentObject var realmViewModel: RealmViewModel
    @State private var output = ""
    @State private var shouldNavigateToLogin: Bool = false
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("Admin Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(gradient)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Text("Welcome back \(currentProfile?.name ?? "Admin")!")
                    .font(.headline)
                    .foregroundColor(.black)
            
            //TODO: Allow the keyboard to show
            //TODO: Bring focus back to text field after an unsuccessful result
            let textField = Section(header: Text("Email:") ) {
                TextField("Search by email", text: $searchText, onCommit: {
                    profileViewModel.setProfile(byEmail: searchText)
                    foundProfile = profileViewModel.selectedProfile
                    if profileViewModel.fetchProfilesByPartialMatch(byEmail: searchText).count > 0 {
                        foundProfile = profileViewModel.fetchProfilesByPartialMatch(byEmail: searchText)[0]
                    }
                    let results = profileViewModel.fetchProfilesByPartialMatch(byEmail: searchText)
                    print("FW-[AdminPageView]-onCommit: Profiles found == \(results.count)")
                    ForEach(results) { result in
                        Text("Email: \(result.email)")
                            .padding()
                    }
                })
                //Harsha: below 2 lines prevent many annoying adjustments to what we type
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .shadow(radius: 2)
            
            let searchButton = Button(action: {
                profileViewModel.setProfile(byEmail: searchText)
                foundProfile = profileViewModel.selectedProfile
                if profileViewModel.fetchProfilesByPartialMatch(byEmail: searchText).count > 0 {
                    foundProfile = profileViewModel.fetchProfilesByPartialMatch(byEmail: searchText)[0]
                }
                let results = profileViewModel.fetchProfilesByPartialMatch(byEmail: searchText)
                print("FW-[AdminPageView]-Button action: Profiles found == \(results.count)")
                ForEach(results) { result in
                    Text("Email: \(result.email)")
                        .padding()
                }
            }) {
                Text("Search")
                    .foregroundColor(.black)
                    .padding(8)
                    /*
                     Below gives following error:
                     Instance method 'background(_:ignoresSafeAreaEdges:)' requires that 'some View' conform to 'ShapeStyle'
                     .background(UIColor.lightGray)
                     */
                    .background(.tertiary)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            
            //Grouped the two elements horizontally to reflect the design mockup
            HStack () {
                textField
                searchButton
            }
            
            if !searchText.isEmpty {
                Text("Hit search or '⏎' when ready 😎")
                    .foregroundColor(.green)
            } else if searchText.isEmpty {
                Text("Enter *ANY* part of an email to begin! 😉")
                    .foregroundColor(.blue)
            }
            
            if let profile = foundProfile {
                UserDetailsView(profile: profile, toggleAction: {
                    profileViewModel.toggleProfileStatus(for: profile)
                    showToggleFeedback.toggle()
                })
                .alert(isPresented: $showToggleFeedback) {
                    Alert(title: Text("Status Changed"), message: Text("User status has been \(profile.isEnabled ? "enabled" : "disabled")."), dismissButton: .default(Text("OK")))
                }
            } else {
                Text("No matches yet...")
                    .foregroundColor(.red)
            }
            
            //Logout method; the chosen method (of 3) to logout a user
            //TODO: use the function in realmViewModel
            Button(action: {
                realmViewModel.logoutV2()
                print("FW-[AdminPageView]-logout Button: CurrentUser == \(realmViewModel.realmApp.currentUser?.id ?? "?")")
                shouldNavigateToLogin = true
            }) {
                Text("Logout")
                    .padding()
                    .foregroundColor(.white)
                    .background(.purple)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            
            NavigationLink(destination: LoginView(), isActive: $shouldNavigateToLogin) {
                EmptyView()
            }
            
            Spacer()
        }
        .padding()
        .background(gradient.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}

struct AdminPageView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPageView(currentProfile: Profile.init())
    }
}

struct UserDetailsView: View {
    var profile: Profile
    var toggleAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Name: \(profile.name ?? "N/A")")
                .font(.headline)
                .foregroundColor(.black)
            Text("Email: \(profile.email)")
                .font(.subheadline)
                .foregroundColor(.black)
            Button(action: toggleAction) {
                Text(profile.isEnabled ? "Disable" : "Enable")
                    .foregroundColor(.white)
                    .padding()
                    .background(profile.isEnabled ? Color.red : Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(profile: Profile(), toggleAction: {})
    }
}

/// A button that handles logout requests.
struct LogoutButton: View {
    @EnvironmentObject var realmViewModel: RealmViewModel
    @State private var shouldNavigateToLogin: Bool = false
    
    @State var isLoggingOut = false
    var body: some View {
        Button("Log Out") {
            guard let user = realmViewModel.currentUser else {
                return
            }
            isLoggingOut = true
            Task {
                do {
                    try await user.logOut()
                    // Other views are observing the app and will detect
                    // that the currentUser has changed. Nothing more to do here.
                    shouldNavigateToLogin = true
                    print("FW-[AdminPageView]-LogoutButton: Logging out was successful!")
                    print("FW-[AdminPageView]-LogoutButton: CurrentUser == \(realmViewModel.realmApp.currentUser?.id ?? "?")")
                } catch {
                    print("FW-[AdminPageView]-LogoutButton: Error logging out: \(error.localizedDescription)")
                }
            }
        }.disabled(realmViewModel.currentUser == nil || isLoggingOut)
        
        NavigationLink(destination: LoginView(), isActive: $shouldNavigateToLogin) {
            EmptyView()
        }
    }
}
