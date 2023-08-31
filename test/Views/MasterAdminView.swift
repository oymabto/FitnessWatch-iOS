//
//  MasterAdminView.swift
//  test
//
//  Created by HK on 2023-08-18.
//

import SwiftUI

struct MasterAdminView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State private var searchText: String = ""
    @State private var foundProfile: Profile?
    @State private var showToggleFeedback: Bool = false
    
    @EnvironmentObject var realmViewModel: RealmViewModel
    @State private var shouldNavigateToLogin: Bool = false
    @State private var shouldNavigateToRegister: Bool = false
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }


    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("Master Admin Dashboard")
                .padding()
                .foregroundColor(.blue)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                
                .background(gradient)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Text("Welcome back \(realmViewModel.currentProfile?.name ?? "Master Admin")!")
                .font(.title2)
                .font(.system(size: 24))
                .foregroundColor(.black)
            
            Button(action: {
                shouldNavigateToRegister = true
            }) {
                Text("⚡ And on the 7th day... God created an ADMIN ⚡")
                    .padding()
                    .foregroundColor(.black)
                    .background(.cyan)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .fontWeight(.bold)
            }
            
            //Logout method; the chosen method (of 3) to logout a user
            //TODO: use the function in realmViewModel
            Button(action: {
                realmViewModel.logoutV2()
                print("FW-[MasterAdminPageView]-logout Button: CurrentUser == \(realmViewModel.realmApp.currentUser?.id ?? "?")")
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
        
        NavigationLink(destination: AdminRegisterView(), isActive: $shouldNavigateToRegister) {
            EmptyView()
        }
    }
}

struct MasterAdminView_Previews: PreviewProvider {
    static var previews: some View {
        MasterAdminView()
    }
}
