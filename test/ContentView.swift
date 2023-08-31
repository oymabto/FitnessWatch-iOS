//
//  ContentView.swift
//  test
//
//  Created by Alireza on 2023-08-11.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: RealmViewModel
    
    var body: some View {
        NavigationView {
            LoginView()
//                    RegisterView()
//                    ProfileView()
//            MMRView()
//                    HomePageView()
            //                   DailyIntakeCalorieView()
            //                   HealthHistoryView()
            //        }.navigationViewStyle(StackNavigationViewStyle())
            //        ExerciseView()
//                    FitnessAPIListView().environmentObject(FitnessAPIViewModel())
            //        MapView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RealmViewModel(realmApp: realmApp))
    }
}

